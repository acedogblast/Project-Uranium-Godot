extends Node2D # gen_map.py Map090

var map_name = "Burole Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 272):
		Global.game.play_dialogue("MAP090_NPC_1")
	if check_pos == Vector2(368, 304):
		Global.game.play_dialogue("MAP090_NPC_2")
	return null
