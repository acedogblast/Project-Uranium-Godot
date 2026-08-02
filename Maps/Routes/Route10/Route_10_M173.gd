extends Node2D # gen_map.py Map173

var map_name = "Route 10"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 240):
		Global.game.play_dialogue("MAP173_NPC_1")
	return null
