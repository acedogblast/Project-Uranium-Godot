extends Node2D # gen_map.py Map184

var map_name = "Victory Road(volcano)"

var wild_table = [
	[187,  30, 25, 30],
	[41,  30, 50, 54],
	[74,  20, 50, 54],
	[104,  15, 50, 54],
	[144,   5, 55, 55],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(2768, 1936):
		Global.game.play_dialogue("MAP184_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(205, 1)
		Global.game.recive_item(205)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(267, 1)
		Global.game.recive_item(267)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(291, 1)
		Global.game.recive_item(291)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(3, 1)
		Global.game.recive_item(3)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item7") != null and check_pos == $NPC_Layer/Item7.position:
		Global.game.lock_player()
		Global.past_events.append("MAP184_ITEM_7_TAKEN")
		Global.inventory.add_item_by_id_multiple(200, 1)
		Global.game.recive_item(200)
		$NPC_Layer/Item7.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP184_TRAINER_1", "defeat": "MAP184_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer055.png"},
	"Trainer2": {"pre": "MAP184_TRAINER_2", "defeat": "MAP184_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer041.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP184_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP184_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP184_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
