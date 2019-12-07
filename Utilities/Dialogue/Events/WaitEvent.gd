extends "res://Utilities/Dialogue/Event.gd"

class_name WaitEvent

var time
var timer

func _init(pos, tree, time, timer).(pos, tree):
	self.time = time
	self.timer = timer

func on_event():
	timer.stop()
	yield(tree.create_timer(time), "timeout")
	timer.start()