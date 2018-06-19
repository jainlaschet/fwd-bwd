#ifndef OPERATOR_ID_H
#define OPERATOR_ID_H

#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <utility>
#include <tuple>

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
  int dep;
  
  // stores state for duplicate detection
  std::unordered_set<StateID> state_storage;

public:
  OpStackNode(OperatorID operator_id, OpStackNode* parent, int depth=0);

  OperatorID get_operator();
  OpStackNode* get_parent();
  int get_depth();

  /* generates child, pair.second is false if state already requested here */
  std::pair<OpStackNode*, bool> gen_child(OperatorID operator_id, StateID state_id);

  // returns false if the state if already there, else true
  bool store_state(StateID state_id);
};

#endif
