using namespace std;
#include <iostream>
#include "Stack.h"
#include "StackList.h"
#include "QueueStack.h"
//constructor creates new stack- stacklist and points to it
QueueStack::QueueStack() {
	s1 = new StackList;
}
void QueueStack::enqueue(int val) {
	//put in from on top by calling push of stackList
	s1->push(val);
}
//takes out from bottom returns it
int QueueStack::dequeue(){ 
	//makes list upsidedown by moving to new stack
	StackList s2;
	while (!s1->isEmpty()) {
		s2.push(s1->pop());
	}
	//take out top
	int up= s2.pop();
	//put all back
	while (!s2.isEmpty()) {
		s1->push(s2.pop());
	}
	//clear s2 just in case
	s2.clear();
	return up;
};
//just like last method but just ckecks doesnt take out
int  QueueStack::front() const{
	StackList s2;
	while (!s1->isEmpty()) {
		s2.push(s1->pop());
	}
	int up = s2.top();
	while (!s2.isEmpty()) {
		s1->push(s2.pop());
	}
	s2.clear();
	return up;
}
//checks if empty by calling stacks isEmpty
bool QueueStack::isEmpty() const{
	return s1->isEmpty();
}
//deletes all values from stack by calling clear of stack
void QueueStack::clear(){
	s1->clear();
};