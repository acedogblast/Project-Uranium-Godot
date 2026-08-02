extends Node2D # gen_map.py Map208

var map_name = "Dream Route 13"

var wild_table = [
	[46,  40, 25, 27],
	[106,  20, 35, 37],
	[128,  10, 30, 35],
	[32,  10, 30, 32],
	[32,  10, 25, 30],
	[32,   4, 25, 27],
	[32,   4, 27, 27],
	[133,   1, 33, 33],
	[142,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(624, 496):
		Global.game.play_dialogue("MAP208_NPC_1")
	return null
