extends Node2D # gen_map.py Map073

var map_name = "Kevlar Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 240):
		Global.game.play_dialogue("MAP073_NPC_1")
	if check_pos == Vector2(816, 304):
		Global.game.play_dialogue("MAP073_NPC_2")
	if check_pos == Vector2(1488, 272):
		Global.game.play_dialogue("MAP073_NPC_3")
	if check_pos == Vector2(1360, 368):
		Global.game.play_dialogue("MAP073_NPC_4")
	if check_pos == Vector2(2160, 368):
		Global.game.play_dialogue("MAP073_NPC_5")
	if check_pos == Vector2(1968, 304):
		Global.game.play_dialogue("MAP073_NPC_6")
	if check_pos == Vector2(1296, 272):
		Global.game.open_shop(['POMEGBERRY', 'KELPSYBERRY', 'QUALOTBERRY', 'HONDEWBERRY', 'GREPABERRY', 'TAMATOBERRY', 'GROWTHMULCH', 'DAMPMULCH', 'STABLEMULCH', 'GOOEYMULCH', 'RICHMULCH'])
	return null
