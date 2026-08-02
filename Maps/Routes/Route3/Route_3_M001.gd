extends Node2D # gen_map.py Map001

var map_name = "Route 03"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 272):
		Global.game.play_dialogue("MAP001_NPC_1")
	if check_pos == Vector2(304, 208):
		Global.game.play_dialogue("MAP001_NPC_2")
	return null
