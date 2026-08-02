extends Node2D # gen_map.py Map145

var map_name = "Route 13"
var map_px_size = Vector2(3264, 1824)
var edge_connections = [["S", "res://Maps/VenesiCity/Venesi_City.tscn", -2016, 16, 2624]]

var wild_table = [
	[47,  20, 30, 36],
	[36,  20, 30, 34],
	[126,  20, 30, 35],
	[123,  10, 30, 32],
	[123,  10, 30, 34],
	[47,   5, 32, 37],
	[36,   5, 31, 35],
	[128,   4, 30, 30],
	[129,   4, 26, 30],
	[128,   1, 32, 32],
	[129,   1, 32, 32],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(2736, 1712):
		Global.game.play_dialogue("MAP145_SIGN_1")
	if check_pos == Vector2(2064, 1072):
		Global.game.play_dialogue("MAP145_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP145_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(319, 1)
		Global.game.recive_item(319)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP145_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(234, 1)
		Global.game.recive_item(234)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP145_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP145_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP145_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(199, 1)
		Global.game.recive_item(199)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP145_TRAINER_1", "defeat": "MAP145_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer061.png"},
	"Trainer2": {"pre": "MAP145_TRAINER_2", "defeat": "MAP145_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer014.png"},
	"Trainer3": {"pre": "MAP145_TRAINER_3", "defeat": "MAP145_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer041.png"},
	"Trainer4": {"pre": "MAP145_TRAINER_4", "defeat": "MAP145_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer007.png"},
	"Trainer5": {"pre": "MAP145_TRAINER_5", "defeat": "MAP145_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer095.png"},
	"Trainer6": {"pre": "MAP145_TRAINER_6", "defeat": "MAP145_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer062.png"},
	"Trainer7": {"pre": "MAP145_TRAINER_7", "defeat": "MAP145_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer004.png"},
	"Trainer8": {"pre": "MAP145_TRAINER_8", "defeat": "MAP145_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"},
	"Trainer9": {"pre": "MAP145_TRAINER_9", "defeat": "MAP145_TRAINER_9_DEFEAT", "portrait": "Graphics/Characters/trainer086.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP145_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP145_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP145_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
