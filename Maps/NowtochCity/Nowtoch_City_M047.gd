extends Node2D # gen_map.py Map047

var map_name = "Nowtoch City"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 112):
		Global.game.play_dialogue("MAP047_SIGN_1")
	if check_pos == Vector2(176, 112):
		Global.game.play_dialogue("MAP047_SIGN_2")
	if check_pos == Vector2(144, 112):
		Global.game.play_dialogue("MAP047_SIGN_3")
	if check_pos == Vector2(1008, 144):
		Global.game.play_dialogue("MAP047_SIGN_4")
	if check_pos == Vector2(976, 144):
		Global.game.play_dialogue("MAP047_SIGN_5")
	if check_pos == Vector2(752, 144):
		Global.game.play_dialogue("MAP047_SIGN_6")
	if check_pos == Vector2(944, 144):
		Global.game.play_dialogue("MAP047_SIGN_7")
	if check_pos == Vector2(1040, 144):
		Global.game.play_dialogue("MAP047_SIGN_8")
	if check_pos == Vector2(816, 208):
		Global.game.play_dialogue("MAP047_NPC_1")
	if check_pos == Vector2(944, 208):
		Global.game.play_dialogue("MAP047_NPC_2")
	return null
