extends Node2D # gen_map.py Map204

var map_name = "Tsukinami Village"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(784, 208):
		Global.game.play_dialogue("MAP204_NPC_1")
	if check_pos == Vector2(272, 176):
		Global.game.play_dialogue("MAP204_NPC_2")
	if check_pos == Vector2(208, 80):
		Global.game.play_dialogue("MAP204_NPC_3")
	if check_pos == Vector2(1680, 208):
		Global.game.play_dialogue("MAP204_NPC_4")
	if check_pos == Vector2(2256, 592):
		Global.game.play_dialogue("MAP204_NPC_5")
	if check_pos == Vector2(48, 112):
		Global.game.play_dialogue("MAP204_NPC_6")
	if check_pos == Vector2(368, 272):
		Global.game.play_dialogue("MAP204_NPC_7")
	if check_pos == Vector2(176, 624):
		Global.game.play_dialogue("MAP204_NPC_8")
	if check_pos == Vector2(976, 208):
		Global.game.play_dialogue("MAP204_NPC_9")
	if check_pos == Vector2(912, 112):
		Global.game.play_dialogue("MAP204_NPC_10")
	if check_pos == Vector2(912, 656):
		Global.game.play_dialogue("MAP204_NPC_11")
	if check_pos == Vector2(784, 720):
		Global.game.play_dialogue("MAP204_NPC_12")
	if check_pos == Vector2(2256, 688):
		Global.game.play_dialogue("MAP204_NPC_13")
	if check_pos == Vector2(2416, 176):
		Global.game.play_dialogue("MAP204_NPC_14")
	if check_pos == Vector2(2448, 176):
		Global.game.play_dialogue("MAP204_NPC_15")
	if check_pos == Vector2(1488, 720):
		Global.game.play_dialogue("MAP204_NPC_16")
	if check_pos == Vector2(1616, 656):
		Global.game.play_dialogue("MAP204_NPC_17")
	if check_pos == Vector2(2448, 688):
		Global.game.play_dialogue("MAP204_NPC_18")
	if check_pos == Vector2(2448, 592):
		Global.game.play_dialogue("MAP204_NPC_19")
	return null
