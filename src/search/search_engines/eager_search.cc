#include "eager_search.h"

#include "../evaluation_context.h"
#include "../globals.h"
#include "../heuristic.h"
#include "../open_list_factory.h"
#include "../option_parser.h"
#include "../pruning_method.h"

#include "../algorithms/ordered_set.h"
#include "../task_utils/successor_generator.h"
#include "../task_utils/task_properties.h"
#include "../tasks/root_task.h"

#include <cassert>
#include <cstdlib>
#include <memory>
#include <set>
#include <unordered_map>

using namespace std;

namespace fwdbwd{

    unordered_map<OperatorID, vector<OperatorID> > dependency_map;
    unordered_map<OperatorID, vector<OperatorID> > inverse_map;   
    OpStackNode* stack_root = new OpStackNode(OperatorID::no_operator, NULL);
    unordered_map<StateID, unordered_set<OperatorID> > forward_nodes;
    // stores all the operators that have interacted with the state and save it so that it's not repeated
    unordered_map<StateID, unordered_map<OperatorID, bool> > node_history;
    unordered_map<OperatorID, bool> goal_fact_ops;
    // true if all actions are applied to this node else false;
    unordered_map<StateID, bool> privilege_node;

    /* TODO: This method works with partial TNF only, if in future, SAS TNF is used
    repair this function*/


    void generate_goal_fact_ops(TaskProxy task_proxy)
    {
        for(OperatorProxy operator_proxy: task_proxy.get_operators())
        {
            bool flag = false;
            for (FactProxy goal_fact : task_proxy.get_goals())
            {
                for(EffectProxy effect: operator_proxy.get_effects())
                {
                    FactProxy e = effect.get_fact();
                    if(e == goal_fact)
                    {
                        flag = true;
                        for(FactProxy p: operator_proxy.get_preconditions())
                        {
                            // check if the variable is same
                            // check that the values are opposite
                            if(e.get_variable() == p.get_variable())
                                flag = (e.get_value() == p.get_value())? false: flag;
                        }
                    }
                }
                // important
                if(flag)
                    break;
            }
            goal_fact_ops[operator_proxy.get_gid()] = flag;
        }
    }
    
    bool are_dependent(EffectsProxy eff1, PreconditionsProxy pre1, PreconditionsProxy pre2)
    {
        // return true if there are some common facts else false
        bool flag;
        for (FactProxy p2 : pre2)
        {
            flag = true;
            for(EffectProxy e1: eff1)
            {
                if(p2.get_variable() == e1.get_fact().get_variable())
                {
                    if(p2.get_value() == e1.get_fact().get_value())
                        return true;
                    else
                        flag = false;
                }
            }
            if(flag)
                for(FactProxy p1: pre1)
                    if(p2 == p1)
                        return true;
        }
        return false;
    }

    FwdbwdNode::FwdbwdNode(StateID state_id, OperatorID operator_id, OpStackNode* op_stack_node, int g_value):
    id(state_id), op_id(operator_id)
    {
        op_stack = op_stack_node;
        state_g_value = g_value;
    }

    bool FwdbwdNode::operator<(const FwdbwdNode& rhs) const{
        if(op_stack == NULL && rhs.get_stack_pointer() == NULL)
            return state_g_value < rhs.get_g();

        else if(op_stack != NULL && rhs.get_stack_pointer() != NULL)
            return op_stack->get_depth() < rhs.get_stack_pointer()->get_depth();
        
        else
            return (op_stack == NULL)? true: false;
    }


    void generate_dependency_graph(TaskProxy task_proxy)
    {
        OperatorsProxy operators = task_proxy.get_operators();
        
        for (OperatorProxy op1 : operators)
        {
            for(OperatorProxy op2 : operators)
            {
                if(op1 != op2)
                {
                    PreconditionsProxy pre1 = op1.get_preconditions();
                    PreconditionsProxy pre2 = op2.get_preconditions();
                    EffectsProxy eff2 = op2.get_effects();
                    if(are_dependent(eff2, pre2, pre1))
                    {
                        dependency_map[op1.get_gid()].push_back(op2.get_gid());
                        inverse_map[op2.get_gid()].push_back(op1.get_gid());
                        // cout << op1.get_name() << " gets pre from " << op2.get_name() << endl;
                    }
                }
            }
        }
    }

    bool record_history(StateID id, OperatorID op_id)
    {
        bool value = node_history[id][op_id]; 
        if(!value)
            node_history[id][op_id] = true;
        return value;
    }

    bool check_history(StateID id, OperatorID op_id)
    {
        return node_history[id][op_id];
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
    fwdbwd::generate_goal_fact_ops(task_proxy);
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

        fwdbwd::FwdbwdNode fwdbwd_node(initial_state.get_id(), OperatorID::no_operator, NULL, node.get_real_g());

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

    fwdbwd::FwdbwdNode fwdbwd_node = n.first;

    if(!fwdbwd_node.get_stack_pointer())
    {
        // cout << "Forward Step" << endl;
        return forward_step(fwdbwd_node);
    }
    else
    {
        // cout << "Backward Step" << endl;
        return backward_step(fwdbwd_node);
    }
}

SearchStatus EagerSearch::forward_step(fwdbwd::FwdbwdNode fwdbwd_node)
{
    // Get the search node from id
    StateID id = fwdbwd_node.get_state();
    GlobalState s = state_registry.lookup_state(id);
    SearchNode node = search_space.get_node(s);

    if (check_goal_and_set_plan(s))
        return SOLVED;
    if(fwdbwd::privilege_node[id])
        return IN_PROGRESS;
    

    // pruning_method->prune_operators(s, applicable_ops);

    // This evaluates the expanded state (again) to get preferred ops
    EvaluationContext eval_context(s, node.get_g(), false, &statistics, true);
    ordered_set::OrderedSet<OperatorID> preferred_operators =
        collect_preferred_operators(eval_context, preferred_operator_heuristics);

    vector<fwdbwd::FwdbwdOps> fwdbwd_ops = generate_fwdbwd_ops(s, fwdbwd_node.get_operator());



    for (fwdbwd::FwdbwdOps fwdbwd_op: fwdbwd_ops) {

        OperatorID op_id = fwdbwd_op.first;
        OperatorProxy op = task_proxy.get_operators()[op_id];


        if(fwdbwd::record_history(id, op_id))
            break;

        if(fwdbwd_op.second)
        {
            if ((node.get_real_g() + op.get_cost()) >= bound)
                continue;
            GlobalState succ_state = state_registry.get_successor_state(s, op);
            //FWDBWD: What do they consider when counting generated nodes? What if an old node is generated?
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

                // succ_node.store_foward_operator(op_id);
                fwdbwd::forward_nodes[succ_state.get_id()].insert(op_id);

                fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL, succ_node.get_real_g());
                open_list->insert(eval_context, succ_fwdbwd_node);
                if (search_progress.check_progress(eval_context)) {
                    print_checkpoint_line(succ_node.get_g());
                    reward_progress();
                }
            }
            else{
                if(succ_node.get_g() > node.get_g() + get_adjusted_cost(op))
                    succ_node.update_parent(succ_node, op);
                
                // FWDBWD: Check if the same operator and state pair has not been seen before
                if(fwdbwd::forward_nodes[succ_state.get_id()].find(op_id) == fwdbwd::forward_nodes[succ_state.get_id()].end())
                {
                    fwdbwd::forward_nodes[succ_state.get_id()].insert(op_id);
                    EvaluationContext eval_context(
                        succ_state, succ_node.get_g(), is_preferred, &statistics);
                    fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL, succ_node.get_real_g());
                    open_list->insert(eval_context, succ_fwdbwd_node);
                }
            }   
        }
        else
        {
            // push the current and all it's dependent ones on the stack
            // also check if you've observed the same pair before

            pair<OpStackNode*, bool> first_child = fwdbwd::stack_root->gen_child(op_id, id, op.get_cost());
            if(first_child.second)
            {
                // careful op_id already in use
                for (OperatorID oid: fwdbwd::dependency_map[op_id])
                {
                    if(!fwdbwd::check_history(id, oid))
                    {
                        OperatorProxy op2 = task_proxy.get_operators()[oid];
                        pair<OpStackNode*, bool> second_child = (first_child.first)->gen_child(oid, id, op2.get_cost());
                        if(second_child.second)
                        {
                            fwdbwd::FwdbwdNode succ_fwdbwd_node(id, OperatorID::no_operator, second_child.first, node.get_real_g());
                            open_list->insert(eval_context, succ_fwdbwd_node);
                        }
                    }
                }
            }
        }
    }

    return IN_PROGRESS;


}

SearchStatus EagerSearch::backward_step(fwdbwd::FwdbwdNode fwdbwd_node)
{
    OpStackNode* op_stack_node = fwdbwd_node.get_stack_pointer();
    assert(op_stack_node != NULL);

    StateID id = fwdbwd_node.get_state();
    GlobalState s = state_registry.lookup_state(id);
    SearchNode node = search_space.get_node(s);

    OperatorID op_id = op_stack_node->get_operator();
    OperatorProxy op = task_proxy.get_operators()[op_id];

    // if(!fwdbwd::check_history(id, op_id))
    //     return IN_PROGRESS;

    EvaluationContext eval_context(s, node.get_g(), false, &statistics, true);

    ordered_set::OrderedSet<OperatorID> preferred_operators =
        collect_preferred_operators(eval_context, preferred_operator_heuristics);
    
    // OPTIMIZE: no need to generate all applicable ops, just check if op is applicable in state
    if(task_properties::is_applicable(op, convert_global_state(s)))
    {
        // apply the top stack operator to the current state
        // and push the data entry into the new stack
        // if the current operator_stack_pointer is equal to stack_root
        // then stop the search
        bool is_preferred = preferred_operators.contains(op_id);

        if ((node.get_real_g() + op.get_cost()) >= bound)
            return IN_PROGRESS;
        GlobalState succ_state = state_registry.get_successor_state(s, op);
        //FWDBWD: What do they consider when counting generated nodes? What if an old node is generated?
        statistics.inc_generated();

        SearchNode succ_node = search_space.get_node(succ_state);

        // Previously encountered dead end. Don't re-evaluate.
        if (succ_node.is_dead_end())
            return IN_PROGRESS;

        // update new path
        if (use_multi_path_dependence || succ_node.is_new()) {
            for (Evaluator *evaluator : path_dependent_evaluators) {
                evaluator->notify_state_transition(s, op_id, succ_state);
            }
        }

        if (succ_node.is_new()) {

            // OPTIMIZE: Can we do something about the goal states found here?

            int succ_g = node.get_g() + get_adjusted_cost(op);
            EvaluationContext eval_context(
                succ_state, succ_g, is_preferred, &statistics);
            statistics.inc_evaluated_states();

            if (open_list->is_dead_end(eval_context)) {
                succ_node.mark_as_dead_end();
                statistics.inc_dead_ends();
                return IN_PROGRESS;
            }
            succ_node.open(node, op);

            OpStackNode* parent_op_stack_node = op_stack_node->get_parent();
            parent_op_stack_node->store_state(succ_state.get_id());

            if(parent_op_stack_node == fwdbwd::stack_root)
            {
                // cout << "VERY GOOD WARNING -- 1" << endl;
                fwdbwd::forward_nodes[succ_state.get_id()].insert(op_id);
                fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL, succ_node.get_real_g());
                open_list->insert(eval_context, succ_fwdbwd_node);
            }
            else
            {
                // cout << "GOOD WARNING -- 1" << endl;
                fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), OperatorID::no_operator, parent_op_stack_node, succ_node.get_real_g());
                open_list->insert(eval_context, succ_fwdbwd_node);
            }
            if (search_progress.check_progress(eval_context)) {
                print_checkpoint_line(succ_node.get_g());
                reward_progress();
            }
        }
        else{
            if(succ_node.get_g() > node.get_g() + get_adjusted_cost(op))
                succ_node.update_parent(succ_node, op);
            OpStackNode* parent_op_stack_node = op_stack_node->get_parent();
            bool flag = parent_op_stack_node->store_state(succ_state.get_id());
            if(flag)
            {
                EvaluationContext eval_context(
                    succ_state, succ_node.get_g(), is_preferred, &statistics);
                if(parent_op_stack_node == fwdbwd::stack_root)
                {
                    if(fwdbwd::forward_nodes[succ_state.get_id()].find(op_id) == fwdbwd::forward_nodes[succ_state.get_id()].end())
                    {
                        fwdbwd::forward_nodes[succ_state.get_id()].insert(op_id);
                        fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), op_id, NULL, succ_node.get_real_g());
                        open_list->insert(eval_context, succ_fwdbwd_node);
                    }
                }
                else
                {
                    fwdbwd::FwdbwdNode succ_fwdbwd_node(succ_state.get_id(), OperatorID::no_operator, parent_op_stack_node, succ_node.get_real_g());
                    open_list->insert(eval_context, succ_fwdbwd_node);
                }
            }
        }
    }
    else
    {
        for (OperatorID oid : (fwdbwd::dependency_map[op_stack_node->get_operator()]))
        {
            if(!fwdbwd::record_history(id, oid))
            {
                OperatorProxy op = task_proxy.get_operators()[oid];
                pair<OpStackNode*, bool> child = op_stack_node->gen_child(oid, id, op.get_cost());
                if(child.second)
                {
                    fwdbwd::FwdbwdNode succ_fwdbwd_node(id, OperatorID::no_operator, child.first, fwdbwd_node.get_g());
                    open_list->insert(eval_context, succ_fwdbwd_node);
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
            fwdbwd::FwdbwdNode dummy_node(StateID::no_state, OperatorID::no_operator, NULL, 0);
            return make_pair(dummy_node, false);
        }
        vector<int> last_key_removed;
        fwdbwd::FwdbwdNode fwdbwdNode = open_list->remove_min(
            use_multi_path_dependence ? &last_key_removed : nullptr);

        StateID id = fwdbwdNode.get_state();
        GlobalState s = state_registry.lookup_state(id);
        SearchNode node = search_space.get_node(s);

        // FWDBWD: Add code for checking if this node is repeated

        // FWDBWD: No need to close nodes?
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
        /* FWDBWD: Should it be updated for backwards node? 
        We might be in a loop error or something
        if EvaluationContext is considering f_value_statistics in
        that sense.
        */
        update_f_value_statistics(node);
        /*
        FWDBWD: Should this be counted as expanded? 
        When reopen_closed_node was there, we did count it as expanded.
        Look for how it effects search and stuff.
        */
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

State EagerSearch::convert_global_state(const GlobalState &global_state) const {
    State state(*tasks::g_root_task, global_state.get_values());
    return task_proxy.convert_ancestor_state(state);
}

vector<fwdbwd::FwdbwdOps> EagerSearch::generate_fwdbwd_ops(GlobalState s, OperatorID op_id)
{
        vector<OperatorID> base_ops;
        vector<OperatorID> fwd_ops;
        vector<OperatorID> bwd_ops;
        vector<fwdbwd::FwdbwdOps> fwdbwd_ops;

        
        if((op_id == OperatorID::no_operator) || fwdbwd::goal_fact_ops[op_id])
        {
            g_successor_generator->generate_applicable_ops(s, base_ops);
            fwdbwd::privilege_node[s.get_id()] = true;
            for(OperatorID id: base_ops)
                fwdbwd_ops.push_back(make_pair(id, true));
        }
        else
        {
            base_ops = fwdbwd::inverse_map[op_id];
            State state = convert_global_state(s);

            for(OperatorID id: base_ops)
            {
                OperatorProxy op = task_proxy.get_operators()[id];
                if(task_properties::is_applicable(op, state))
                    fwd_ops.push_back(id);
                else
                    bwd_ops.push_back(id);
            }
            
            // doing this so that all forward ones are applied first
            for(OperatorID id: fwd_ops)
                fwdbwd_ops.push_back(make_pair(id, true));
            for(OperatorID id: bwd_ops)
                fwdbwd_ops.push_back(make_pair(id, false));
        }

        return fwdbwd_ops;
    }

}
