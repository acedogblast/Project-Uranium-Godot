extends Node2D

var npc_nurse
var prompt
var left
var right
var timer

func _ready():
	npc_nurse = $NPC_Nurse
	left = $Balls/Left
	right = $Balls/Right
	left.hide()
	right.hide()
	$BG.show()
	$FrontDesk.add_to_group("auto_z_layering")
	timer = Timer.new()
	timer.wait_time = 0.25
	timer.one_shot = false
	add_child(timer)

func heal():
	Global.game.lock_player()
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_1" , npc_nurse.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_2" , npc_nurse.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_3" , npc_nurse.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false

	# Yes/No prompt
	prompt = load("res://Utilities/UI/YesNoPrompt.tscn").instance()
	prompt.set_screen_position(Vector2(408,175))
	add_child(prompt)

	yield(prompt, "selected")

	if prompt.selection == 0: # Yes
		Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_4" , npc_nurse.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		left.hide()
		right.hide()
		var party_size = Global.pokemon_group.size()
		Global.heal_party()
		var left_frame = 4
		var right_frame = 4
		match party_size:
			1:
				left.show()
				left.frame = 4
				left_frame = 4
			2:
				left.show()
				right.show()
				left.frame = 4
				right.frame = 4
				left_frame = 4
				right_frame = 4
			3:
				left.show()
				right.show()
				left.frame = 8
				right.frame = 4
				left_frame = 8
				right_frame = 4
			4:
				left.show()
				right.show()
				left.frame = 8
				right.frame = 8
				left_frame = 8
				right_frame = 8
			5:
				left.show()
				right.show()
				left.frame = 12
				right.frame = 8
				left_frame = 12
				right_frame = 8
			6,_:
				left.show()
				right.show()
				left.frame = 12
				right.frame = 12
				left_frame = 12
				right_frame = 12
		npc_nurse.set_idle_frame("Left")

		# Play ME
		var time = Global.game.get_node("Background_music").get_playback_position()
		Global.game.get_node("Background_music").stop()
		var sound = load("res://Audio/ME/Pokemon Healing.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()

		# Play flashing balls
		timer.start()
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame - 3
		right_frame = right_frame - 3
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame + 1
		right_frame = right_frame + 1
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		left_frame = left_frame - 3
		right_frame = right_frame - 3
		left.frame = left_frame
		right.frame = right_frame
		yield(timer, "timeout")
		timer.stop()

		Global.game.get_node("Effect_music").stop()
		Global.game.get_node("Background_music").play(time)
		left.hide()
		right.hide()

		npc_nurse.set_idle_frame("Down")
		Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_5" , npc_nurse.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_6" , npc_nurse.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
	
	prompt.queue_free()
	Global.game.play_dialogue_with_point("NPC_POKECENTER_NURSE_7" , npc_nurse.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.release_player()
