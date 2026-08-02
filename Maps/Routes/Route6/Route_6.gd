extends Node2D # gen_map.py Map022

var map_name = "Route 06"
var map_px_size = Vector2(4160, 1920)
var edge_connections = [["E", "res://Maps/RochfaleTown/Rochfale_Town.tscn", 0, 16, 2240]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(432, 1136):
		Global.game.play_dialogue("MAP022_SIGN_1")
	if check_pos == Vector2(432, 368):
		Global.game.play_dialogue("MAP022_SIGN_2")
	if check_pos == Vector2(2768, 1264):
		Global.game.play_dialogue("MAP022_NPC_1")
	if check_pos == Vector2(1424, 1200):
		Global.game.play_dialogue("MAP022_NPC_2")
	if check_pos == Vector2(3696, 336):
		Global.game.play_dialogue("MAP022_NPC_3")
	if check_pos == Vector2(336, 1232):
		Global.game.play_dialogue("MAP022_NPC_4")
	if check_pos == Vector2(336, 1200):
		Global.game.play_dialogue("MAP022_NPC_5")
	if check_pos == Vector2(336, 1264):
		Global.game.play_dialogue("MAP022_NPC_6")
	if check_pos == Vector2(3440, 1136):
		Global.game.play_dialogue("MAP022_NPC_7")
	if check_pos == Vector2(3440, 1168):
		Global.game.play_dialogue("MAP022_NPC_8")
	if check_pos == Vector2(3440, 1200):
		Global.game.play_dialogue("MAP022_NPC_9")
	if check_pos == Vector2(3440, 1232):
		Global.game.play_dialogue("MAP022_NPC_10")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(275, 1)
		Global.game.recive_item(275)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(272, 1)
		Global.game.recive_item(272)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(171, 1)
		Global.game.recive_item(171)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(181, 1)
		Global.game.recive_item(181)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(2, 1)
		Global.game.recive_item(2)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(207, 1)
		Global.game.recive_item(207)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP022_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(299, 1)
		Global.game.recive_item(299)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP022_TRAINER_1", "defeat": "MAP022_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer060.png"},
	"Trainer10": {"pre": "MAP022_TRAINER_10", "defeat": "MAP022_TRAINER_10_DEFEAT", "portrait": "Graphics/Characters/trainer055.png"},
	"Trainer11": {"pre": "MAP022_TRAINER_11", "defeat": "MAP022_TRAINER_11_DEFEAT", "portrait": "Graphics/Characters/trainer037.png"},
	"Trainer12": {"pre": "MAP022_TRAINER_12", "defeat": "MAP022_TRAINER_12_DEFEAT", "portrait": "Graphics/Characters/trainer046.png"},
	"Trainer13": {"pre": "MAP022_TRAINER_13", "defeat": "MAP022_TRAINER_13_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"},
	"Trainer14": {"pre": "MAP022_TRAINER_14", "defeat": "MAP022_TRAINER_14_DEFEAT", "portrait": "Graphics/Characters/trainer059.png"},
	"Trainer15": {"pre": "MAP022_TRAINER_15", "defeat": "MAP022_TRAINER_15_DEFEAT", "portrait": "Graphics/Characters/trainer002.png"},
	"Trainer16": {"pre": "MAP022_TRAINER_16", "defeat": "MAP022_TRAINER_16_DEFEAT", "portrait": "Graphics/Characters/trainer056.png"},
	"Trainer17": {"pre": "MAP022_TRAINER_17", "defeat": "MAP022_TRAINER_17_DEFEAT", "portrait": "Graphics/Characters/trainer004.png"},
	"Trainer2": {"pre": "MAP022_TRAINER_2", "defeat": "MAP022_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer059.png"},
	"Trainer3": {"pre": "MAP022_TRAINER_3", "defeat": "MAP022_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer004.png"},
	"Trainer4": {"pre": "MAP022_TRAINER_4", "defeat": "MAP022_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer059.png"},
	"Trainer5": {"pre": "MAP022_TRAINER_5", "defeat": "MAP022_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer014.png"},
	"Trainer6": {"pre": "MAP022_TRAINER_6", "defeat": "MAP022_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer002.png"},
	"Trainer7": {"pre": "MAP022_TRAINER_7", "defeat": "MAP022_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer059.png"},
	"Trainer8": {"pre": "MAP022_TRAINER_8", "defeat": "MAP022_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer021.png"},
	"Trainer9": {"pre": "MAP022_TRAINER_9", "defeat": "MAP022_TRAINER_9_DEFEAT", "portrait": "Graphics/Characters/trainer012.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP022_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP022_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP022_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
