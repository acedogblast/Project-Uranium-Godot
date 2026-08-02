extends Node2D # gen_map.py Map064

var map_name = "Moki Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 304):
		Global.game.play_dialogue("MAP064_NPC_1")
	if check_pos == Vector2(432, 272):
		Global.game.play_dialogue("MAP064_NPC_2")
	if check_pos == Vector2(336, 272):
		Global.game.play_dialogue("MAP064_NPC_3")
	return null
