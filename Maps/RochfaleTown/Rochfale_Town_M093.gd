extends Node2D # gen_map.py Map093

var map_name = "Rochfale Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 208):
		Global.game.play_dialogue("MAP093_SIGN_1")
	if check_pos == Vector2(336, 208):
		Global.game.play_dialogue("MAP093_SIGN_2")
	if check_pos == Vector2(208, 304):
		Global.game.play_dialogue("MAP093_NPC_1")
	if check_pos == Vector2(400, 240):
		Global.game.play_dialogue("MAP093_NPC_2")
	if check_pos == Vector2(464, 240):
		Global.game.play_dialogue("MAP093_NPC_3")
	return null
