extends Node2D # gen_map.py Map209

var map_name = "Dreamland Holiday Resort"

var wild_table = [
	[92,  40, 25, 45],
	[9,  20, 23, 36],
	[128,  20, 30, 40],
	[126,   8, 30, 38],
	[99,   5, 30, 42],
	[99,   5, 42, 42],
	[47,   1, 18, 45],
	[142,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1392, 1232):
		Global.game.play_dialogue("MAP209_SIGN_1")
	if check_pos == Vector2(1296, 1200):
		Global.game.play_dialogue("MAP209_NPC_1")
	return null
