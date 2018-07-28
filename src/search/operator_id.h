#ifndef OPERATOR_ID_H
#define OPERATOR_ID_H

#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <utility>

#include "state_id.h"

/*
  OperatorIDs are used to define an operator that belongs to a given
  planning task. These IDs are meant to be compact and efficient to use.
  They can be thought of as a type-safe replacement for "int" for the
  purpose of referring to an operator.

  Because of their efficiency requirements, they do *not* store which
  task they belong to, and it is the user's responsibility not to mix
  OperatorIDs that belong to different tasks.

  OperatorIDs can only refer to *operators*, not to *axioms*. This is
  by design: using OperatorID clearly communicates that only operators
  are appropriate in a given place and it is an error to use an axiom.
  We also considered introducing a class that can refer to operators or
  axioms (suggested names were OperatorOrAxiomID and ActionID, introducing
  the convention that "action" stands for "operator or axiom"), but so
  far we have not found a use case for it.
*/
class OperatorID {
    int index;

public:
    explicit OperatorID(int index)
        : index(index) {
    }

    static const OperatorID no_operator;

    int get_index() const {
        return index;
    }

    bool operator==(const OperatorID &other) const {
        return index == other.index;
    }

    bool operator!=(const OperatorID &other) const {
        return !(*this == other);
    }

    size_t hash() const {
        return index;
    }
};


std::ostream &operator<<(std::ostream &os, OperatorID id);

namespace std {
template<>
struct hash<OperatorID> {
    size_t operator()(OperatorID id) const {
        return id.hash();
    }
};
}

class OpStackNode{

  // stores the value of the operator it represents
  OperatorID op_id;
  
  OpStackNode* par;
  std::unordered_map<OperatorID, OpStackNode*> children;

  // represents stack size
  int depth;
  // represents sum of g_values of all operator
  int cost;
  
  // stores state for duplicate detection
  std::unordered_set<StateID> state_storage;

public:
  OpStackNode(OperatorID operator_id, OpStackNode* parent, int op_cost=0);

  OperatorID get_operator();
  OpStackNode* get_parent();
  int get_depth();
  int get_cost();

  /* generates child, pair.second is false if state already requested here */
  std::pair<OpStackNode*, bool> gen_child(OperatorID operator_id, StateID state_id, int op_cost);

  // returns false if the state if already there, else true
  bool store_state(StateID state_id);
};

namespace fwdbwd{
    using FwdbwdOps = std::pair<OperatorID, bool>;
    class FwdbwdNode{
        StateID id;
        OperatorID op_id;
        OpStackNode* op_stack;
        int state_g_value;
    public:
        FwdbwdNode(StateID state_id, OperatorID operator_id, OpStackNode* op_stack_node, int g_value);
        StateID get_state() const {return id;}
        OperatorID get_operator() const {return op_id;}
        OpStackNode* get_stack_pointer() const {return op_stack;}
        int get_g() const{return state_g_value;}

        bool operator<(const FwdbwdNode& rhs) const;
    };
}

#endif
