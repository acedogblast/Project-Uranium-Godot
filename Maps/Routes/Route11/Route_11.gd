extends Node2D # gen_map.py Map018

var map_name = "Route 11"

var wild_table = [
	[44,  20, 20, 25],
	[46,  20, 20, 25],
	[75,  15, 25, 27],
	[44,  10, 25, 27],
	[46,  10, 25, 27],
	[60,  10, 20, 22],
	[61,   5, 25, 25],
	[47,   4, 25, 27],
	[94,   4, 25, 27],
	[61,   1, 27, 27],
	[47,   1, 28, 28],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1040, 2608):
		Global.game.play_dialogue("MAP018_NPC_1")
	if check_pos == Vector2(1072, 2608):
		Global.game.play_dialogue("MAP018_NPC_2")
	if check_pos == Vector2(1104, 2544):
		Global.game.play_dialogue("MAP018_NPC_3")
	if check_pos == Vector2(1040, 2288):
		Global.game.play_dialogue("MAP018_NPC_4")
	if check_pos == Vector2(1104, 2352):
		Global.game.play_dialogue("MAP018_NPC_5")
	if check_pos == Vector2(1008, 2416):
		Global.game.play_dialogue("MAP018_NPC_6")
	if check_pos == Vector2(976, 2352):
		Global.game.play_dialogue("MAP018_NPC_7")
	if check_pos == Vector2(1136, 2448):
		Global.game.play_dialogue("MAP018_NPC_8")
	if check_pos == Vector2(1456, 1584):
		Global.game.play_dialogue("MAP018_NPC_9")
	if check_pos == Vector2(1008, 2544):
		_nurse_heal($NPC_Layer/Nurse1)
	if get_node_or_null("NPC_Layer/Item1") != null and check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("MAP018_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(293, 1)
		Global.game.recive_item(293)
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
