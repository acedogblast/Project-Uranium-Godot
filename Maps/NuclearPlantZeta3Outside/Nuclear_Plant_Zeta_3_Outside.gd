extends Node2D # gen_map.py Map190

var map_name = "Nuclear Plant Zeta(3 Outside)"

var wild_table = [
	[66,  30, 52, 55],
	[172,  30, 52, 55],
	[88,  15, 52, 55],
	[53,  15, 52, 55],
	[168,   5, 52, 55],
	[89,   5, 52, 55],
]

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP190_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(200, 1)
		Global.game.recive_item(200)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP190_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(576, 1)
		Global.game.recive_item(576)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP190_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(323, 1)
		Global.game.recive_item(323)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
