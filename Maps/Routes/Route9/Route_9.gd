extends Node2D # gen_map.py Map021

var map_name = "Route 09"

var wild_table = [
	[65,  20, 18, 25],
	[99,  20, 20, 25],
	[101,  20, 21, 26],
	[103,  20, 20, 26],
	[61,   8, 24, 26],
	[33,   5, 26, 27],
	[66,   5, 27, 28],
	[17,   2, 28, 28],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(432, 304):
		Global.game.play_dialogue("MAP021_SIGN_1")
	if check_pos == Vector2(2032, 624):
		Global.game.play_dialogue("MAP021_SIGN_2")
	if check_pos == Vector2(2064, 272):
		Global.game.play_dialogue("MAP021_NPC_1")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP021_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(14, 1)
		Global.game.recive_item(14)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP021_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(279, 1)
		Global.game.recive_item(279)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP021_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(312, 1)
		Global.game.recive_item(312)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP021_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(280, 1)
		Global.game.recive_item(280)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP021_TRAINER_1", "defeat": "MAP021_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer095.png"},
	"Trainer2": {"pre": "MAP021_TRAINER_2", "defeat": "MAP021_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer060.png"},
	"Trainer3": {"pre": "MAP021_TRAINER_3", "defeat": "MAP021_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer053.png"},
	"Trainer4": {"pre": "MAP021_TRAINER_4", "defeat": "MAP021_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP021_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP021_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP021_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
