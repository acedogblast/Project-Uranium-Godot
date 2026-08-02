extends Node2D # gen_map.py Map048

var map_name = "PN's house"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(208, 144):
		Global.game.play_dialogue("MAP048_SIGN_1")
	if check_pos == Vector2(304, 144):
		Global.game.play_dialogue("MAP048_SIGN_2")
	if check_pos == Vector2(272, 144):
		Global.game.play_dialogue("MAP048_SIGN_3")
	if check_pos == Vector2(336, 112):
		Global.game.play_dialogue("MAP048_SIGN_4")
	if check_pos == Vector2(240, 112):
		Global.game.play_dialogue("MAP048_SIGN_5")
	if check_pos == Vector2(368, 112):
		Global.game.play_dialogue("MAP048_SIGN_6")
	return null
