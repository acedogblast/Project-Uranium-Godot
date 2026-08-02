extends Node2D # gen_map.py Map012

var map_name = "Rochfale Town"
var map_px_size = Vector2(2240, 2240)
var edge_connections = [["W", "res://Maps/Routes/Route6/Route_6.tscn", 0, 4144, 1920]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(144, 1040):
		Global.game.play_dialogue("MAP012_SIGN_1")
	if check_pos == Vector2(1200, 656):
		Global.game.play_dialogue("MAP012_SIGN_2")
	if check_pos == Vector2(1328, 1392):
		Global.game.play_dialogue("MAP012_SIGN_3")
	if check_pos == Vector2(1264, 528):
		Global.game.play_dialogue("MAP012_NPC_1")
	if check_pos == Vector2(240, 1136):
		Global.game.play_dialogue("MAP012_NPC_2")
	if check_pos == Vector2(1552, 1488):
		Global.game.play_dialogue("MAP012_NPC_3")
	if check_pos == Vector2(976, 1424):
		Global.game.play_dialogue("MAP012_NPC_4")
	if check_pos == Vector2(976, 1072):
		Global.game.play_dialogue("MAP012_NPC_5")
	if check_pos == Vector2(1360, 1424):
		Global.game.play_dialogue("MAP012_NPC_6")
	if check_pos == Vector2(1232, 912):
		Global.game.play_dialogue("MAP012_NPC_7")
	if check_pos == Vector2(1616, 1424):
		Global.game.play_dialogue("MAP012_NPC_8")
	return null
