extends Node2D # gen_map.py Map192

var map_name = "Nuclear Plant Zeta(3 West)"

var wild_table = [
	[66,  30, 52, 55],
	[88,  21, 52, 55],
	[21,  20, 52, 55],
	[167,  15, 52, 55],
	[99,  10, 52, 55],
	[100,   4, 52, 55],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(656, 816):
		Global.game.play_dialogue("MAP192_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP192_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(549, 1)
		Global.game.recive_item(549)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
