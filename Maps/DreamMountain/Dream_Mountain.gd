extends Node2D # gen_map.py Map084

var map_name = "Dream Mountain"

var wild_table = [
	[9,  20, 30, 32],
	[9,  20, 25, 30],
	[17,  10, 35, 35],
	[128,  10, 30, 35],
	[106,  10, 20, 25],
	[31,  10, 35, 35],
	[147,  10, 20, 20],
	[99,   4, 35, 35],
	[50,   4, 20, 20],
	[56,   1, 30, 40],
	[142,   1, 46, 46],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1040, 2032):
		Global.game.play_dialogue("MAP084_SIGN_1")
	if check_pos == Vector2(1040, 2096):
		Global.game.play_dialogue("MAP084_SIGN_2")
	if check_pos == Vector2(1008, 2064):
		Global.game.play_dialogue("MAP084_SIGN_3")
	if check_pos == Vector2(976, 1904):
		Global.game.play_dialogue("MAP084_SIGN_4")
	if check_pos == Vector2(944, 1904):
		Global.game.play_dialogue("MAP084_SIGN_5")
	if check_pos == Vector2(1520, 912):
		Global.game.play_dialogue("MAP084_SIGN_6")
	if check_pos == Vector2(1456, 1616):
		Global.game.play_dialogue("MAP084_NPC_1")
	if check_pos == Vector2(720, 592):
		Global.game.play_dialogue("MAP084_NPC_2")
	if check_pos == Vector2(1456, 1872):
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
