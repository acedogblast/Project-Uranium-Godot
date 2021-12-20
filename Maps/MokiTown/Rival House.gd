extends Node2D

var place_name = "Theo's House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

var npc_layer

var theo
var cameron

func _ready():
	npc_layer = $NPC_Layer
	$BG.show()
	yield(Global.game, "tranistion_complete")
	event1() # Play event on enter.
	pass

func interaction(check_pos, direction): # check_pos is a Vector2 of the position of object to interact
	if cameron != null && check_pos == cameron.position:
		Global.game.lock_player()

		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_23", cameron.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.release_player()


func event1():
	var event_name = "EVENT_MOKI_TOWN_THEO_HOME_1"
	if !Global.past_events.has(event_name) && Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE"):
		print("New Event: " + event_name)
		Global.game.lock_player()

		# Spawn NPCs
		theo = load("res://Utilities/NPC.tscn").instance()
		cameron = load("res://Utilities/NPC.tscn").instance()
		theo.texture = load("res://Graphics/Characters/Rivaltheo.PNG")
		npc_layer.add_child(theo)
		cameron.texture = load("res://Graphics/Characters/PU-Cam.png")
		npc_layer.add_child(cameron)
		#theo.position = Vector2(208, 208)
		#theo.set_idle_frame("Up")

		# Check if player won or lost the battle with theo in the lab
		if Global.past_events.has("EVENT_BAMBOLAB_1_WIN"):
			theo.position = Vector2(272, 240)
			theo.set_idle_frame("Left")
			cameron.position = Vector2(240, 240)
			cameron.set_idle_frame("Right")

			yield(get_tree().create_timer(1.0), "timeout")

			theo.set_idle_frame("Down")
			theo.alert()
			yield(theo, "alert_done")

			theo.call_deferred("move_multi", "Up", 3)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Right", 1)
			yield(theo, "done_movement")
			theo.hide() # Should go upstairs but hiding will work for now

			Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 3)
			yield(Global.game.player, "done_movement")
			Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.LEFT)

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_1", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_2", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_3", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_4", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_5", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_6", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			cameron.call_deferred("move_multi", "Up", 1)
			Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.UP)
			yield(cameron, "done_movement")

			cameron.call_deferred("move_multi", "Right", 1)
			yield(cameron, "done_movement")
			cameron.set_idle_frame("Up")

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_7", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			yield(get_tree().create_timer(1.0), "timeout")

			theo.show()
			theo.set_idle_frame("Left")
			yield(get_tree().create_timer(0.5), "timeout")

			theo.call_deferred("move_multi", "Down", 1)
			yield(theo, "done_movement")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_8", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_9", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_10", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_11", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_12", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_13", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			cameron.set_idle_frame("Down")

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_14", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_HOME_15")
			yield(Global.game, "event_dialogue_end")

			theo.call_deferred("move_multi", "Down", 2)
			yield(theo, "done_movement")
			theo.set_idle_frame("Up")

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_16", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_17", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_HOME_18")

			var time = Global.game.get_node("Background_music").get_playback_position()
			Global.game.get_node("Background_music").stop()
			var sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
			sound.loop = false
			Global.game.get_node("Effect_music").stream = sound
			Global.game.get_node("Effect_music").play()
			yield(Global.game.get_node("Effect_music"), "finished")
			Global.game.get_node("Background_music").play(time)

			# TODO: Enable PokePod

			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_19", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_20", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_21", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			theo.call_deferred("move_multi", "Down", 2)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Left", 1)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Down", 1)
			yield(theo, "done_movement")
			theo.hide()
			theo.queue_free()

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_22", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			pass
		if Global.past_events.has("EVENT_BAMBOLAB_1_LOSS"):
			theo.position = Vector2(336, 112)
			theo.set_idle_frame("Left")
			theo.hide()
			cameron.position = Vector2(240, 240)
			cameron.set_idle_frame("Right")

			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_HOME_25")
			yield(Global.game, "event_dialogue_end")

			Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 3)
			yield(Global.game.player, "done_movement")
			Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.LEFT)

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_26", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.hold = true
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_27", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game.dialogue_system, "finished_printing")

			# Show yesno prompt
			var yesno = load("res://Utilities/UI/YesNoPrompt.tscn").instance()
			yesno.set_screen_position(Vector2(350, 150))
			self.add_child(yesno)

			yield(yesno, "selected")
			DialogueSystem.hold = false

			if yesno.selection == yesno.YES:
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_28", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_29", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_30", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")

			else:
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_33", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_34", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
				Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_35", cameron.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")

			cameron.set_idle_frame("Up")
			Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.UP)

			theo.show()
			theo.call_deferred("move_multi", "Left", 1)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Down", 2)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Left", 1)
			yield(theo, "done_movement")
			
			theo.set_idle_frame("Down")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_31", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			DialogueSystem.set_box_position(DialogueSystem.TOP)
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_32", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
			Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_HOME_15")
			yield(Global.game, "event_dialogue_end")

			cameron.set_idle_frame("Right")
			Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.LEFT)
			theo.call_deferred("move_multi", "Down", 1)
			yield(theo, "done_movement")
			theo.set_idle_frame("Left")

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_16", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_17", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_HOME_18")

			var time = Global.game.get_node("Background_music").get_playback_position()
			Global.game.get_node("Background_music").stop()
			var sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
			sound.loop = false
			Global.game.get_node("Effect_music").stream = sound
			Global.game.get_node("Effect_music").play()
			yield(Global.game.get_node("Effect_music"), "finished")
			Global.game.get_node("Background_music").play(time)

			# TODO: Enable PokePod

			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_19", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_20", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_21", theo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			theo.call_deferred("move_multi", "Right", 1)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Down", 3)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Left", 1)
			yield(theo, "done_movement")
			theo.call_deferred("move_multi", "Down", 1)
			yield(theo, "done_movement")
			theo.hide()
			theo.queue_free()

		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_23", cameron.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_HOME_24", cameron.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

			
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.release_player()
		Global.past_events.append(event_name)
