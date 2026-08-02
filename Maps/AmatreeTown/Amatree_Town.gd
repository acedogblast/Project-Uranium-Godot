extends Node2D # gen_map.py Map151

var map_name = "Amatree Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1264, 1488):
		Global.game.play_dialogue("MAP151_SIGN_1")
	if check_pos == Vector2(624, 752):
		Global.game.play_dialogue("MAP151_SIGN_2")
	if check_pos == Vector2(688, 1264):
		Global.game.play_dialogue("MAP151_NPC_1")
	if check_pos == Vector2(1680, 1776):
		Global.game.play_dialogue("MAP151_NPC_2")
	if check_pos == Vector2(1712, 1520):
		Global.game.play_dialogue("MAP151_NPC_3")
	if check_pos == Vector2(560, 1648):
		Global.game.play_dialogue("MAP151_NPC_4")
	if check_pos == Vector2(624, 1520):
		Global.game.play_dialogue("MAP151_NPC_5")
	if check_pos == Vector2(1008, 1520):
		Global.game.play_dialogue("MAP151_NPC_6")
	if check_pos == Vector2(912, 1904):
		Global.game.play_dialogue("MAP151_NPC_7")
	if check_pos == Vector2(1744, 1616):
		Global.game.play_dialogue("MAP151_NPC_8")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP151_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(238, 1)
		Global.game.recive_item(238)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP151_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(288, 1)
		Global.game.recive_item(288)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null
