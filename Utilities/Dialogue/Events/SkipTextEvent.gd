extends "res://Utilities/Dialogue/Event.gd"

# This event makes the text advance without having to press Enter
class_name SkipTextEvent

func _init(pos, tree):
	super(pos, tree)
	pass

func on_event():
	timer.stop()

	# FIXME: Workaround while
	# https://github.com/godotengine/godot/pull/32034 is not implemented
	await tree.process_frame
	DialogueSystem.finish_dialogue()
	timer.start()
	
