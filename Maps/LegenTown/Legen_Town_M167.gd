extends Node2D # gen_map.py Map167

var map_name = "Legen Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(944, 784):
		Global.game.play_dialogue("MAP167_NPC_1")
	if check_pos == Vector2(1040, 784):
		Global.game.play_dialogue("MAP167_NPC_2")
	if check_pos == Vector2(1040, 848):
		Global.game.play_dialogue("MAP167_NPC_3")
	if check_pos == Vector2(1072, 752):
		Global.game.play_dialogue("MAP167_NPC_4")
	if check_pos == Vector2(1104, 720):
		Global.game.play_dialogue("MAP167_NPC_5")
	if check_pos == Vector2(1104, 752):
		Global.game.play_dialogue("MAP167_NPC_6")
	if check_pos == Vector2(1008, 848):
		Global.game.play_dialogue("MAP167_NPC_7")
	if check_pos == Vector2(880, 784):
		Global.game.play_dialogue("MAP167_NPC_8")
	if check_pos == Vector2(880, 752):
		Global.game.play_dialogue("MAP167_NPC_9")
	if check_pos == Vector2(1424, 1264):
		Global.game.play_dialogue("MAP167_NPC_10")
	if check_pos == Vector2(944, 848):
		Global.game.play_dialogue("MAP167_NPC_11")
	if check_pos == Vector2(880, 720):
		Global.game.play_dialogue("MAP167_NPC_12")
	if check_pos == Vector2(912, 816):
		Global.game.play_dialogue("MAP167_NPC_13")
	if check_pos == Vector2(976, 848):
		Global.game.play_dialogue("MAP167_NPC_14")
	if check_pos == Vector2(1040, 112):
		Global.game.play_dialogue("MAP167_NPC_15")
	if check_pos == Vector2(880, 240):
		Global.game.play_dialogue("MAP167_NPC_16")
	if check_pos == Vector2(1712, 208):
		Global.game.play_dialogue("MAP167_NPC_17")
	if check_pos == Vector2(1008, 784):
		Global.game.play_dialogue("MAP167_NPC_18")
	if check_pos == Vector2(272, 720):
		Global.game.play_dialogue("MAP167_NPC_19")
	if check_pos == Vector2(112, 1136):
		Global.game.play_dialogue("MAP167_NPC_20")
	if check_pos == Vector2(2064, 560):
		Global.game.play_dialogue("MAP167_NPC_21")
	if check_pos == Vector2(976, 592):
		Global.game.open_shop(['GOODROD', 'TM09', 'TM28', 'TM44', 'TM32', 'ULTRABALL', 'REVIVE', 'SUPERREPEL'])
	return null
