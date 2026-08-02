extends Node2D # gen_map.py Map070

var map_name = "Dream World"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 272):
		Global.game.play_dialogue("MAP070_SIGN_1")
	return null
