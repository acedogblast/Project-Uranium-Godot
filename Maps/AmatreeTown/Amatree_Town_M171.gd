extends Node2D # gen_map.py Map171

var map_name = "Amatree Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(816, 176):
		Global.game.play_dialogue("MAP171_NPC_1")
	if check_pos == Vector2(336, 176):
		Global.game.play_dialogue("MAP171_NPC_2")
	if check_pos == Vector2(80, 144):
		Global.game.play_dialogue("MAP171_NPC_3")
	if check_pos == Vector2(1648, 208):
		Global.game.play_dialogue("MAP171_NPC_4")
	if check_pos == Vector2(1776, 240):
		Global.game.play_dialogue("MAP171_NPC_5")
	if check_pos == Vector2(624, 944):
		Global.game.play_dialogue("MAP171_NPC_6")
	if check_pos == Vector2(720, 880):
		Global.game.play_dialogue("MAP171_NPC_7")
	if check_pos == Vector2(688, 656):
		Global.game.play_dialogue("MAP171_NPC_8")
	if check_pos == Vector2(592, 688):
		Global.game.play_dialogue("MAP171_NPC_9")
	return null
