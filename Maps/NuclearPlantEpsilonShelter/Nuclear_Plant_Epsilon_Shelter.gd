extends Node2D # gen_map.py Map123

var map_name = "Nuclear Plant Epsilon(Shelter)"

var wild_table = [
	[65,  20, 18, 18],
	[65,  20, 16, 18],
	[46,  10, 17, 19],
	[46,  10, 16, 18],
	[65,  10, 17, 19],
	[65,  10, 17, 18],
	[7,   5, 16, 18],
	[8,   5, 16, 18],
	[8,   4, 18, 19],
	[7,   4, 18, 18],
	[46,   1, 19, 21],
	[7,   1, 15, 20],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1072, 304):
		Global.game.play_dialogue("MAP123_SIGN_1")
	if check_pos == Vector2(816, 368):
		Global.game.play_dialogue("MAP123_SIGN_2")
	if check_pos == Vector2(1296, 1584):
		Global.game.play_dialogue("MAP123_SIGN_3")
	if check_pos == Vector2(1872, 208):
		Global.game.play_dialogue("MAP123_SIGN_4")
	if check_pos == Vector2(80, 2320):
		Global.game.play_dialogue("MAP123_SIGN_5")
	if check_pos == Vector2(464, 304):
		Global.game.play_dialogue("MAP123_SIGN_6")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP123_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(573, 1)
		Global.game.recive_item(573)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP123_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(574, 1)
		Global.game.recive_item(574)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
