extends Node2D # gen_map.py Map098

var map_name = "Rochfale Town(Cypress Lab)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(336, 432):
		Global.game.play_dialogue("MAP098_NPC_1")
	if check_pos == Vector2(208, 304):
		Global.game.play_dialogue("MAP098_NPC_2")
	if check_pos == Vector2(720, 368):
		Global.game.play_dialogue("MAP098_NPC_3")
	if check_pos == Vector2(432, 272):
		Global.game.play_dialogue("MAP098_NPC_4")
	if check_pos == Vector2(176, 304):
		Global.game.play_dialogue("MAP098_NPC_5")
	return null
