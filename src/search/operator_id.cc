#include "operator_id.h"

#include <ostream>

using namespace std;

ostream &operator<<(ostream &os, OperatorID id) {
    os << "op" << id.get_index();
    return os;
}

const OperatorID OperatorID::no_operator = OperatorID(-1);


OpStackNode::OpStackNode(OperatorID operator_id, OpStackNode* parent)
: op_id(operator_id), par(parent)
{
	if(parent == NULL)
		depth = 0;
	else
		depth = parent->depth + 1;
}

OperatorID OpStackNode::get_operator(){
	return op_id;
}

OpStackNode* OpStackNode::get_parent(){
	return par;
}

int OpStackNode::get_depth(){
	return depth;
}

/* generates child, pair.second is false if state already requested stack */
std::pair<OpStackNode*, bool> OpStackNode::gen_child(OperatorID operator_id, StateID state_id){

	if(children.find(operator_id) != children.end())
	{
		bool check = children[operator_id]->store_state(state_id);
		return std::make_pair(children[operator_id], check);
	}
	else
	{
		OpStackNode* child = new OpStackNode(operator_id, this);
		child->store_state(state_id);
		children[operator_id] = child;
		return std::make_pair(child, true);
	}
}

// returns false if the state if already there, else true
bool OpStackNode::store_state(StateID state_id){
	pair<std::unordered_set<StateID>::iterator, bool> data;
	data = state_storage.insert(state_id);
	return data.second;
}
