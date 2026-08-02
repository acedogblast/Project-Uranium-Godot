extends Node2D # gen_map.py Map097

var map_name = "Venesi City"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1008, 1264):
		Global.game.play_dialogue("MAP097_NPC_1")
	if check_pos == Vector2(80, 240):
		Global.game.play_dialogue("MAP097_NPC_2")
	if check_pos == Vector2(272, 336):
		Global.game.play_dialogue("MAP097_NPC_3")
	if check_pos == Vector2(368, 272):
		Global.game.play_dialogue("MAP097_NPC_4")
	if check_pos == Vector2(1008, 272):
		Global.game.play_dialogue("MAP097_NPC_5")
	if check_pos == Vector2(912, 336):
		Global.game.play_dialogue("MAP097_NPC_6")
	if check_pos == Vector2(1136, 304):
		Global.game.play_dialogue("MAP097_NPC_7")
	if check_pos == Vector2(80, 784):
		Global.game.play_dialogue("MAP097_NPC_8")
	if check_pos == Vector2(336, 784):
		Global.game.play_dialogue("MAP097_NPC_9")
	if check_pos == Vector2(976, 848):
		Global.game.play_dialogue("MAP097_NPC_10")
	if check_pos == Vector2(1072, 720):
		Global.game.play_dialogue("MAP097_NPC_11")
	if check_pos == Vector2(80, 1296):
		Global.game.play_dialogue("MAP097_NPC_12")
	if check_pos == Vector2(304, 1392):
		Global.game.play_dialogue("MAP097_NPC_13")
	if check_pos == Vector2(368, 1328):
		Global.game.play_dialogue("MAP097_NPC_14")
	if check_pos == Vector2(176, 1904):
		Global.game.play_dialogue("MAP097_NPC_15")
	if check_pos == Vector2(880, 1840):
		Global.game.play_dialogue("MAP097_NPC_16")
	if check_pos == Vector2(1008, 1840):
		Global.game.play_dialogue("MAP097_NPC_17")
	if check_pos == Vector2(336, 2480):
		Global.game.play_dialogue("MAP097_NPC_18")
	if check_pos == Vector2(80, 2416):
		Global.game.play_dialogue("MAP097_NPC_19")
	if check_pos == Vector2(944, 2480):
		Global.game.play_dialogue("MAP097_NPC_20")
	if check_pos == Vector2(1744, 1328):
		Global.game.play_dialogue("MAP097_NPC_21")
	if check_pos == Vector2(1616, 1328):
		Global.game.play_dialogue("MAP097_NPC_22")
	if check_pos == Vector2(1488, 2512):
		Global.game.play_dialogue("MAP097_NPC_23")
	if check_pos == Vector2(1712, 2576):
		Global.game.play_dialogue("MAP097_NPC_24")
	if check_pos == Vector2(1680, 1968):
		Global.game.play_dialogue("MAP097_NPC_25")
	if check_pos == Vector2(912, 1840):
		Global.game.play_dialogue("MAP097_NPC_26")
	if check_pos == Vector2(944, 1904):
		Global.game.play_dialogue("MAP097_NPC_27")
	if check_pos == Vector2(1808, 1328):
		Global.game.open_shop(['CARROTWINE'])
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP097_TRAINER_1", "defeat": "MAP097_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer046.png"},
	"Trainer2": {"pre": "MAP097_TRAINER_2", "defeat": "MAP097_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer046.png"},
	"Trainer3": {"pre": "MAP097_TRAINER_3", "defeat": "MAP097_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer005.png"},
	"Trainer4": {"pre": "MAP097_TRAINER_4", "defeat": "MAP097_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer013.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP097_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP097_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP097_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()
