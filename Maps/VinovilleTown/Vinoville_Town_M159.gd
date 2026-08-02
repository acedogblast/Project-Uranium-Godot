extends Node2D # gen_map.py Map159

var map_name = "Vinoville Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(784, 976):
		Global.game.play_dialogue("MAP159_SIGN_1")
	if check_pos == Vector2(816, 976):
		Global.game.play_dialogue("MAP159_SIGN_2")
	if check_pos == Vector2(1072, 976):
		Global.game.play_dialogue("MAP159_SIGN_3")
	if check_pos == Vector2(1104, 976):
		Global.game.play_dialogue("MAP159_SIGN_4")
	if check_pos == Vector2(944, 944):
		Global.game.play_dialogue("MAP159_NPC_1")
	if check_pos == Vector2(848, 1040):
		Global.game.play_dialogue("MAP159_NPC_2")
	if check_pos == Vector2(1008, 1104):
		Global.game.play_dialogue("MAP159_NPC_3")
	if check_pos == Vector2(816, 1168):
		Global.game.play_dialogue("MAP159_NPC_4")
	if check_pos == Vector2(816, 112):
		Global.game.play_dialogue("MAP159_NPC_5")
	if check_pos == Vector2(784, 176):
		Global.game.play_dialogue("MAP159_NPC_6")
	if check_pos == Vector2(1040, 144):
		Global.game.play_dialogue("MAP159_NPC_7")
	if check_pos == Vector2(304, 240):
		Global.game.play_dialogue("MAP159_NPC_8")
	if check_pos == Vector2(48, 144):
		Global.game.play_dialogue("MAP159_NPC_9")
	if check_pos == Vector2(1648, 208):
		Global.game.play_dialogue("MAP159_NPC_10")
	if check_pos == Vector2(1040, 1168):
		Global.game.play_dialogue("MAP159_NPC_11")
	if check_pos == Vector2(1072, 1040):
		Global.game.play_dialogue("MAP159_NPC_12")
	if check_pos == Vector2(848, 1104):
		Global.game.play_dialogue("MAP159_NPC_13")
	if check_pos == Vector2(880, 1168):
		Global.game.play_dialogue("MAP159_NPC_14")
	if check_pos == Vector2(1072, 1104):
		Global.game.play_dialogue("MAP159_NPC_15")
	if check_pos == Vector2(784, 1104):
		Global.game.play_dialogue("MAP159_NPC_16")
	return null
