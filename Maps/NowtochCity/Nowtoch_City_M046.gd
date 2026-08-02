extends Node2D # gen_map.py Map046

var map_name = "Nowtoch City"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(208, 528):
		Global.game.play_dialogue("MAP046_SIGN_1")
	if check_pos == Vector2(240, 528):
		Global.game.play_dialogue("MAP046_SIGN_2")
	if check_pos == Vector2(240, 944):
		Global.game.play_dialogue("MAP046_SIGN_3")
	if check_pos == Vector2(976, 560):
		Global.game.play_dialogue("MAP046_SIGN_4")
	if check_pos == Vector2(1136, 528):
		Global.game.play_dialogue("MAP046_SIGN_5")
	if check_pos == Vector2(1168, 528):
		Global.game.play_dialogue("MAP046_SIGN_6")
	if check_pos == Vector2(944, 1040):
		Global.game.play_dialogue("MAP046_SIGN_7")
	if check_pos == Vector2(976, 1040):
		Global.game.play_dialogue("MAP046_SIGN_8")
	if check_pos == Vector2(1584, 112):
		Global.game.play_dialogue("MAP046_SIGN_9")
	if check_pos == Vector2(1712, 944):
		Global.game.play_dialogue("MAP046_SIGN_10")
	if check_pos == Vector2(1680, 944):
		Global.game.play_dialogue("MAP046_SIGN_11")
	if check_pos == Vector2(1808, 944):
		Global.game.play_dialogue("MAP046_SIGN_12")
	if check_pos == Vector2(880, 112):
		Global.game.play_dialogue("MAP046_SIGN_13")
	if check_pos == Vector2(208, 144):
		Global.game.play_dialogue("MAP046_NPC_1")
	if check_pos == Vector2(944, 176):
		Global.game.play_dialogue("MAP046_NPC_2")
	if check_pos == Vector2(272, 624):
		Global.game.play_dialogue("MAP046_NPC_3")
	if check_pos == Vector2(176, 624):
		Global.game.play_dialogue("MAP046_NPC_4")
	if check_pos == Vector2(272, 1040):
		Global.game.play_dialogue("MAP046_NPC_5")
	if check_pos == Vector2(976, 528):
		Global.game.play_dialogue("MAP046_NPC_6")
	if check_pos == Vector2(944, 656):
		Global.game.play_dialogue("MAP046_NPC_7")
	if check_pos == Vector2(1104, 624):
		Global.game.play_dialogue("MAP046_NPC_8")
	if check_pos == Vector2(880, 1136):
		Global.game.play_dialogue("MAP046_NPC_9")
	if check_pos == Vector2(1712, 176):
		Global.game.play_dialogue("MAP046_NPC_10")
	if check_pos == Vector2(1744, 1008):
		Global.game.play_dialogue("MAP046_NPC_11")
	if check_pos == Vector2(1616, 1040):
		Global.game.play_dialogue("MAP046_NPC_12")
	if check_pos == Vector2(1712, 624):
		Global.game.play_dialogue("MAP046_NPC_13")
	return null
