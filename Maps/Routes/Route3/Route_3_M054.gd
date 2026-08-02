extends Node2D # gen_map.py Map054

var map_name = "Route 03"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(304, 240):
		Global.game.play_dialogue("MAP054_NPC_1")
	if check_pos == Vector2(240, 176):
		Global.game.play_dialogue("MAP054_NPC_2")
	if check_pos == Vector2(144, 272):
		Global.game.play_dialogue("MAP054_NPC_3")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP054_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(213, 1)
		Global.game.recive_item(213)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
