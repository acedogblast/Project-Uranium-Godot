extends Node2D # gen_map.py Map107

var map_name = "Labyrinth(Underwater)"

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP107_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(587, 1)
		Global.game.recive_item(587)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP107_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(296, 1)
		Global.game.recive_item(296)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
