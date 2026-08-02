extends Node2D # gen_map.py Map136

var map_name = "Snowbank Town(Gym)"
var map_px_size = Vector2(1024, 1600)
var edge_connections = [["S", "res://Maps/SnowbankTown/Snowbank_Town.tscn", 448, 16, 1920]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(400, 1136):
		Global.game.play_dialogue("MAP136_SIGN_1")
	if check_pos == Vector2(464, 1072):
		Global.game.play_dialogue("MAP136_NPC_1")
	return null
