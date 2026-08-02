extends Node2D # gen_map.py Map008

var map_name = "Route 07"
var map_px_size = Vector2(3200, 3200)
var edge_connections = [["W", "res://Maps/Routes/Route8/Route_8.tscn", -256, 4080, 3392], ["N", "res://Maps/BealbeachCity/Bealbeach_City.tscn", -1696, 2288, 2560]]

var wild_table = [
	[78,  20, 15, 16],
	[78,  20, 16, 17],
	[18,  10, 17, 18],
	[18,  10, 16, 17],
	[85,  10, 17, 17],
	[85,  10, 16, 16],
	[85,   5, 15, 17],
	[81,   5, 15, 17],
	[78,   4, 17, 18],
	[81,   4, 18, 18],
	[85,   1, 19, 20],
	[85,   1, 19, 19],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 1040):
		Global.game.play_dialogue("MAP008_SIGN_1")
	if check_pos == Vector2(1904, 2032):
		Global.game.play_dialogue("MAP008_SIGN_2")
	if check_pos == Vector2(2320, 432):
		Global.game.play_dialogue("MAP008_NPC_1")
	if check_pos == Vector2(560, 2896):
		Global.game.play_dialogue("MAP008_NPC_2")
	if check_pos == Vector2(80, 1104):
		Global.game.play_dialogue("MAP008_NPC_3")
	if check_pos == Vector2(80, 1072):
		Global.game.play_dialogue("MAP008_NPC_4")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(12, 1)
		Global.game.recive_item(12)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(118, 1)
		Global.game.recive_item(118)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(117, 1)
		Global.game.recive_item(117)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(3, 1)
		Global.game.recive_item(3)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(17, 1)
		Global.game.recive_item(17)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item8") != null and check_pos == $NPC_Layer/Item8.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_8_TAKEN")
		Global.inventory.add_item_by_id_multiple(213, 1)
		Global.game.recive_item(213)
		$NPC_Layer/Item8.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item9") != null and check_pos == $NPC_Layer/Item9.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_9_TAKEN")
		Global.inventory.add_item_by_id_multiple(195, 1)
		Global.game.recive_item(195)
		$NPC_Layer/Item9.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item10") != null and check_pos == $NPC_Layer/Item10.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_10_TAKEN")
		Global.inventory.add_item_by_id_multiple(243, 1)
		Global.game.recive_item(243)
		$NPC_Layer/Item10.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item11") != null and check_pos == $NPC_Layer/Item11.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_11_TAKEN")
		Global.inventory.add_item_by_id_multiple(78, 1)
		Global.game.recive_item(78)
		$NPC_Layer/Item11.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item12") != null and check_pos == $NPC_Layer/Item12.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_12_TAKEN")
		Global.inventory.add_item_by_id_multiple(513, 1)
		Global.game.recive_item(513)
		$NPC_Layer/Item12.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item13") != null and check_pos == $NPC_Layer/Item13.position:
		Global.game.lock_player()
		Global.past_events.append("MAP008_ITEM_13_TAKEN")
		Global.inventory.add_item_by_id_multiple(233, 1)
		Global.game.recive_item(233)
		$NPC_Layer/Item13.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP008_TRAINER_1", "defeat": "MAP008_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer003.png"},
	"Trainer2": {"pre": "MAP008_TRAINER_2", "defeat": "MAP008_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"},
	"Trainer3": {"pre": "MAP008_TRAINER_3", "defeat": "MAP008_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer056.png"},
	"Trainer4": {"pre": "MAP008_TRAINER_4", "defeat": "MAP008_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer016.png"},
	"Trainer5": {"pre": "MAP008_TRAINER_5", "defeat": "MAP008_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer016.png"},
	"Trainer6": {"pre": "MAP008_TRAINER_6", "defeat": "MAP008_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer011.png"},
	"Trainer7": {"pre": "MAP008_TRAINER_7", "defeat": "MAP008_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer086.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP008_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP008_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP008_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
