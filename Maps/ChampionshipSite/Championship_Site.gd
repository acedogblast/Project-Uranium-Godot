extends Node2D # gen_map.py Map181

var map_name = "Championship Site"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(944, 784):
		Global.game.play_dialogue("MAP181_NPC_1")
	if check_pos == Vector2(976, 432):
		Global.game.play_dialogue("MAP181_NPC_2")
	if check_pos == Vector2(656, 816):
		Global.game.play_dialogue("MAP181_NPC_3")
	if check_pos == Vector2(400, 688):
		Global.game.play_dialogue("MAP181_NPC_4")
	if check_pos == Vector2(592, 368):
		Global.game.play_dialogue("MAP181_NPC_5")
	if check_pos == Vector2(1200, 848):
		Global.game.play_dialogue("MAP181_NPC_6")
	if check_pos == Vector2(1232, 400):
		Global.game.play_dialogue("MAP181_NPC_7")
	if check_pos == Vector2(880, 688):
		Global.game.play_dialogue("MAP181_NPC_8")
	if check_pos == Vector2(464, 848):
		Global.game.play_dialogue("MAP181_NPC_9")
	if check_pos == Vector2(464, 816):
		Global.game.play_dialogue("MAP181_NPC_10")
	if check_pos == Vector2(560, 656):
		_nurse_heal($NPC_Layer/Nurse1)
	if check_pos == Vector2(1040, 656):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'ULTRABALL', 'HEALBALL', 'NESTBALL', 'DUSKBALL', 'QUICKBALL', 'TIMERBALL', 'REPEATBALL', 'NETBALL', 'LUXURYBALL'])
	if check_pos == Vector2(1008, 656):
		Global.game.open_shop(['POTION', 'SUPERPOTION', 'HYPERPOTION', 'MAXPOTION', 'FULLRESTORE', 'REVIVE', 'ANTIDOTE', 'PARLYZHEAL', 'AWAKENING', 'BURNHEAL', 'ICEHEAL', 'FULLHEAL', 'REPEL', 'SUPERREPEL', 'MAXREPEL', 'ESCAPEROPE'])
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
