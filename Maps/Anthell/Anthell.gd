extends Node2D # gen_map.py Map150

var map_name = "Anthell"

var wild_table = [
	[40,  20, 19, 26],
	[48,  20, 22, 27],
	[63,  10, 22, 28],
	[63,  10, 22, 27],
	[40,  10, 20, 27],
	[48,  10, 23, 28],
	[63,   5, 23, 28],
	[63,   5, 24, 28],
	[107,   4, 24, 28],
	[40,   4, 28, 28],
	[41,   1, 30, 30],
	[49,   1, 31, 31],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(816, 272):
		Global.game.play_dialogue("MAP150_NPC_1")
	if check_pos == Vector2(816, 304):
		Global.game.play_dialogue("MAP150_NPC_2")
	if check_pos == Vector2(752, 240):
		Global.game.play_dialogue("MAP150_NPC_3")
	if check_pos == Vector2(784, 240):
		Global.game.play_dialogue("MAP150_NPC_4")
	if check_pos == Vector2(784, 272):
		Global.game.play_dialogue("MAP150_NPC_5")
	if check_pos == Vector2(784, 304):
		Global.game.play_dialogue("MAP150_NPC_6")
	if check_pos == Vector2(752, 304):
		Global.game.play_dialogue("MAP150_NPC_7")
	if check_pos == Vector2(752, 272):
		Global.game.play_dialogue("MAP150_NPC_8")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(59, 1)
		Global.game.recive_item(59)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(2, 1)
		Global.game.recive_item(2)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(172, 1)
		Global.game.recive_item(172)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(200, 1)
		Global.game.recive_item(200)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item5") != null and check_pos == $NPC_Layer/Item5.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_5_TAKEN")
		Global.inventory.add_item_by_id_multiple(16, 1)
		Global.game.recive_item(16)
		$NPC_Layer/Item5.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item6") != null and check_pos == $NPC_Layer/Item6.position:
		Global.game.lock_player()
		Global.past_events.append("MAP150_ITEM_6_TAKEN")
		Global.inventory.add_item_by_id_multiple(521, 1)
		Global.game.recive_item(521)
		$NPC_Layer/Item6.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP150_TRAINER_1", "defeat": "MAP150_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer012.png"},
	"Trainer2": {"pre": "MAP150_TRAINER_2", "defeat": "MAP150_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer020.png"},
	"Trainer3": {"pre": "MAP150_TRAINER_3", "defeat": "MAP150_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer012.png"},
	"Trainer4": {"pre": "MAP150_TRAINER_4", "defeat": "MAP150_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP150_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP150_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP150_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
