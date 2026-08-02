extends Node2D # gen_map.py Map216

var map_name = "Palace of Dreams"

var wild_table = [
	[148,  20, 45, 55],
	[94,  20, 30, 38],
	[77,  13, 30, 38],
	[70,  10, 35, 40],
	[69,  10, 30, 35],
	[31,  10, 25, 45],
	[62,  10, 30, 34],
	[128,   5, 30, 40],
	[100,   1, 30, 34],
	[142,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1072, 1296):
		Global.game.play_dialogue("MAP216_SIGN_1")
	if check_pos == Vector2(208, 1040):
		Global.game.play_dialogue("MAP216_SIGN_2")
	if check_pos == Vector2(272, 1040):
		Global.game.play_dialogue("MAP216_SIGN_3")
	if check_pos == Vector2(176, 1040):
		Global.game.play_dialogue("MAP216_SIGN_4")
	if check_pos == Vector2(240, 1040):
		Global.game.play_dialogue("MAP216_SIGN_5")
	if check_pos == Vector2(752, 496):
		Global.game.play_dialogue("MAP216_NPC_1")
	if check_pos == Vector2(1168, 1456):
		Global.game.play_dialogue("MAP216_NPC_2")
	return null
