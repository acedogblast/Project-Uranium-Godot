extends Node2D # gen_map.py Map087

var map_name = "Route 12"
var map_px_size = Vector2(4992, 1344)
var edge_connections = [["W", "res://Maps/Routes/Route5/Route_5.tscn", -224, 3376, 1440]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(4016, 688):
		Global.game.play_dialogue("MAP087_SIGN_1")
	if check_pos == Vector2(1840, 432):
		Global.game.play_dialogue("MAP087_SIGN_2")
	if check_pos == Vector2(4016, 400):
		_nurse_heal($NPC_Layer/Nurse1)
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP087_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(266, 1)
		Global.game.recive_item(266)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item2") != null and check_pos == $NPC_Layer/Item2.position:
		Global.game.lock_player()
		Global.past_events.append("MAP087_ITEM_2_TAKEN")
		Global.inventory.add_item_by_id_multiple(72, 1)
		Global.game.recive_item(72)
		$NPC_Layer/Item2.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item3") != null and check_pos == $NPC_Layer/Item3.position:
		Global.game.lock_player()
		Global.past_events.append("MAP087_ITEM_3_TAKEN")
		Global.inventory.add_item_by_id_multiple(35, 1)
		Global.game.recive_item(35)
		$NPC_Layer/Item3.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	if get_node_or_null("NPC_Layer/Item4") != null and check_pos == $NPC_Layer/Item4.position:
		Global.game.lock_player()
		Global.past_events.append("MAP087_ITEM_4_TAKEN")
		Global.inventory.add_item_by_id_multiple(289, 1)
		Global.game.recive_item(289)
		$NPC_Layer/Item4.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

var _trainer_data = {
	"Trainer1": {"pre": "MAP087_TRAINER_1", "defeat": "MAP087_TRAINER_1_DEFEAT", "portrait": "Graphics/Characters/trainer011.png"},
	"Trainer2": {"pre": "MAP087_TRAINER_2", "defeat": "MAP087_TRAINER_2_DEFEAT", "portrait": "Graphics/Characters/trainer035.png"},
	"Trainer3": {"pre": "MAP087_TRAINER_3", "defeat": "MAP087_TRAINER_3_DEFEAT", "portrait": "Graphics/Characters/trainer011.png"},
	"Trainer4": {"pre": "MAP087_TRAINER_4", "defeat": "MAP087_TRAINER_4_DEFEAT", "portrait": "Graphics/Characters/trainer035.png"},
	"Trainer5": {"pre": "MAP087_TRAINER_5", "defeat": "MAP087_TRAINER_5_DEFEAT", "portrait": "Graphics/Characters/trainer006.png"},
	"Trainer6": {"pre": "MAP087_TRAINER_6", "defeat": "MAP087_TRAINER_6_DEFEAT", "portrait": "Graphics/Characters/trainer035.png"},
	"Trainer7": {"pre": "MAP087_TRAINER_7", "defeat": "MAP087_TRAINER_7_DEFEAT", "portrait": "Graphics/Characters/trainer098.png"},
	"Trainer8": {"pre": "MAP087_TRAINER_8", "defeat": "MAP087_TRAINER_8_DEFEAT", "portrait": "Graphics/Characters/trainer097.png"}
}

func _ready():
	Global.game.player.connect("trainer_battle", Callable(self, "trainer_battle"))
	for c in $NPC_Layer.get_children():
		if String(c.name).begins_with("Item") and Global.past_events.has("MAP087_ITEM_" + String(c.name).trim_prefix("Item") + "_TAKEN"):
			c.queue_free()
		elif String(c.name).begins_with("Trainer") and Global.past_events.has("MAP087_" + String(c.name).to_upper() + "_DEFEATED"):
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
		Global.past_events.append("MAP087_" + String(npc_trainer.name).to_upper() + "_DEFEATED")
	Global.game.release_player()

func _nurse_heal(npc):
	Global.game.lock_player()
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	var pt = npc.get_global_transform_with_canvas().get_origin()
	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_1", pt)
	await Global.game.event_dialogue_end
	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_2", pt)
	await Global.game.event_dialogue_end
	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_3", pt)
	await DialogueSystem.finished_printing
	DialogueSystem.hold = false
	var prompt = load("res://Utilities/UI/YesNoPrompt.tscn").instantiate()
	prompt.set_screen_position(Vector2(408, 175))
	add_child(prompt)
	await prompt.selected
	var accepted = prompt.selection == 0
	prompt.queue_free()
	if accepted:
		Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_4", pt)
		await Global.game.event_dialogue_end
		Global.heal_party()
		Global.game.last_heal_point = Global.game.current_scene.scene_file_path
		var bgm = Global.game.get_node("Background_music")
		var at = bgm.get_playback_position()
		bgm.stop()
		var jingle = load("res://Audio/ME/Pokemon_Healing.ogg")
		jingle.loop = false
		Global.game.get_node("Effect_music").stream = jingle
		Global.game.get_node("Effect_music").play()
		await Global.game.get_node("Effect_music").finished
		bgm.play(at)
		Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_5", pt)
		await Global.game.event_dialogue_end
	Global.game.last_heal_point = "res://Maps/GAME/GAME.tscn"
	Global.game.release_player()
