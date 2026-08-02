extends Node2D # gen_map.py Map203

var map_name = "Victory Road (Secret Garden)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(464, 528):
		Global.game.play_dialogue("MAP203_NPC_1")
	if check_pos == Vector2(528, 528):
		Global.game.play_dialogue("MAP203_NPC_2")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP203_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(318, 1)
		Global.game.recive_item(318)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
