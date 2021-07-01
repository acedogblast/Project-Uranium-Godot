extends Node
class_name MoveDataBase

static func get_move_by_name(name):
	var file_name = "res://Utilities/Battle/Database/Moves/" + name.replace(" ", "_") + ".gd"
	var data = load(file_name)

	if data == null:
		file_name = "res://Utilities/Battle/Database/Moves/" + name + ".gd"
		data = load(file_name)
	
	if data == null:
		print("MoveDatabase ERROR: The move, '" + name + "' does not have a file.")
	
	data = load(file_name).new()

	var move = load("res://Utilities/Battle/Classes/Move.gd").new()
	
	move.name = data.name
	move.type = data.type
	move.style = data.style
	move.base_power = data.base_power
	move.accuracy = data.accuracy
	move.priority = data.priority
	move.critical_hit_level = data.critical_hit_level
	move.secondary_effect_chance = data.secondary_effect_chance
	move.flags = data.flags
	move.total_pp = data.total_pp
	move.target_ability = data.target_ability
	move.main_status_effect = data.main_status_effect
	move.remaining_pp = move.total_pp
	return move
