extends Node2D

var background_music = "res://Audio/BGM/PU-Radio_ Oak.ogg";
var type = "Indoors"
var place_name = "Bambo's Lab"
var npc_layer
var theo
var bambo
var ui = null
var starter

signal finished

func _ready():
	bambo = $NPC_Layer/Bambo
	$BlackBG.visible = true
	npc_layer = $NPC_Layer
	event1(null) # Play event on enter.
	pass
func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	return null
func event1(_body): # First event to get pokemon
	var event_name = "EVENT_BAMBOLAB_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.game.player.change_input()
		# Spawn Theo
		theo = load("res://Utilities/NPC.tscn").instance()
		theo.texture = load("res://Graphics/Characters/Rivaltheo.PNG")
		npc_layer.add_child(theo)
		theo.position = Vector2(208, 208)
		theo.set_idle_frame("Up")

		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 10) # This somehow just runs instantly and I can't debug this!
		yield(Global.game.player, "done_movement")


		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_1", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_2", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_3", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_4", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_5", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_6", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		# Theo Alert
		theo.alert()
		yield(theo, "alert_done")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_7", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_8", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_9", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_10", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_11", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_12", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_13", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		DialogueSystem.hold = true
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_14", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		
		yield(DialogueSystem, "finished_printing")
		DialogueSystem.hold = false

		# Add FirstPokeLayer UI
		ui = load("res://Maps/MokiTown/FirstPokeLayer.tscn").instance()
		self.add_child(ui)

		# Show Yes/No box
		ui.prompt_yes_no()
		yield(ui, "selected")
		var responce = ui.get_yes_no_responce()
		#print(responce)
		
		if responce == true:
			Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_15", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			event1_test()
			yield(self, "finished")
			event1_pick_up()
		else:
			Global.past_events.append("EVENT_BAMBOLAB_1_INTRO")
			Global.game.player.change_input()

func event1_pick_up():
	# Play open
	$PokeMachine/AnimationPlayer.play("Open")
	yield($PokeMachine/AnimationPlayer, "animation_finished")

	bambo.call_deferred("move_multi", "Right", 1)
	yield(bambo, "done_movement")
	bambo.call_deferred("set_idle_frame", "Left")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_38", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.player.change_input()
	emit_signal("finished")

func event1_test():
	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_16", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q1)
	yield(ui, "selected")
	var responce1 : int = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED


	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_17", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_18", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_19", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_20", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q2)
	yield(ui, "selected")
	var responce2 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_21", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_22", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_23", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q3)
	yield(ui, "selected")
	var responce3 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_24", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_25", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_26", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q4)
	yield(ui, "selected")
	var responce4 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_27", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_28", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_29", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_30", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_31", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	# Score test
	var attack = 0
	var defense = 0
	var ballanced = 0
	match responce1:
		0:
			attack += 1
		1:
			defense += 1
		2:
			ballanced += 1
	match responce2:
		0:
			attack += 1
		1:
			defense += 1
		2:
			ballanced += 1
	match responce3:
		0:
			attack += 1
		1:
			defense += 1
		2:
			ballanced += 1
	match responce4:
		0:
			attack += 1
		1:
			defense += 1
		2:
			ballanced += 1
	
	var result = -1 # 0 = Raptorch, 1 = Orchynx, 2 = Electux

	if attack > defense && attack > ballanced:
		result = 0
	if defense > attack && defense > ballanced:
		result = 1
	if ballanced > attack && ballanced > defense:
		result = 2

	if result == -1: # Check for ties
		if defense >= attack || defense >= ballanced:
			result = 1
		else:
			result = 0
	
	print(result)
	# Change to poke pick view
	ui.Poke_get()
	yield(ui, "selected")
	
	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_32")
	yield(Global.game, "event_dialogue_end")

	match result:
		0: # Raptorch
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_33_Raptorch")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_34_Raptorch")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_35_Raptorch")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_36_Raptorch")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_37_Raptorch")
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.hold = true
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OPTION_15")
		1:
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_33_Orchynx")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_34_Orchynx")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_35_Orchynx")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_36_Orchynx")
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.hold = true
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OPTION_15_1")
		2:
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_33_Electux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_34_Electux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_35_Electux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_36_Electux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_37_Electux")
			yield(Global.game, "event_dialogue_end")

			DialogueSystem.hold = true
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OPTION_15_2")
	# Fade and slide
	ui.Poke_get_slide(result)
	yield(ui, "selected")
	DialogueSystem.hold = false
	starter = result

	ui.fadeout()
	yield(ui, "selected")
	emit_signal("finished")
