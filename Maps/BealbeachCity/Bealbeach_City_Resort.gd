extends Node2D # gen_map.py Map052

var map_name = "Bealbeach City( Resort)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 272):
		Global.game.play_dialogue("MAP052_NPC_1")
	if check_pos == Vector2(432, 272):
		Global.game.play_dialogue("MAP052_NPC_2")
	if check_pos == Vector2(304, 464):
		Global.game.play_dialogue("MAP052_NPC_3")
	if check_pos == Vector2(464, 400):
		Global.game.play_dialogue("MAP052_NPC_4")
	if check_pos == Vector2(240, 432):
		Global.game.play_dialogue("MAP052_NPC_5")
	if check_pos == Vector2(1456, 208):
		Global.game.play_dialogue("MAP052_NPC_6")
	if check_pos == Vector2(1488, 208):
		Global.game.play_dialogue("MAP052_NPC_7")
	if check_pos == Vector2(1456, 496):
		Global.game.play_dialogue("MAP052_NPC_8")
	if check_pos == Vector2(1488, 496):
		Global.game.play_dialogue("MAP052_NPC_9")
	if check_pos == Vector2(240, 240):
		Global.game.play_dialogue("MAP052_NPC_10")
	if check_pos == Vector2(432, 1456):
		Global.game.play_dialogue("MAP052_NPC_11")
	if check_pos == Vector2(304, 1456):
		Global.game.play_dialogue("MAP052_NPC_12")
	if check_pos == Vector2(208, 1456):
		Global.game.play_dialogue("MAP052_NPC_13")
	if check_pos == Vector2(304, 1296):
		Global.game.play_dialogue("MAP052_NPC_14")
	if check_pos == Vector2(528, 1168):
		Global.game.play_dialogue("MAP052_NPC_15")
	if check_pos == Vector2(1008, 208):
		Global.game.play_dialogue("MAP052_NPC_16")
	if check_pos == Vector2(1104, 496):
		Global.game.play_dialogue("MAP052_NPC_17")
	if check_pos == Vector2(1232, 624):
		Global.game.play_dialogue("MAP052_NPC_18")
	if check_pos == Vector2(1424, 624):
		Global.game.play_dialogue("MAP052_NPC_19")
	if check_pos == Vector2(1232, 496):
		Global.game.play_dialogue("MAP052_NPC_20")
	if check_pos == Vector2(1360, 496):
		Global.game.play_dialogue("MAP052_NPC_21")
	if check_pos == Vector2(1232, 304):
		Global.game.play_dialogue("MAP052_NPC_22")
	if check_pos == Vector2(1520, 496):
		Global.game.play_dialogue("MAP052_NPC_23")
	if check_pos == Vector2(464, 1392):
		Global.game.open_shop(['COCONUTMILK'])
	return null
