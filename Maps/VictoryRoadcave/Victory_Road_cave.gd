extends Node2D # gen_map.py Map074

var map_name = "Victory Road(cave)"

var wild_table = [
	[19,  30, 48, 52],
	[74,  20, 48, 52],
	[55,  20, 48, 52],
	[21,  20, 48, 52],
	[62,   4, 50, 54],
	[62,   4, 50, 55],
	[62,   2, 55, 55],
]

func interaction(check_pos : Vector2, _direction):
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(548, 1)
		Global.game.recive_item(548)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(220, 1)
		Global.game.recive_item(220)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(258, 1)
		Global.game.recive_item(258)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(551, 1)
		Global.game.recive_item(551)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(555, 1)
		Global.game.recive_item(555)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(255, 1)
		Global.game.recive_item(255)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(220, 1)
		Global.game.recive_item(220)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(185, 1)
		Global.game.recive_item(185)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(303, 1)
		Global.game.recive_item(303)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(35, 1)
		Global.game.recive_item(35)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item12") != null and check_pos == $NPC_Layer/Item12.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_12_TAKEN")
		Global.inventory.add_item_by_id_multiple(3, 1)
		Global.game.recive_item(3)
		$NPC_Layer/Item12.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item13") != null and check_pos == $NPC_Layer/Item13.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_13_TAKEN")
		Global.inventory.add_item_by_id_multiple(181, 1)
		Global.game.recive_item(181)
		$NPC_Layer/Item13.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item14") != null and check_pos == $NPC_Layer/Item14.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_14_TAKEN")
		Global.inventory.add_item_by_id_multiple(220, 1)
		Global.game.recive_item(220)
		$NPC_Layer/Item14.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item15") != null and check_pos == $NPC_Layer/Item15.position:
		Global.game.lock_player()
		Global.past_events.append("MAP074_ITEM_15_TAKEN")
		Global.inventory.add_item_by_id_multiple(305, 1)
		Global.game.recive_item(305)
		$NPC_Layer/Item15.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP074_TRAINER_1", "defeat": "MAP074_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer056.png"},
	"Trainer2": {"pre": "MAP074_TRAINER_2", "defeat": "MAP074_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"},
	"Trainer3": {"pre": "MAP074_TRAINER_3", "defeat": "MAP074_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer055.png"},
	"Trainer4": {"pre": "MAP074_TRAINER_4", "defeat": "MAP074_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"},
	"Trainer5": {"pre": "MAP074_TRAINER_5", "defeat": "MAP074_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer055.png"},
	"Trainer6": {"pre": "MAP074_TRAINER_6", "defeat": "MAP074_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer005.png"},
	"Trainer7": {"pre": "MAP074_TRAINER_7", "defeat": "MAP074_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer055.png"},
	"Trainer8": {"pre": "MAP074_TRAINER_8", "defeat": "MAP074_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer004.png"},
	"Trainer9": {"pre": "MAP074_TRAINER_9", "defeat": "MAP074_TRAINER_9_DEFEAT", "portrait": "Graphics/Characters/trainer095.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP074_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP074_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP074_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
