extends Node2D # gen_map.py Map062

var map_name = "Unknown"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(336, 1360):
		Global.game.play_dialogue("MAP062_SIGN_1")
	return null
