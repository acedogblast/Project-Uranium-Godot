extends Node2D # gen_map.py Map020

var map_name = "Legen Town(VR building)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(272, 240):
		Global.game.play_dialogue("MAP020_SIGN_1")
	if check_pos == Vector2(304, 240):
		Global.game.play_dialogue("MAP020_NPC_1")
	if check_pos == Vector2(80, 240):
		Global.game.play_dialogue("MAP020_NPC_2")
	return null
