extends Node2D # gen_map.py Map205

var map_name = "Route 07(Hidden Cave)"

var wild_table = [
	[78,  20, 15, 16],
	[78,  20, 16, 17],
	[18,  10, 17, 18],
	[18,  10, 16, 17],
	[85,  10, 17, 17],
	[85,  10, 16, 16],
	[85,   5, 15, 17],
	[81,   5, 15, 17],
	[78,   4, 17, 18],
	[81,   4, 18, 18],
	[85,   1, 19, 20],
	[85,   1, 19, 19],
]

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP205_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(205, 1)
		Global.game.recive_item(205)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
