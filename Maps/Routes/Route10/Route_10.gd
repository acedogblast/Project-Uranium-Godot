extends Node2D # gen_map.py Map143

var map_name = "Route 10"

var wild_table = [
	[109,  20, 23, 27],
	[107,  20, 22, 27],
	[109,  10, 22, 28],
	[107,  10, 21, 28],
	[105,  10, 20, 25],
	[105,  10, 19, 24],
	[32,   5, 21, 26],
	[32,   5, 22, 26],
	[32,   4, 22, 27],
	[107,   4, 23, 29],
	[33,   1, 30, 30],
	[110,   1, 28, 32],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(3792, 1520):
		Global.game.play_dialogue("MAP143_SIGN_1")
	if check_pos == Vector2(2768, 2512):
		Global.game.play_dialogue("MAP143_SIGN_2")
	if check_pos == Vector2(1808, 1136):
		Global.game.play_dialogue("MAP143_NPC_1")
	if check_pos == Vector2(2672, 880):
		Global.game.play_dialogue("MAP143_NPC_2")
	if check_pos == Vector2(2640, 1232):
		Global.game.play_dialogue("MAP143_NPC_3")
	if check_pos == Vector2(3120, 1264):
		Global.game.play_dialogue("MAP143_NPC_4")
	if check_pos == Vector2(2480, 1648):
		Global.game.play_dialogue("MAP143_NPC_5")
	if check_pos == Vector2(3056, 1584):
		Global.game.play_dialogue("MAP143_NPC_6")
	if check_pos == Vector2(2896, 1648):
		Global.game.play_dialogue("MAP143_NPC_7")
	if check_pos == Vector2(4592, 784):
		Global.game.play_dialogue("MAP143_NPC_8")
	if check_pos == Vector2(4272, 1616):
		Global.game.play_dialogue("MAP143_NPC_9")
	if check_pos == Vector2(1040, 1584):
		Global.game.play_dialogue("MAP143_NPC_10")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(283, 1)
		Global.game.recive_item(283)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(115, 1)
		Global.game.recive_item(115)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(213, 1)
		Global.game.recive_item(213)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(210, 1)
		Global.game.recive_item(210)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(285, 1)
		Global.game.recive_item(285)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP143_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(518, 1)
		Global.game.recive_item(518)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP143_TRAINER_1", "defeat": "MAP143_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer012.png"},
	"Trainer2": {"pre": "MAP143_TRAINER_2", "defeat": "MAP143_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer041.png"},
	"Trainer3": {"pre": "MAP143_TRAINER_3", "defeat": "MAP143_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer042.png"},
	"Trainer4": {"pre": "MAP143_TRAINER_4", "defeat": "MAP143_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer086.png"},
	"Trainer5": {"pre": "MAP143_TRAINER_5", "defeat": "MAP143_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer086.png"},
	"Trainer6": {"pre": "MAP143_TRAINER_6", "defeat": "MAP143_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer053.png"},
	"Trainer7": {"pre": "MAP143_TRAINER_7", "defeat": "MAP143_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer060.png"},
	"Trainer8": {"pre": "MAP143_TRAINER_8", "defeat": "MAP143_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP143_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP143_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP143_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
