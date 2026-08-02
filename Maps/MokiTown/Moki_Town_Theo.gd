extends Node2D # gen_map.py Map089

var map_name = "Moki Town (Theo)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(80, 176):
		Global.game.play_dialogue("MAP089_SIGN_1")
	if check_pos == Vector2(240, 112):
		Global.game.play_dialogue("MAP089_SIGN_2")
	if check_pos == Vector2(208, 144):
		Global.game.play_dialogue("MAP089_SIGN_3")
	return null
