extends Node2D

export var npc_path : NodePath
export var commands = []

onready var npc = get_node(npc_path)
var used = false

func _ready():
	DialogueSystem.connect("dialogue_start", self, "pause_scene")
	DialogueSystem.connect("dialogue_end", self, "resume_scene")

func _exit_tree():
	DialogueSystem.disconnect("dialogue_start", self, "pause_scene")
	DialogueSystem.disconnect("dialogue_end", self, "resume_scene")

func _on_Area2D_area_entered(area):
	
	if $Area2D.get_overlapping_areas()[0].get_parent().name == "Collision":
		if used or npc_path == null or commands.empty():
			return
		
		
		used = true
		for i in range(commands.size() - 1):
			if str(commands[i]) == "Wait":
				yield(get_tree().create_timer(commands[i + 1]), "timeout")
			else:
				var dir = commands[i]
				print(commands[i])
				i += 1
				var amount = commands[i]
				print(commands[i])
				for j in range(amount):
					npc.move(dir)
					yield(get_tree().create_timer(0.6), "timeout")
		start_npc_trainer_dialogue()
		

func start_npc_trainer_dialogue():
	#DialogueSystem.start_dialog("This is a piece of dialogue!")
	DialogueSystem.set_dialogue_sequence("NPC_TRAINER_D")
	DialogueSystem.start_dialogue_sequence()
	yield(DialogueSystem, "dialogue_sequence_end")
