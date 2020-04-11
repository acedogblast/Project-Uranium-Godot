extends Node2D

export var event_name : String
export var commands = []

func _ready():
	DialogueSystem.connect("dialogue_start", self, "pause_scene")
	DialogueSystem.connect("dialogue_end", self, "resume_scene")

func _exit_tree():
	DialogueSystem.disconnect("dialogue_start", self, "pause_scene")
	DialogueSystem.disconnect("dialogue_end", self, "resume_scene")

func _on_Area2D_area_entered(area):
	if check_if_event_already_occured():

		pass
func check_if_event_already_occured():
	if Global.past_events.has(event_name):
		return true
	else:
		return false
func start_npc_trainer_dialogue():
	#DialogueSystem.start_dialog("This is a piece of dialogue!")
	DialogueSystem.set_dialogue_sequence("NPC_TRAINER_D")
	DialogueSystem.start_dialogue_sequence()
	yield(DialogueSystem, "dialogue_sequence_end")
