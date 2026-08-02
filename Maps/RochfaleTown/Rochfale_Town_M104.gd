extends Node2D # gen_map.py Map104

var map_name = "Rochfale Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(80, 272):
		Global.game.play_dialogue("MAP104_NPC_1")
	if check_pos == Vector2(944, 304):
		Global.game.play_dialogue("MAP104_NPC_2")
	if check_pos == Vector2(48, 272):
		Global.game.play_dialogue("MAP104_NPC_3")
	if check_pos == Vector2(368, 240):
		Global.game.play_dialogue("MAP104_NPC_4")
	if check_pos == Vector2(48, 208):
		Global.game.play_dialogue("MAP104_NPC_5")
	if check_pos == Vector2(1072, 336):
		Global.game.play_dialogue("MAP104_NPC_6")
	if check_pos == Vector2(1136, 208):
		Global.game.play_dialogue("MAP104_NPC_7")
	return null
