#include "eager_search.h"

#include "../evaluation_context.h"
#include "../globals.h"
#include "../heuristic.h"
#include "../open_list_factory.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../algorithms/ordered_set.h"
#include "../task_utils/successor_generator.h"

#include <cassert>
#include <cstdlib>
#include <memory>
#include <set>
#include <unordered_map>

using namespace std;

namespace fwdbwd{

    std::unordered_map<OperatorID, std::vector<OperatorID> > dependency_map;
    OpStackNode stack_root = OpStackNode(OperatorID::no_operator, NULL);

    bool are_dependent(EffectsProxy eff, PreconditionsProxy pre)
    {
        // return true if there are some common facts else false
        for(EffectProxy e: eff)
            for (FactProxy p : pre)
                if(p == e.get_fact())
                    return true;
        return false;
    }


    void generate_dependency_graph(TaskProxy task_proxy)
    {
        OperatorsProxy operators = task_proxy.get_operators();
        
        for (OperatorProxy op1 : operators)
            for(OperatorProxy op2 : operators)
            {
                if(op1 != op2)
                {
                    EffectsProxy eff1 = op1.get_effects();
                    PreconditionsProxy pre2 = op2.get_preconditions();
                    if(are_dependent(eff1, pre2))
                        dependency_map[op1.get_gid()].push_back(op2.get_gid());
                }
            }
    }

    vector<FwdbwdOps> generate_fwdbwd_ops(vector<OperatorID> applicable_ops, OperatorID op_id)
    {
        vector<OperatorID> base_ops;
        
        if(op_id == OperatorID::no_operator)
            base_ops = applicable_ops;
        else
            base_ops = dependency_map[op_id];

        vector<FwdbwdOps> fwdbwd_ops;

        for(OperatorID id: base_ops)
        {
            if(find(applicable_ops.begin(), applicable_ops.end(), id) != applicable_ops.end())
                fwdbwd_ops.push_back(make_pair(id, true));
            else
                fwdbwd_ops.push_back(make_pair(id, false));
        }
        return fwdbwd_ops;
    }

}

namespace eager_search {
EagerSearch::EagerSearch(const Options &opts)
    : SearchEngine(opts),
      reopen_closed_nodes(opts.get<bool>("reopen_closed")),
      use_multi_path_dependence(opts.get<bool>("mpd")),
      open_list(opts.get<shared_ptr<OpenListFactory>>("open")->
                create_fwdbwd_open_list()),
      f_evaluator(opts.get<Evaluator *>("f_eval", nullptr)),
      preferred_operator_heuristics(opts.get_list<Heuristic *>("preferred")),
      pruning_method(opts.get<shared_ptr<PruningMethod>>("pruning")) {
}

void EagerSearch::initialize() {
    cout << "Conducting best first search"
         << (reopen_closed_nodes ? " with" : " without")
         << " reopening closed nodes, (real) bound = " << bound
         << endl;
    if (use_multi_path_dependence)
        cout << "Using multi-path dependence (LM-A*)" << endl;
    assert(open_list);

    // fwdbwd code
    fwdbwd::generate_dependency_graph(task_proxy);
    // fwdbwd code

    set<Evaluator *> evals;
    open_list->get_path_dependent_evaluators(evals);

    // Collect path-dependent evaluators that are used for preferred operators
    // (in case they are not also used in the open list).
    for (Heuristic *heuristic : preferred_operator_heuristics) {
        heuristic->get_path_dependent_evaluators(evals);
    }

    // Collect path-dependent evaluators that are used in the f_evaluator.
    // They are usually also used in the open list and will hence already be
    // included, but we want to be sure.
    if (f_evaluator) {
        f_evaluator->get_path_dependent_evaluators(evals);
    }

    path_dependent_evaluators.assign(evals.begin(), evals.end());

    const GlobalState &initial_state = state_registry.get_initial_state();
    for (Evaluator *evaluator : path_dependent_evaluators) {
        evaluator->notify_initial_state(initial_state);
    }

    // Note: we consider the initial state as reached by a preferred
    // operator.
    EvaluationContext eval_context(initial_state, 0, true, &statistics);

    statistics.inc_evaluated_states();

    if (open_list->is_dead_end(eval_context)) {
        cout << "Initial state is a dead end." << endl;
    } else {
        if (search_progress.check_progress(eval_context))
            print_checkpoint_line(0);
        start_f_value_statistics(eval_context);
        SearchNode node = search_space.get_node(initial_state);
        node.open_initial();

        fwdbwd::FwdbwdNode fwdbwd_node(initial_state.get_id(), OperatorID::no_operator, NULL);

        open_list->insert(eval_context, fwdbwd_node);
    }

    print_initial_h_values(eval_context);

    pruning_method->initialize(task);
}

void EagerSearch::print_checkpoint_line(int g) const {
    cout << "[g=" << g << ", ";
    statistics.print_basic_statistics();
    cout << "]" << endl;
}

void EagerSearch::print_statistics() const {
    statistics.print_detailed_statistics();
    search_space.print_statistics();
    pruning_method->print_statistics();
}

SearchStatus EagerSearch::step() {
    pair<fwdbwd::FwdbwdNode, bool> n = fetch_next_node();
    if (!n.second) {
        return FAILED;
    }

    //FWDBWD: Check if this is a backward node.

    fwdbwd::FwdbwdNode fwdbwd_node = n.first;

    StateID id = get<0>(fwdbwd_node);
    GlobalState s = state_registry.lookup_state(id);
    SearchNode node = search_space.get_node(s);

    if (check_goal_and_set_plan(s))
        return SOLVED;

    vector<OperatorID> applicable_ops;
    g_successor_generator->generate_applicable_ops(s, applicable_ops);

    /*
      TODO: When preferred operators are in use, a preferred operator will be
      considered by the preferred operator queues even when it is pruned.
    */
    pruning_method->prune_operators(s, applicable_ops);

    // This evaluates the expanded state (again) to get preferred ops
    EvaluationContext eval_context(s, node.get_g(), false, &statistics, true);
    ordered_set::OrderedSet<OperatorID> preferred_operators =
        collect_preferred_operators(eval_context, preferred_operator_heuristics);

    // FWDBWD: Thread should not come here if the node is not forward node
    vector<fwdbwd::FwdbwdOps> fwdbwd_ops = fwdbwd::generate_fwdbwd_ops(applicable_ops, get<1>(fwdbwd_node));


    for (fwdbwd::FwdbwdOps fwdbwd_op: fwdbwd_ops) {

        OperatorID op_id = fwdbwd_op.first;
        OperatorProxy op = task_proxy.get_operators()[op_id];
        if(fwdbwd_op.second)
        {
            if ((node.get_real_g() + op.get_cost()) >= bound)
                continue;
            GlobalState succ_state = state_registry.get_successor_state(s, op);
            statistics.inc_generated();
            bool is_preferred = preferred_operators.contains(op_id);

            SearchNode succ_node = search_space.get_node(succ_state);

            // Previously encountered dead end. Don't re-evaluate.
            if (succ_node.is_dead_end())
                continue;

            // update new path
            if (use_multi_path_dependence || succ_node.is_new()) {
                for (Evaluator *evaluator : path_dependent_evaluators) {
                    evaluator->notify_state_transition(s, op_id, succ_state);
                }
            }

            if (succ_node.is_new()) {
                int succ_g = node.get_g() + get_adjusted_cost(op);

                EvaluationContext eval_context(
                    succ_state, succ_g, is_preferred, &statistics);
                statistics.inc_evaluated_states();

                if (open_list->is_dead_end(eval_context)) {
                    succ_node.mark_as_dead_end();
                    statistics.inc_dead_ends();
                    continue;
                }
                succ_node.open(node, op);

                fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL);
                open_list->insert(eval_context, succ_fwdbwd_node);
                if (search_progress.check_progress(eval_context)) {
                    print_checkpoint_line(succ_node.get_g());
                    reward_progress();
                }
            } else if (succ_node.get_g() > node.get_g() + get_adjusted_cost(op)) {
                if (reopen_closed_nodes) {
                    if (succ_node.is_closed()) {
                        statistics.inc_reopened();
                    }
                    succ_node.reopen(node, op);

                    EvaluationContext eval_context(
                        succ_state, succ_node.get_g(), is_preferred, &statistics);

                    fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL);
                    open_list->insert(eval_context, succ_fwdbwd_node);
                } else {
                    succ_node.update_parent(node, op);
                }
            }
        }
    }

    return IN_PROGRESS;
}

pair<fwdbwd::FwdbwdNode, bool> EagerSearch::fetch_next_node() {

    while (true) {
        if (open_list->empty()) {
            cout << "Completely explored state space -- no solution!" << endl;
            fwdbwd::FwdbwdNode dummy_node(StateID::no_state, OperatorID::no_operator, NULL);
            return make_pair(dummy_node, false);
        }
        vector<int> last_key_removed;
        fwdbwd::FwdbwdNode fwdbwdNode = open_list->remove_min(
            use_multi_path_dependence ? &last_key_removed : nullptr);

        StateID id = get<0>(fwdbwdNode);
        GlobalState s = state_registry.lookup_state(id);
        SearchNode node = search_space.get_node(s);

        // FWDBWD: Add code for checking if this node is repeated

        // FWDBWD: No need to close nodes
        // if (node.is_closed())
        //     continue;

        // FWDBWD: Pending task
        // if (use_multi_path_dependence) {
        //     assert(last_key_removed.size() == 2);
        //     if (node.is_dead_end())
        //         continue;
        //     int pushed_h = last_key_removed[1];

        //     if (!node.is_closed()) {
        //         EvaluationContext eval_context(
        //             node.get_state(), node.get_g(), false, &statistics);

        //         if (open_list->is_dead_end(eval_context)) {
        //             node.mark_as_dead_end();
        //             statistics.inc_dead_ends();
        //             continue;
        //         }
        //         if (pushed_h < eval_context.get_result(path_dependent_evaluators[0]).get_h_value()) {
        //             assert(node.is_open());
        //             open_list->insert(eval_context, node.get_state_id());
        //             continue;
        //         }
        //     }
        // }

        // FWDBWD: No need to close the nodes
        // node.close();
        assert(!node.is_dead_end());
        update_f_value_statistics(node);
        statistics.inc_expanded();
        return make_pair(fwdbwdNode, true);
    }
}

void EagerSearch::reward_progress() {
    // Boost the "preferred operator" open lists somewhat whenever
    // one of the heuristics finds a state with a new best h value.
    open_list->boost_preferred();
}

void EagerSearch::dump_search_space() const {
    search_space.dump(task_proxy);
}

void EagerSearch::start_f_value_statistics(EvaluationContext &eval_context) {
    if (f_evaluator) {
        int f_value = eval_context.get_heuristic_value(f_evaluator);
        statistics.report_f_value_progress(f_value);
    }
}

/* TODO: HACK! This is very inefficient for simply looking up an h value.
   Also, if h values are not saved it would recompute h for each and every state. */
void EagerSearch::update_f_value_statistics(const SearchNode &node) {
    if (f_evaluator) {
        /*
          TODO: This code doesn't fit the idea of supporting
          an arbitrary f evaluator.
        */
        EvaluationContext eval_context(node.get_state(), node.get_g(), false, &statistics);
        int f_value = eval_context.get_heuristic_value(f_evaluator);
        statistics.report_f_value_progress(f_value);
    }
}
}
