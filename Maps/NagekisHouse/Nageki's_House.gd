extends Node2D # gen_map.py Map210

var map_name = "Nageki's House"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 208):
		Global.game.play_dialogue("MAP210_NPC_1")
	return null
