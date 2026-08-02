extends Node2D # gen_map.py Map112

var map_name = "Nuclear Plant Omicron(2)"

var wild_table = [
	[145,  20, 40, 45],
	[65,  20, 40, 45],
	[168,  20, 43, 46],
	[166,  14, 38, 42],
	[47,  10, 43, 46],
	[36,  10, 44, 46],
	[66,   4, 44, 45],
	[66,   2, 47, 47],
]

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1232, 1968):
		Global.game.play_dialogue("MAP112_NPC_1")
	if check_pos == Vector2(1232, 1008):
		Global.game.play_dialogue("MAP112_NPC_2")
	if check_pos == Vector2(1264, 1008):
		Global.game.play_dialogue("MAP112_NPC_3")
	if check_pos == Vector2(1328, 1520):
		Global.game.play_dialogue("MAP112_NPC_4")
	if check_pos == Vector2(1328, 1552):
		Global.game.play_dialogue("MAP112_NPC_5")
	if check_pos == Vector2(880, 912):
		Global.game.play_dialogue("MAP112_NPC_6")
	if check_pos == Vector2(912, 912):
		Global.game.play_dialogue("MAP112_NPC_7")
	if check_pos == Vector2(368, 1232):
		Global.game.play_dialogue("MAP112_NPC_8")
	if check_pos == Vector2(432, 1232):
		Global.game.play_dialogue("MAP112_NPC_9")
	if check_pos == Vector2(1808, 1072):
		Global.game.play_dialogue("MAP112_NPC_10")
	if check_pos == Vector2(1872, 1072):
		Global.game.play_dialogue("MAP112_NPC_11")
	if check_pos == Vector2(1808, 1104):
		Global.game.play_dialogue("MAP112_NPC_12")
	if check_pos == Vector2(1872, 1104):
		Global.game.play_dialogue("MAP112_NPC_13")
	if check_pos == Vector2(1008, 1872):
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
	Global.game.last_heal_point = "res://Maps/GAME/GAME.tscn"
	Global.game.release_player()
