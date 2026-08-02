extends Node2D # gen_map.py Map188

var map_name = "Route 08 (Boat)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(656, 272):
		Global.game.play_dialogue("MAP188_NPC_1")
	if check_pos == Vector2(240, 240):
		Global.game.play_dialogue("MAP188_NPC_2")
	if check_pos == Vector2(240, 432):
		Global.game.play_dialogue("MAP188_NPC_3")
	if check_pos == Vector2(80, 400):
		Global.game.play_dialogue("MAP188_NPC_4")
	if check_pos == Vector2(176, 336):
		Global.game.play_dialogue("MAP188_NPC_5")
	return null
