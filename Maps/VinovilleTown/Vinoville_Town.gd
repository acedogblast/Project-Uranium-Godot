extends Node2D # gen_map.py Map121

var map_name = "Vinoville Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(2512, 2064):
		Global.game.play_dialogue("MAP121_SIGN_1")
	if check_pos == Vector2(496, 656):
		Global.game.play_dialogue("MAP121_SIGN_2")
	if check_pos == Vector2(1456, 848):
		Global.game.play_dialogue("MAP121_SIGN_3")
	if check_pos == Vector2(1808, 1936):
		Global.game.play_dialogue("MAP121_NPC_1")
	if check_pos == Vector2(1968, 880):
		Global.game.play_dialogue("MAP121_NPC_2")
	if check_pos == Vector2(1104, 1104):
		Global.game.play_dialogue("MAP121_NPC_3")
	if check_pos == Vector2(1584, 880):
		Global.game.play_dialogue("MAP121_NPC_4")
	if check_pos == Vector2(2320, 976):
		Global.game.play_dialogue("MAP121_NPC_5")
	if check_pos == Vector2(1392, 1456):
		Global.game.play_dialogue("MAP121_NPC_6")
	if check_pos == Vector2(2000, 1680):
		Global.game.play_dialogue("MAP121_NPC_7")
	if check_pos == Vector2(2000, 1648):
		Global.game.play_dialogue("MAP121_NPC_8")
	if check_pos == Vector2(1264, 1904):
		Global.game.play_dialogue("MAP121_NPC_9")
	if check_pos == Vector2(1264, 848):
		Global.game.play_dialogue("MAP121_NPC_10")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP121_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(496, 1)
		Global.game.recive_item(496)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP121_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(207, 1)
		Global.game.recive_item(207)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP121_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(314, 1)
		Global.game.recive_item(314)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
