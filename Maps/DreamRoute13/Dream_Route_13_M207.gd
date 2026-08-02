extends Node2D # gen_map.py Map207

var map_name = "Dream Route 13"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(624, 496):
		Global.game.play_dialogue("MAP207_SIGN_1")
	if check_pos == Vector2(720, 368):
		Global.game.play_dialogue("MAP207_SIGN_2")
	if check_pos == Vector2(688, 496):
		Global.game.play_dialogue("MAP207_NPC_1")
	if check_pos == Vector2(592, 464):
		Global.game.play_dialogue("MAP207_NPC_2")
	if check_pos == Vector2(688, 400):
		Global.game.play_dialogue("MAP207_NPC_3")
	return null
