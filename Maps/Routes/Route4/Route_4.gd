extends Node2D # gen_map.py Map076

var map_name = "Route 04"
var map_px_size = Vector2(1984, 3680)
var edge_connections = [["N", "res://Maps/Routes/Route5/Route_5.tscn", 1664, 1424, 3392]]

var wild_table = [
	[44,  25, 12, 14],
	[48,  25, 12, 14],
	[46,  20, 12, 14],
	[50,  19, 12, 14],
	[53,  10, 12, 14],
	[8,   1, 14, 15],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(848, 912):
		Global.game.play_dialogue("MAP076_SIGN_1")
	if check_pos == Vector2(1040, 304):
		Global.game.play_dialogue("MAP076_SIGN_2")
	if check_pos == Vector2(880, 2544):
		Global.game.play_dialogue("MAP076_SIGN_3")
	if check_pos == Vector2(912, 3248):
		Global.game.play_dialogue("MAP076_NPC_1")
	if check_pos == Vector2(272, 1008):
		Global.game.play_dialogue("MAP076_NPC_2")
	if check_pos == Vector2(1264, 2448):
		Global.game.play_dialogue("MAP076_NPC_3")
	if check_pos == Vector2(976, 304):
		Global.game.play_dialogue("MAP076_NPC_4")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(197, 1)
		Global.game.recive_item(197)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(195, 1)
		Global.game.recive_item(195)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(171, 1)
		Global.game.recive_item(171)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(242, 1)
		Global.game.recive_item(242)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(14, 1)
		Global.game.recive_item(14)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(240, 1)
		Global.game.recive_item(240)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(35, 1)
		Global.game.recive_item(35)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(195, 1)
		Global.game.recive_item(195)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(220, 1)
		Global.game.recive_item(220)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(274, 1)
		Global.game.recive_item(274)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP076_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(523, 1)
		Global.game.recive_item(523)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP076_TRAINER_1", "defeat": "MAP076_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer032.png"},
	"Trainer2": {"pre": "MAP076_TRAINER_2", "defeat": "MAP076_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer049.png"},
	"Trainer3": {"pre": "MAP076_TRAINER_3", "defeat": "MAP076_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer063.png"},
	"Trainer4": {"pre": "MAP076_TRAINER_4", "defeat": "MAP076_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"},
	"Trainer5": {"pre": "MAP076_TRAINER_5", "defeat": "MAP076_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer062.png"},
	"Trainer6": {"pre": "MAP076_TRAINER_6", "defeat": "MAP076_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer003.png"},
	"Trainer7": {"pre": "MAP076_TRAINER_7", "defeat": "MAP076_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer016.png"},
	"Trainer8": {"pre": "MAP076_TRAINER_8", "defeat": "MAP076_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer028.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP076_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP076_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP076_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
