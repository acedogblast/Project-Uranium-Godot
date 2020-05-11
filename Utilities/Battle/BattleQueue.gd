extends Object
class_name BattleQueue
var queue = [] # To be filled by BattleQueueAction objects

func push(object): # Adds an action to the back queue.
	queue.push_back(object)
func peek(): # Returns the first action but donsn't remove it.
	return queue.front()
func pop(): # Returns and removes the first action.
	return queue.pop_front()
func is_empty():
	return queue.empty()
