extends Node2D # gen_map.py Map045

var map_name = "Nowtoch City(Metro)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(240, 272):
		Global.game.play_dialogue("MAP045_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP045_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
