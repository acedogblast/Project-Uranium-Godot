extends Node2D # gen_map.py Map217

var map_name = "Mt. Tamaranch"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1200, 1072):
		Global.game.play_dialogue("MAP217_SIGN_1")
	return null
