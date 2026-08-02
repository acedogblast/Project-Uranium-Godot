extends Node2D # gen_map.py Map213

var map_name = "Dream Route 13"

var wild_table = [
	[46,  20, 25, 27],
	[14,  20, 30, 40],
	[128,  10, 30, 35],
	[31,  10, 30, 35],
	[106,  10, 35, 37],
	[32,  10, 30, 32],
	[35,   5, 25, 30],
	[57,   5, 25, 27],
	[61,   4, 27, 27],
	[133,   4, 33, 33],
	[142,   1, 46, 46],
	[125,   1, 25, 30],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(2416, 1424):
		Global.game.play_dialogue("MAP213_SIGN_1")
	if check_pos == Vector2(2512, 1456):
		Global.game.play_dialogue("MAP213_SIGN_2")
	if check_pos == Vector2(2768, 1520):
		Global.game.play_dialogue("MAP213_SIGN_3")
	if check_pos == Vector2(400, 1712):
		Global.game.play_dialogue("MAP213_NPC_1")
	if check_pos == Vector2(2608, 1456):
		Global.game.play_dialogue("MAP213_NPC_2")
	if check_pos == Vector2(2896, 2064):
		Global.game.play_dialogue("MAP213_NPC_3")
	if check_pos == Vector2(400, 624):
		Global.game.play_dialogue("MAP213_NPC_4")
	if check_pos == Vector2(1232, 1712):
		Global.game.play_dialogue("MAP213_NPC_5")
	if check_pos == Vector2(272, 1840):
		Global.game.play_dialogue("MAP213_NPC_6")
	if check_pos == Vector2(3024, 1520):
		Global.game.play_dialogue("MAP213_NPC_7")
	if check_pos == Vector2(2768, 1904):
		Global.game.play_dialogue("MAP213_NPC_8")
	if check_pos == Vector2(2832, 1936):
		Global.game.play_dialogue("MAP213_NPC_9")
	if check_pos == Vector2(368, 720):
		_nurse_heal($NPC_Layer/Nurse1)
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
	Global.game.last_heal_point = "res://Maps/DreamWorld/Dream_World.tscn"
	Global.game.release_player()
