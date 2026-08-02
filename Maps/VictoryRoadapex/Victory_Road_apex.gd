extends Node2D # gen_map.py Map186

var map_name = "Victory Road(apex)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(912, 688):
		Global.game.play_dialogue("MAP186_SIGN_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP186_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(322, 1)
		Global.game.recive_item(322)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
