extends Node2D # gen_map.py Map053

var map_name = "Snowbank Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(112, 752):
		Global.game.play_dialogue("MAP053_NPC_1")
	if check_pos == Vector2(112, 208):
		Global.game.play_dialogue("MAP053_NPC_2")
	if check_pos == Vector2(48, 720):
		Global.game.play_dialogue("MAP053_NPC_3")
	if check_pos == Vector2(304, 816):
		Global.game.play_dialogue("MAP053_NPC_4")
	if check_pos == Vector2(816, 144):
		Global.game.play_dialogue("MAP053_NPC_5")
	if check_pos == Vector2(1040, 112):
		Global.game.play_dialogue("MAP053_NPC_6")
	if check_pos == Vector2(1712, 208):
		Global.game.play_dialogue("MAP053_NPC_7")
	return null
