extends Node2D # gen_map.py Map092

var map_name = "Rochfale Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 336):
		Global.game.play_dialogue("MAP092_NPC_1")
	if check_pos == Vector2(400, 272):
		Global.game.play_dialogue("MAP092_NPC_2")
	if check_pos == Vector2(368, 240):
		Global.game.play_dialogue("MAP092_NPC_3")
	return null
