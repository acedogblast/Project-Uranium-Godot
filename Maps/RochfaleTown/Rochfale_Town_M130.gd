extends Node2D # gen_map.py Map130

var map_name = "Rochfale Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 304):
		Global.game.play_dialogue("MAP130_NPC_1")
	return null
