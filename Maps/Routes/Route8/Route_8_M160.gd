extends Node2D # gen_map.py Map160

var map_name = "Route 08"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(272, 208):
		Global.game.play_dialogue("MAP160_NPC_1")
	return null
