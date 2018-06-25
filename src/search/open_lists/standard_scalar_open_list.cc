#include "standard_scalar_open_list.h"

#include "../evaluator.h"
#include "../open_list.h"
#include "../option_parser.h"
#include "../plugin.h"
#include "../operator_id.h"

#include "../utils/memory.h"

#include <cassert>
#include <deque>
#include <map>
#include <set>

using namespace std;

namespace standard_scalar_open_list {
template<class Entry>
class StandardScalarOpenList : public OpenList<Entry> {
    typedef deque<Entry> Bucket;
    typedef multiset<fwdbwd::FwdbwdNode> fwdbwdBucket;
    typedef fwdbwdBucket::iterator fwdbwdBucket_it;


    map<int, Bucket> buckets;
    map<int, fwdbwdBucket> fwdbwd_buckets;

    int size;

    Evaluator *evaluator;

protected:
    virtual void do_insertion(EvaluationContext &eval_context,
                              const Entry &entry) override;

public:
    explicit StandardScalarOpenList(const Options &opts);
    StandardScalarOpenList(Evaluator *eval, bool preferred_only);
    virtual ~StandardScalarOpenList() override = default;

    virtual Entry remove_min(vector<int> *key = nullptr) override;
    virtual bool empty() const override;
    virtual void clear() override;
    virtual void get_path_dependent_evaluators(set<Evaluator *> &evals) override;
    virtual bool is_dead_end(
        EvaluationContext &eval_context) const override;
    virtual bool is_reliable_dead_end(
        EvaluationContext &eval_context) const override;
};


template<class Entry>
StandardScalarOpenList<Entry>::StandardScalarOpenList(const Options &opts)
    : OpenList<Entry>(opts.get<bool>("pref_only")),
      size(0),
      evaluator(opts.get<Evaluator *>("eval")) {
}

template<class Entry>
StandardScalarOpenList<Entry>::StandardScalarOpenList(
    Evaluator *evaluator, bool preferred_only)
    : OpenList<Entry>(preferred_only),
      size(0),
      evaluator(evaluator) {
}

template<class Entry>
void StandardScalarOpenList<Entry>::do_insertion(
    EvaluationContext &eval_context, const Entry &entry) {
    int key = eval_context.get_heuristic_value(evaluator);
    buckets[key].push_back(entry);
    ++size;
}

template<class Entry>
Entry StandardScalarOpenList<Entry>::remove_min(vector<int> *key) {
    assert(size > 0);
    auto it = buckets.begin();
    assert(it != buckets.end());
    if (key) {
        assert(key->empty());
        key->push_back(it->first);
    }

    Bucket &bucket = it->second;
    assert(!bucket.empty());
    Entry result = bucket.front();
    bucket.pop_front();
    if (bucket.empty())
        buckets.erase(it);
    --size;
    return result;
}

template<class Entry>
bool StandardScalarOpenList<Entry>::empty() const {
    return size == 0;
}

template<class Entry>
void StandardScalarOpenList<Entry>::clear() {
    buckets.clear();
    size = 0;
}

template<class Entry>
void StandardScalarOpenList<Entry>::get_path_dependent_evaluators(
    set<Evaluator *> &evals) {
    evaluator->get_path_dependent_evaluators(evals);
}

template<class Entry>
bool StandardScalarOpenList<Entry>::is_dead_end(
    EvaluationContext &eval_context) const {
    return eval_context.is_heuristic_infinite(evaluator);
}

template<class Entry>
bool StandardScalarOpenList<Entry>::is_reliable_dead_end(
    EvaluationContext &eval_context) const {
    return is_dead_end(eval_context) && evaluator->dead_ends_are_reliable();
}

// specialised functions

template<>
void StandardScalarOpenList<fwdbwd::FwdbwdNode>::do_insertion(
    EvaluationContext &eval_context, const fwdbwd::FwdbwdNode &entry) {
    int key = eval_context.get_heuristic_value(evaluator);
    fwdbwd_buckets[key].insert(entry);
    ++size;
    if(entry.get_stack_pointer() == NULL)
        cout << "Forward Node ->";
    else
        cout << "Backward Node ->";
    cout << "Heuristic Value: " << key << endl;
}

template<>
fwdbwd::FwdbwdNode StandardScalarOpenList<fwdbwd::FwdbwdNode>::remove_min(vector<int> *key) {
    assert(size > 0);
    auto it = fwdbwd_buckets.begin();
    assert(it != fwdbwd_buckets.end());
    if (key) {
        assert(key->empty());
        key->push_back(it->first);
    }

    fwdbwdBucket &bucket = it->second;
    assert(!bucket.empty());
    fwdbwdBucket_it itr = bucket.begin();
    fwdbwd::FwdbwdNode result = *itr;
    bucket.erase(itr);
    if (bucket.empty())
        fwdbwd_buckets.erase(it);
    --size;
    return result;
}

template<>
void StandardScalarOpenList<fwdbwd::FwdbwdNode>::clear() {
    fwdbwd_buckets.clear();
    size = 0;
}


StandardScalarOpenListFactory::StandardScalarOpenListFactory(
    const Options &options)
    : options(options) {
}

unique_ptr<StateOpenList>
StandardScalarOpenListFactory::create_state_open_list() {
    return utils::make_unique_ptr<StandardScalarOpenList<StateOpenListEntry>>(options);
}

unique_ptr<EdgeOpenList>
StandardScalarOpenListFactory::create_edge_open_list() {
    return utils::make_unique_ptr<StandardScalarOpenList<EdgeOpenListEntry>>(options);
}

unique_ptr<FwdbwdOpenList>
StandardScalarOpenListFactory::create_fwdbwd_open_list() {
    return utils::make_unique_ptr<StandardScalarOpenList<FwdbwdOpenListEntry>>(options);
}

static shared_ptr<OpenListFactory> _parse(OptionParser &parser) {
    parser.document_synopsis(
        "Standard open list",
        "Standard open list that uses a single evaluator");
    parser.add_option<Evaluator *>("eval", "evaluator");
    parser.add_option<bool>(
        "pref_only",
        "insert only nodes generated by preferred operators", "false");

    Options opts = parser.parse();
    if (parser.dry_run())
        return nullptr;
    else
        return make_shared<StandardScalarOpenListFactory>(opts);
}

static PluginShared<OpenListFactory> _plugin("single", _parse);
}