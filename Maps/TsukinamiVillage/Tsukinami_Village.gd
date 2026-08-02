extends Node2D # gen_map.py Map146

var map_name = "Tsukinami Village"
var map_px_size = Vector2(2560, 2560)
var edge_connections = [["W", "res://Maps/Routes/Route14/Route_14.tscn", 1152, 1200, 3520]]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(784, 528):
		Global.game.play_dialogue("MAP146_SIGN_1")
	if check_pos == Vector2(752, 528):
		Global.game.play_dialogue("MAP146_SIGN_2")
	if check_pos == Vector2(1136, 1424):
		Global.game.play_dialogue("MAP146_SIGN_3")
	if check_pos == Vector2(1040, 1424):
		Global.game.play_dialogue("MAP146_SIGN_4")
	if check_pos == Vector2(1232, 1296):
		Global.game.play_dialogue("MAP146_SIGN_5")
	if check_pos == Vector2(1008, 1424):
		Global.game.play_dialogue("MAP146_SIGN_6")
	if check_pos == Vector2(1360, 1296):
		Global.game.play_dialogue("MAP146_SIGN_7")
	if check_pos == Vector2(1488, 1104):
		Global.game.play_dialogue("MAP146_SIGN_8")
	if check_pos == Vector2(1264, 1488):
		Global.game.play_dialogue("MAP146_NPC_1")
	if check_pos == Vector2(1424, 1552):
		Global.game.play_dialogue("MAP146_NPC_2")
	if check_pos == Vector2(1872, 2096):
		Global.game.play_dialogue("MAP146_NPC_3")
	if check_pos == Vector2(848, 1328):
		Global.game.play_dialogue("MAP146_NPC_4")
	if check_pos == Vector2(1680, 1872):
		Global.game.play_dialogue("MAP146_NPC_5")
	if check_pos == Vector2(1072, 1168):
		Global.game.play_dialogue("MAP146_NPC_6")
	if check_pos == Vector2(944, 752):
		Global.game.play_dialogue("MAP146_NPC_7")
	if check_pos == Vector2(2000, 1456):
		Global.game.play_dialogue("MAP146_NPC_8")
	if check_pos == Vector2(1200, 1328):
		Global.game.play_dialogue("MAP146_NPC_9")
	if check_pos == Vector2(1328, 1104):
		_nurse_heal($NPC_Layer/Nurse1)
	if check_pos == Vector2(1584, 1296):
		Global.game.open_shop(['COCONUTMILK', 'CARROTWINE', 'LAVACOOKIE'])
	if check_pos == Vector2(1232, 1104):
		Global.game.open_shop(['LOVEBALL', 'LUREBALL', 'HEAVYBALL', 'MOONBALL', 'FASTBALL', 'LEVELBALL', 'FRIENDBALL'])
	if check_pos == Vector2(1584, 1104):
		Global.game.open_shop(['CHOICEBAND', 'CHOICESCARF', 'CHOICESPECS', 'FOCUSSASH', 'FOCUSBAND', 'EXPERTBELT', 'LIFEORB', 'FLAMEORB', 'TOXICORB', 'SCOPELENS', 'WIDELENS', 'ZOOMLENS'])
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP146_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(589, 1)
		Global.game.recive_item(589)
		$NPC_Layer/Item1.queue_free()
		await Global.game.end_of_event
		Global.game.release_player()
	return null

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
