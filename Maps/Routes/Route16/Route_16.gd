extends Node2D # gen_map.py Map132

var map_name = "Route 16"

var wild_table = [
	[152,  20, 32, 35],
	[149,  20, 32, 36],
	[149,  15, 38, 38],
	[149,  10, 32, 37],
	[152,  10, 33, 35],
	[61,  10, 35, 38],
	[151,   5, 42, 42],
	[153,   4, 36, 42],
	[155,   4, 35, 38],
	[155,   1, 36, 38],
	[150,   1, 42, 42],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1072, 976):
		Global.game.play_dialogue("MAP132_SIGN_1")
	if check_pos == Vector2(1136, 1264):
		Global.game.play_dialogue("MAP132_SIGN_2")
	if check_pos == Vector2(2288, 528):
		Global.game.play_dialogue("MAP132_SIGN_3")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(309, 1)
		Global.game.recive_item(309)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(16, 1)
		Global.game.recive_item(16)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(123, 1)
		Global.game.recive_item(123)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(174, 1)
		Global.game.recive_item(174)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(181, 1)
		Global.game.recive_item(181)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(184, 1)
		Global.game.recive_item(184)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(197, 1)
		Global.game.recive_item(197)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(202, 1)
		Global.game.recive_item(202)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(317, 1)
		Global.game.recive_item(317)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item12") != null and check_pos == $NPC_Layer/Item12.position:
		Global.game.lock_player()
		Global.past_events.append("MAP132_ITEM_12_TAKEN")
		Global.inventory.add_item_by_id_multiple(35, 1)
		Global.game.recive_item(35)
		$NPC_Layer/Item12.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP132_TRAINER_1", "defeat": "MAP132_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer082.png"},
	"Trainer2": {"pre": "MAP132_TRAINER_2", "defeat": "MAP132_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer081.png"},
	"Trainer3": {"pre": "MAP132_TRAINER_3", "defeat": "MAP132_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer081.png"},
	"Trainer4": {"pre": "MAP132_TRAINER_4", "defeat": "MAP132_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer082.png"},
	"Trainer5": {"pre": "MAP132_TRAINER_5", "defeat": "MAP132_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer082.png"},
	"Trainer6": {"pre": "MAP132_TRAINER_6", "defeat": "MAP132_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer041.png"},
	"Trainer7": {"pre": "MAP132_TRAINER_7", "defeat": "MAP132_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer082.png"},
	"Trainer8": {"pre": "MAP132_TRAINER_8", "defeat": "MAP132_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer041.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP132_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP132_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP132_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
