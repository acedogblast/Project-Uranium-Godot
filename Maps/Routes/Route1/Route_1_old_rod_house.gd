extends Node2D # gen_map.py Map081

var map_name = "Route 01 (old rod house)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 176):
		Global.game.play_dialogue("MAP081_SIGN_1")
	if check_pos == Vector2(240, 272):
		Global.game.play_dialogue("MAP081_NPC_1")
	if check_pos == Vector2(400, 272):
		Global.game.play_dialogue("MAP081_NPC_2")
	return null
