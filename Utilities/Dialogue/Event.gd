extends Node

class_name DialogueEvent

var pos
var tree
var timer

func _init(pos, tree):
	self.pos = pos
	self.tree = tree
	self.timer = DialogueSystem.typeTimer

func on_event():
	pass
