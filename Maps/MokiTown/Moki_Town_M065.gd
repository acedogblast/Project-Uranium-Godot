extends Node2D # gen_map.py Map065

var map_name = "Moki Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(432, 336):
		Global.game.play_dialogue("MAP065_NPC_1")
	if check_pos == Vector2(208, 272):
		Global.game.play_dialogue("MAP065_NPC_2")
	return null
