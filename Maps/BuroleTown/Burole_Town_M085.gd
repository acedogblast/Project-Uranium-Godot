extends Node2D # gen_map.py Map085

var map_name = "Burole Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(208, 304):
		Global.game.play_dialogue("MAP085_NPC_1")
	if check_pos == Vector2(400, 272):
		Global.game.play_dialogue("MAP085_NPC_2")
	return null
