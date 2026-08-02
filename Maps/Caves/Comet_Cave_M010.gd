extends Node2D # gen_map.py Map010

var map_name = "Comet Cave"

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP010_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(253, 1)
		Global.game.recive_item(253)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
