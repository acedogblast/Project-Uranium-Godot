extends Node2D # gen_map.py Map214

var map_name = "Nuclear Plant?"

var wild_table = [
	[20,  40, 25, 30],
	[75,  20, 25, 45],
	[44,  10, 30, 40],
	[50,  10, 30, 40],
	[94,   5, 30, 38],
	[166,   5, 30, 38],
	[35,   4, 30, 38],
	[46,   4, 30, 34],
	[60,   1, 30, 34],
	[142,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 208):
		Global.game.play_dialogue("MAP214_SIGN_1")
	if check_pos == Vector2(432, 240):
		Global.game.play_dialogue("MAP214_SIGN_2")
	if check_pos == Vector2(304, 208):
		Global.game.play_dialogue("MAP214_NPC_1")
	return null
