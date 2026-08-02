extends Node2D # gen_map.py Map096

var map_name = "Comet Cave"

var wild_table = [
	[20,  30, 13, 16],
	[18,  20, 13, 16],
	[54,  20, 13, 16],
	[22,  20, 13, 16],
	[24,   8, 13, 16],
	[25,   2, 13, 16],
]

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP096_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP096_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(268, 1)
		Global.game.recive_item(268)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP096_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(19, 1)
		Global.game.recive_item(19)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP096_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
