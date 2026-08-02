extends Node2D # gen_map.py Map140

var map_name = "Route 11"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 912):
		Global.game.play_dialogue("MAP140_NPC_1")
	if check_pos == Vector2(208, 912):
		Global.game.play_dialogue("MAP140_NPC_2")
	if check_pos == Vector2(304, 944):
		Global.game.play_dialogue("MAP140_NPC_3")
	if check_pos == Vector2(144, 1072):
		Global.game.play_dialogue("MAP140_NPC_4")
	if check_pos == Vector2(144, 944):
		Global.game.play_dialogue("MAP140_NPC_5")
	if check_pos == Vector2(336, 1040):
		Global.game.play_dialogue("MAP140_NPC_6")
	if check_pos == Vector2(336, 1072):
		Global.game.play_dialogue("MAP140_NPC_7")
	if check_pos == Vector2(272, 1104):
		Global.game.play_dialogue("MAP140_NPC_8")
	return null
