extends Node2D # gen_map.py Map027

var map_name = "Route 09"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1008, 304):
		Global.game.play_dialogue("MAP027_NPC_1")
	if check_pos == Vector2(272, 208):
		Global.game.play_dialogue("MAP027_NPC_2")
	return null
