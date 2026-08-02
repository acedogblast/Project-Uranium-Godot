extends Node2D # gen_map.py Map117

var map_name = "Route 08"
var map_px_size = Vector2(4096, 3392)
var edge_connections = [["N", "res://Maps/Routes/Route8/Route_8_plant.tscn", 32, 1104, 1280], ["E", "res://Maps/Routes/Route7/Route_7.tscn", 256, 16, 3200]]

var wild_table = [
	[90,  20, 21, 24],
	[44,  20, 21, 24],
	[57,  15, 22, 25],
	[90,  10, 23, 25],
	[92,  10, 20, 22],
	[60,  10, 21, 26],
	[92,   5, 21, 23],
	[94,   4, 24, 27],
	[44,   4, 23, 26],
	[58,   1, 25, 27],
	[94,   1, 25, 28],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(3120, 1168):
		Global.game.play_dialogue("MAP117_SIGN_1")
	if check_pos == Vector2(2512, 1424):
		Global.game.play_dialogue("MAP117_SIGN_2")
	if check_pos == Vector2(624, 2352):
		Global.game.play_dialogue("MAP117_SIGN_3")
	if check_pos == Vector2(944, 1264):
		Global.game.play_dialogue("MAP117_SIGN_4")
	if check_pos == Vector2(4016, 848):
		Global.game.play_dialogue("MAP117_NPC_1")
	if check_pos == Vector2(3024, 1200):
		Global.game.play_dialogue("MAP117_NPC_2")
	if check_pos == Vector2(2896, 1360):
		Global.game.play_dialogue("MAP117_NPC_3")
	if check_pos == Vector2(2128, 1520):
		Global.game.play_dialogue("MAP117_NPC_4")
	if check_pos == Vector2(1616, 528):
		Global.game.play_dialogue("MAP117_NPC_5")
	if check_pos == Vector2(2480, 784):
		Global.game.play_dialogue("MAP117_NPC_6")
	if check_pos == Vector2(1584, 496):
		Global.game.play_dialogue("MAP117_NPC_7")
	if check_pos == Vector2(2352, 1456):
		Global.game.play_dialogue("MAP117_NPC_8")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(260, 1)
		Global.game.recive_item(260)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(55, 1)
		Global.game.recive_item(55)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(181, 1)
		Global.game.recive_item(181)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(276, 1)
		Global.game.recive_item(276)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(171, 1)
		Global.game.recive_item(171)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(202, 1)
		Global.game.recive_item(202)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(241, 1)
		Global.game.recive_item(241)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP117_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(207, 1)
		Global.game.recive_item(207)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP117_TRAINER_1", "defeat": "MAP117_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer032.png"},
	"Trainer10": {"pre": "MAP117_TRAINER_10", "defeat": "MAP117_TRAINER_10_DEFEAT", "portrait": "Graphics/Characters/trainer034.png"},
	"Trainer2": {"pre": "MAP117_TRAINER_2", "defeat": "MAP117_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"},
	"Trainer3": {"pre": "MAP117_TRAINER_3", "defeat": "MAP117_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer002.png"},
	"Trainer4": {"pre": "MAP117_TRAINER_4", "defeat": "MAP117_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer016.png"},
	"Trainer5": {"pre": "MAP117_TRAINER_5", "defeat": "MAP117_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer060.png"},
	"Trainer6": {"pre": "MAP117_TRAINER_6", "defeat": "MAP117_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer012.png"},
	"Trainer7": {"pre": "MAP117_TRAINER_7", "defeat": "MAP117_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer093.png"},
	"Trainer8": {"pre": "MAP117_TRAINER_8", "defeat": "MAP117_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer063.png"},
	"Trainer9": {"pre": "MAP117_TRAINER_9", "defeat": "MAP117_TRAINER_9_DEFEAT", "portrait": "Graphics/Characters/trainer118.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP117_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP117_" + String(c.name).to_upper() + "_DEFEATED"):
			c.seeking = false
			c.defeated = true

func trainer_battle(npc_trainer):
	Global.game.lock_player()
	npc_trainer.seeking = false
	npc_trainer.alert()
	await npc_trainer.alert_done
	Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-MaleEncounter.ogg")
	Global.game.get_node("Background_music").play()
	match npc_trainer.facing:
		"Up": Global.game.player.set_facing_direction("Down")
		"Down": Global.game.player.set_facing_direction("Up")
		"Left": Global.game.player.set_facing_direction("Right")
		"Right": Global.game.player.set_facing_direction("Left")
	npc_trainer.move_to_player()
	await npc_trainer.done_movement
	var data = _trainer_data.get(String(npc_trainer.name), {})
	if data.get("pre", "") != "":
		Global.game.play_dialogue_with_point(data["pre"], npc_trainer.get_global_transform_with_canvas().get_origin())
		await Global.game.event_dialogue_end
	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.FEILD_1
	bid.opponent = Opponent.new()
	bid.opponent.name = npc_trainer.trainer_name
	if data.get("portrait", "") != "":
		bid.opponent.battle_texture = load("res://" + data["portrait"])
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr(data.get("defeat", "..."))
	bid.victory_award = npc_trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = npc_trainer.get_poke_group()
	Global.game.trainer_battle(bid)
	await Global.game.battle.battle_complete
	if Global.game.battle.player_won:
		npc_trainer.defeated = true
		Global.past_events.append("MAP117_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
