extends Node2D # gen_map.py Map114

var map_name = "Route 08 (Grove)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(592, 592):
		Global.game.play_dialogue("MAP114_NPC_1")
	if check_pos == Vector2(464, 560):
		Global.game.play_dialogue("MAP114_NPC_2")
	if check_pos == Vector2(336, 624):
		Global.game.play_dialogue("MAP114_NPC_3")
	if check_pos == Vector2(560, 432):
		Global.game.play_dialogue("MAP114_NPC_4")
	if check_pos == Vector2(368, 432):
		Global.game.play_dialogue("MAP114_NPC_5")
	return null
