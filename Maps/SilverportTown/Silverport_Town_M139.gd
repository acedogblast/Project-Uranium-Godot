extends Node2D # gen_map.py Map139

var map_name = "Silverport Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 240):
		Global.game.play_dialogue("MAP139_NPC_1")
	if check_pos == Vector2(272, 240):
		Global.game.play_dialogue("MAP139_NPC_2")
	if check_pos == Vector2(112, 208):
		Global.game.play_dialogue("MAP139_NPC_3")
	if check_pos == Vector2(1040, 112):
		Global.game.play_dialogue("MAP139_NPC_4")
	if check_pos == Vector2(880, 240):
		Global.game.play_dialogue("MAP139_NPC_5")
	if check_pos == Vector2(1712, 208):
		Global.game.play_dialogue("MAP139_NPC_6")
	return null
