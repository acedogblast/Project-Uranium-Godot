extends Node2D # gen_map.py Map128

var map_name = "Legen Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1232, 1040):
		Global.game.play_dialogue("MAP128_SIGN_1")
	if check_pos == Vector2(880, 528):
		Global.game.play_dialogue("MAP128_SIGN_2")
	if check_pos == Vector2(912, 1744):
		Global.game.play_dialogue("MAP128_SIGN_3")
	if check_pos == Vector2(1232, 1296):
		Global.game.play_dialogue("MAP128_SIGN_4")
	if check_pos == Vector2(2096, 1328):
		Global.game.play_dialogue("MAP128_SIGN_5")
	if check_pos == Vector2(656, 880):
		Global.game.play_dialogue("MAP128_NPC_1")
	if check_pos == Vector2(688, 1264):
		Global.game.play_dialogue("MAP128_NPC_2")
	if check_pos == Vector2(912, 912):
		Global.game.play_dialogue("MAP128_NPC_3")
	if check_pos == Vector2(496, 368):
		Global.game.play_dialogue("MAP128_NPC_4")
	if check_pos == Vector2(1136, 1232):
		Global.game.play_dialogue("MAP128_NPC_5")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP128_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(126, 1)
		Global.game.recive_item(126)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP128_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(2, 1)
		Global.game.recive_item(2)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP128_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(311, 1)
		Global.game.recive_item(311)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP128_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(237, 1)
		Global.game.recive_item(237)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
