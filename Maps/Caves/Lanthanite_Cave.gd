extends Node2D # gen_map.py Map106

var map_name = "Lanthanite Cave"

var wild_table = [
	[152,  20, 42, 45],
	[152,  20, 40, 44],
	[153,  20, 42, 45],
	[77,  20, 42, 45],
	[147,  10, 40, 43],
	[155,   9, 42, 45],
	[155,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(2736, 1104):
		Global.game.play_dialogue("MAP106_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(304, 1)
		Global.game.recive_item(304)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(94, 1)
		Global.game.recive_item(94)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(245, 1)
		Global.game.recive_item(245)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(199, 1)
		Global.game.recive_item(199)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(205, 1)
		Global.game.recive_item(205)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(185, 1)
		Global.game.recive_item(185)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(120, 1)
		Global.game.recive_item(120)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP106_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(307, 1)
		Global.game.recive_item(307)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
