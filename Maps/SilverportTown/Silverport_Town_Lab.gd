extends Node2D # gen_map.py Map075

var map_name = "Silverport Town(Lab)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(848, 688):
		Global.game.play_dialogue("MAP075_SIGN_1")
	if check_pos == Vector2(816, 784):
		Global.game.play_dialogue("MAP075_SIGN_2")
	if check_pos == Vector2(1008, 656):
		Global.game.play_dialogue("MAP075_SIGN_3")
	if check_pos == Vector2(208, 240):
		Global.game.play_dialogue("MAP075_NPC_1")
	if check_pos == Vector2(400, 144):
		Global.game.play_dialogue("MAP075_NPC_2")
	if check_pos == Vector2(48, 176):
		Global.game.play_dialogue("MAP075_NPC_3")
	if check_pos == Vector2(336, 272):
		Global.game.play_dialogue("MAP075_NPC_4")
	if check_pos == Vector2(48, 304):
		Global.game.play_dialogue("MAP075_NPC_5")
	if check_pos == Vector2(752, 176):
		Global.game.play_dialogue("MAP075_NPC_6")
	if check_pos == Vector2(528, 1424):
		Global.game.play_dialogue("MAP075_NPC_7")
	if check_pos == Vector2(560, 1424):
		Global.game.play_dialogue("MAP075_NPC_8")
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP075_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(525, 1)
		Global.game.recive_item(525)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP075_TRAINER_1", "defeat": "MAP075_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"},
	"Trainer2": {"pre": "MAP075_TRAINER_2", "defeat": "MAP075_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer090.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP075_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP075_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP075_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
