extends Node2D # gen_map.py Map189

var map_name = "Nuclear Plant Zeta (3 South)"

var wild_table = [
	[66,  30, 51, 54],
	[21,  30, 51, 54],
	[88,  21, 51, 54],
	[99,  15, 51, 54],
	[100,   4, 51, 54],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(656, 2128):
		Global.game.play_dialogue("MAP189_SIGN_1")
	if check_pos == Vector2(688, 2128):
		Global.game.play_dialogue("MAP189_SIGN_2")
	if check_pos == Vector2(656, 2160):
		Global.game.play_dialogue("MAP189_SIGN_3")
	if check_pos == Vector2(688, 2160):
		Global.game.play_dialogue("MAP189_SIGN_4")
	if check_pos == Vector2(528, 1552):
		Global.game.play_dialogue("MAP189_SIGN_5")
	if check_pos == Vector2(240, 848):
		Global.game.play_dialogue("MAP189_SIGN_6")
	if check_pos == Vector2(240, 1456):
		Global.game.play_dialogue("MAP189_SIGN_7")
	if check_pos == Vector2(368, 1424):
		Global.game.play_dialogue("MAP189_SIGN_8")
	if check_pos == Vector2(272, 1616):
		Global.game.play_dialogue("MAP189_SIGN_9")
	if check_pos == Vector2(464, 1520):
		Global.game.play_dialogue("MAP189_SIGN_10")
	if check_pos == Vector2(304, 816):
		Global.game.play_dialogue("MAP189_NPC_1")
	if check_pos == Vector2(272, 816):
		Global.game.play_dialogue("MAP189_NPC_2")
	if check_pos == Vector2(336, 816):
		Global.game.play_dialogue("MAP189_NPC_3")
	if check_pos == Vector2(432, 880):
		Global.game.play_dialogue("MAP189_NPC_4")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP189_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(202, 1)
		Global.game.recive_item(202)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP189_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(209, 1)
		Global.game.recive_item(209)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP189_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(174, 1)
		Global.game.recive_item(174)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP189_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(202, 1)
		Global.game.recive_item(202)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP189_TRAINER_1", "defeat": "MAP189_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer119.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP189_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP189_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP189_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
