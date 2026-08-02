extends Node2D # gen_map.py Map183

var map_name = "Rochfale Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 976):
		Global.game.play_dialogue("MAP183_SIGN_1")
	if check_pos == Vector2(560, 656):
		Global.game.play_dialogue("MAP183_SIGN_2")
	if check_pos == Vector2(688, 1008):
		Global.game.play_dialogue("MAP183_SIGN_3")
	if check_pos == Vector2(464, 1328):
		Global.game.play_dialogue("MAP183_NPC_1")
	if check_pos == Vector2(944, 816):
		Global.game.play_dialogue("MAP183_NPC_2")
	if check_pos == Vector2(464, 976):
		Global.game.play_dialogue("MAP183_NPC_3")
	if check_pos == Vector2(368, 752):
		Global.game.play_dialogue("MAP183_NPC_4")
	return null
