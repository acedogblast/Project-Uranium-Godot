extends Node2D # gen_map.py Map135

var map_name = "Snowbank Town"
var map_px_size = Vector2(1920, 1920)
var edge_connections = [["N", "res://Maps/SnowbankTown/Snowbank_Town_Gym.tscn", -448, 1584, 1024]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(944, 1424):
		Global.game.play_dialogue("MAP135_SIGN_1")
	if check_pos == Vector2(944, 1520):
		Global.game.play_dialogue("MAP135_NPC_1")
	if check_pos == Vector2(976, 752):
		Global.game.play_dialogue("MAP135_NPC_2")
	if check_pos == Vector2(1040, 1200):
		Global.game.play_dialogue("MAP135_NPC_3")
	if check_pos == Vector2(880, 464):
		Global.game.play_dialogue("MAP135_NPC_4")
	if check_pos == Vector2(1296, 752):
		Global.game.play_dialogue("MAP135_NPC_5")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP135_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(320, 1)
		Global.game.recive_item(320)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
