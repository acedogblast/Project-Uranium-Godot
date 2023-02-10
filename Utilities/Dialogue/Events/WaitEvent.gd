extends "res://Utilities/Dialogue/Event.gd"

# This event pauses the text for the specified durations in seconds
class_name WaitEvent

var time

func _init(pos,tree,time):
	self.time = time

func on_event():
	timer.stop()
	await tree.create_timer(time).timeout
	timer.start()
