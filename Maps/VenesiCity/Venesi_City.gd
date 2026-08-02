extends Node2D # gen_map.py Map144

var map_name = "Venesi City"
var map_px_size = Vector2(2624, 1856)
var edge_connections = [["E", "res://Maps/Routes/Route14/Route_14.tscn", -640, 16, 3520], ["N", "res://Maps/Routes/Route13/Route_13.tscn", 2016, 1808, 3264]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(784, 1040):
		Global.game.play_dialogue("MAP144_SIGN_1")
	if check_pos == Vector2(2096, 1552):
		Global.game.play_dialogue("MAP144_SIGN_2")
	if check_pos == Vector2(1584, 464):
		Global.game.play_dialogue("MAP144_SIGN_3")
	if check_pos == Vector2(1168, 1040):
		Global.game.play_dialogue("MAP144_NPC_1")
	if check_pos == Vector2(1072, 752):
		Global.game.play_dialogue("MAP144_NPC_2")
	if check_pos == Vector2(1168, 336):
		Global.game.play_dialogue("MAP144_NPC_3")
	if check_pos == Vector2(1296, 1520):
		Global.game.play_dialogue("MAP144_NPC_4")
	if check_pos == Vector2(2000, 1040):
		Global.game.play_dialogue("MAP144_NPC_5")
	if check_pos == Vector2(976, 336):
		Global.game.play_dialogue("MAP144_NPC_6")
	if check_pos == Vector2(1840, 1584):
		Global.game.play_dialogue("MAP144_NPC_7")
	if check_pos == Vector2(1904, 784):
		Global.game.play_dialogue("MAP144_NPC_8")
	if check_pos == Vector2(1072, 1392):
		Global.game.play_dialogue("MAP144_NPC_9")
	if check_pos == Vector2(1872, 848):
		Global.game.play_dialogue("MAP144_NPC_10")
	if check_pos == Vector2(1040, 528):
		Global.game.play_dialogue("MAP144_NPC_11")
	if check_pos == Vector2(1968, 688):
		Global.game.play_dialogue("MAP144_NPC_12")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP144_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(295, 1)
		Global.game.recive_item(295)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
