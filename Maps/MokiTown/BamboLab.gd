extends Node2D

var background_music = "res://Audio/BGM/PU-Lab.ogg";
var type = "Indoors"
var place_name = "Bambo's Lab"
var npc_layer
var theo
var bambo
var ui = null
var starter
var grass_pos = []


signal finished

func _ready():
	$BlackBG.visible = true
	npc_layer = $NPC_Layer
	if !Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE"):
		event1_prep()
	yield(Global.game, "tranistion_complete")
	event1_intro(null) # Play event on enter.

	if Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE"):
		$PokeMachine.frame = 4


func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == $Event_Layer/PokeMachine.position:
		event1_poke_machine()
	if check_pos == $NPC_Layer/Assistant.position:
		Global.game.lock_player()
		#Turn to face player
		$NPC_Layer/Assistant.face_player(direction)

		DialogueSystem.set_box_position(DialogueSystem.TOP)
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_1", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_2", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_3", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_4", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_5", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_AIDE_6", $NPC_Layer/Assistant.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		$NPC_Layer/Assistant.set_idle_frame("Up")
		Global.game.release_player()
		return null
	if bambo != null && check_pos == bambo.position:
		Global.game.lock_player()
		#Turn to face player
		bambo.face_player(direction)

		if Global.past_events.has("EVENT_BAMBOLAB_1_INTRO") && !Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && !Global.past_events.has("EVENT_BAMBOLAB_1_PICK_UP_ENABLE"):
			event1_choice()
			return null

		if !Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && Global.past_events.has("EVENT_BAMBOLAB_1_PICK_UP_ENABLE"):
			Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_38", bambo.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
			return null
	if theo != null && check_pos == theo.position:
		Global.game.lock_player()
		#Turn to face player
		theo.face_player(direction)
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_38_THEO", theo.get_dialogue_point())
		yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
		return null
	
	return null
func event1_prep():
	# Spawn Babmo
	bambo = load("res://Utilities/NPC.tscn").instance()
	bambo.texture = load("res://Graphics/Characters/phone035.PNG")
	npc_layer.add_child(bambo)
	bambo.position = Vector2(240, 144)
	bambo.set_idle_frame("Down")

	# Spawn Theo
	theo = load("res://Utilities/NPC.tscn").instance()
	theo.texture = load("res://Graphics/Characters/Rivaltheo.PNG")
	npc_layer.add_child(theo)
	theo.position = Vector2(208, 208)
	theo.set_idle_frame("Up")

	if Global.past_events.has("EVENT_BAMBOLAB_1_PICK_UP_ENABLE"):
		ui = load("res://Maps/MokiTown/FirstPokeLayer.tscn").instance()
		self.add_child(ui)
		$PokeMachine.frame = 2
		bambo.position = Vector2(272, 144)
		bambo.set_idle_frame("Left")

		if Global.past_events.has("EVENT_MOKI_LAB_GOT_RAPTORCH"):
			starter = 0
		if Global.past_events.has("EVENT_MOKI_LAB_GOT_ORCHYNX"):
			starter = 1
		if Global.past_events.has("EVENT_MOKI_LAB_GOT_ELETUX"):
			starter = 2


func event1_intro(_body): # First event to get pokemon
	var event_name = "EVENT_BAMBOLAB_1_COMPLETE"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.game.lock_player()

		Global.game.get_node("Background_music").stream = load("res://Audio/BGM/PU-Radio_ Oak.ogg")
		Global.game.get_node("Background_music").play()

		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 10)
		yield(Global.game.player, "done_movement")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_1", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_2", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_3", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_4", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_5", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_6", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		# Theo Alert
		theo.alert()
		yield(theo, "alert_done")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_7", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_8", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_9", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_10", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_11", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_12", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_13", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		
		event1_choice()
func event1_choice():
	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_14", bambo.get_global_transform_with_canvas().get_origin())
	
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
		#Move player back into position
		if Global.game.player.position == Vector2(240, 208):
			#Don't move. Player already in position
			pass
		else:
			match Global.game.player.position:
				Vector2(240, 176):
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
					yield(Global.game.player, "done_movement")
					
				Vector2(208, 144):
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
					yield(Global.game.player, "done_movement")
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.RIGHT, 1)
					yield(Global.game.player, "done_movement")
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
					yield(Global.game.player, "done_movement")
				Vector2(272, 144):
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
					yield(Global.game.player, "done_movement")
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.LEFT, 1)
					yield(Global.game.player, "done_movement")
					Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
					yield(Global.game.player, "done_movement")
		Global.game.player.set_facing_direction("Up")
		bambo.set_idle_frame("Down")
		theo.set_idle_frame("Up")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_15", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		event1_test()
		yield(self, "finished")
		event1_pick_up()
	else:
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_OPTION_2_1", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		theo.set_idle_frame("Right")

		DialogueSystem.set_box_position(DialogueSystem.TOP)
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_OPTION_2_2", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		theo.set_idle_frame("Up")

		Global.game.get_node("Background_music").stream = load(background_music)
		Global.game.get_node("Background_music").play()

		Global.past_events.append("EVENT_BAMBOLAB_1_INTRO")
		Global.game.release_player()

func event1_pick_up():
	# Play open
	$PokeMachine/AnimationPlayer.play("Open")
	yield($PokeMachine/AnimationPlayer, "animation_finished")

	bambo.call_deferred("move_multi", "Right", 1)
	yield(bambo, "done_movement")
	bambo.call_deferred("set_idle_frame", "Left")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_38", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.release_player()
	Global.past_events.append("EVENT_BAMBOLAB_1_PICK_UP_ENABLE")
	emit_signal("finished")

func event1_test():
	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_16", bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q1)
	yield(ui, "selected")
	var responce1 : int = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED


	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_17", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_18", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_19", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_20", bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q2)
	yield(ui, "selected")
	var responce2 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_21", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_22", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_23", bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q3)
	yield(ui, "selected")
	var responce3 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_24", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_25", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_26", bambo.get_global_transform_with_canvas().get_origin())
	yield(DialogueSystem, "finished_printing")
	DialogueSystem.hold = false
	ui.prompt_test(ui.TEST.Q4)
	yield(ui, "selected")
	var responce4 : int  = ui.get_test_responce() # 0: ATTACK, 1: DEFENSE, 2: BALLANCED

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_27", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_28", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_29", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_30", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_31", bambo.get_global_transform_with_canvas().get_origin())
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
	
	var result = -1 # 0 = Raptorch, 1 = Orchynx, 2 = Eletux

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
			Global.past_events.append("EVENT_MOKI_LAB_GOT_RAPTORCH")
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
		1: # Orchynx
			Global.past_events.append("EVENT_MOKI_LAB_GOT_ORCHYNX")
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
		2: # Eletux
			Global.past_events.append("EVENT_MOKI_LAB_GOT_ELETUX")
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_33_Eletux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_34_Eletux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_35_Eletux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_36_Eletux")
			yield(Global.game, "event_dialogue_end")

			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_37_Eletux")
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
func event1_poke_machine():
	if Global.past_events.has("EVENT_BAMBOLAB_1_PICK_UP_ENABLE") && !Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE"):
		#Global.past_events.erase("EVENT_BAMBOLAB_1_PICK_UP_ENABLE")
		Global.game.lock_player()
		$PokeMachine.frame = 10
		var time = Global.game.get_node("Background_music").get_playback_position()
		Global.game.get_node("Background_music").stop()
		var sound = load("res://Audio/ME/BW_captured.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()

		DialogueSystem.hold = true
		var poke = Pokemon.new()
		match starter:
			0: # Raptorch
				poke.set_basic_pokemon_by_level(3,5)
				Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OBTAIN_RAPTORCH")
			1: # Orchynx
				poke.set_basic_pokemon_by_level(1,5)
				Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OBTAIN_ORCHYNX")
			2: # Eletux
				poke.set_basic_pokemon_by_level(5,5)
				Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_OBTAIN_ELETUX")
		Global.add_poke_to_party(poke)
		Global.player_starter = starter

		yield(Global.game.get_node("Effect_music"), "finished")
		Global.game.get_node("Effect_music").stop()
		Global.game.get_node("Background_music").play(time)

		DialogueSystem.hold = false
		yield(Global.game, "event_dialogue_end")
		event_1_rival_poke()
		
func event_1_rival_poke():
	bambo.call_deferred("set_idle_frame", "Down")
	Global.game.player.call_deferred("set_facing_direction", 0)

	var time = Global.game.get_node("Background_music").get_playback_position()
	Global.game.get_node("Background_music").stop()
	var sound = load("res://Audio/BGM/PU-Rival Theme.ogg")
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()

	theo.call_deferred("move_multi", "Right", 1)
	yield(theo, "done_movement")
	theo.call_deferred("set_idle_frame", "Up")

	DialogueSystem.set_box_position(DialogueSystem.TOP)
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_39", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	
	theo.jump()
	yield(theo, "done_movement")
	theo.jump()
	yield(theo, "done_movement")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_40", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_41", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_42", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	ui.Poke_get()
	yield(ui, "selected")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_42")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_43")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_44")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_45")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_46")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_47")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_48")
	yield(Global.game, "event_dialogue_end")

	
	Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_49")
	yield(Global.game, "event_dialogue_end")

	DialogueSystem.hold = true
	match Global.player_starter:
		0:
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_50_Orchynx")
		1:
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_50_Eletux")
		2:
			Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_50_Raptorch")
	yield(DialogueSystem, "finished_printing")

	match starter: # For Theo
		0:
			ui.Poke_get_slide(1)
		1:
			ui.Poke_get_slide(2)
		2:
			ui.Poke_get_slide(0)
	DialogueSystem.hold = false
	yield(ui, "selected")
	ui.fadeout()
	yield(ui, "selected")

	DialogueSystem.set_box_position(DialogueSystem.TOP)
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_51", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	# Move theo and player at same time
	Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.LEFT, 1) # This somehow just runs instantly and I can't debug this!
	theo.call_deferred("move_multi", "Up", 2)
	yield(Global.game.player, "done_movement")
	Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 2)
	yield(Global.game.player, "done_movement")
	Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.UP)
	$PokeMachine.frame = 6

	theo.alert()
	yield(theo, "alert_done")

	theo.call_deferred("move_multi", "Down", 2)
	yield(theo, "done_movement")

	theo.call_deferred("set_idle_frame", "Left")
	Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.RIGHT)
	
	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_52", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_53", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.get_node("Background_music").stop()

	# FIRST BATTLE!! FIANALY!
	lab_battle()
func lab_battle():
	Global.game.battle = load("res://Utilities/Battle/Battle.tscn").instance()
	Global.game.add_child(Global.game.battle)

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.RIVAL
	bid.battle_back = bid.BattleBack.INDOOR_1
	bid.opponent = Opponent.new()
	bid.opponent.name = "Theo"
	bid.opponent.opponent_type = Opponent.OPPONENT_RIVAL
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.after_battle_quote = "EVENT_MOKI_LAB_FIRST_POK_Battle_WIN"
	bid.victory_award = 350

	var poke = Pokemon.new()
	match Global.player_starter:
		0:# Player has gets Raptorch
			poke.set_basic_pokemon_by_level(1,5) # Theo gets Orchynx
		1:# Player has gets Orchynx
			poke.set_basic_pokemon_by_level(5,5) # Theo gets Eletux
		2:# Player has gets Eletux
			poke.set_basic_pokemon_by_level(3,5) # Theo gets Raptorch
	bid.opponent.pokemon_group.append(poke)
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer086.png")
	
	Global.game.battle.Start_Battle(bid) # YEET!!!
	yield(Global.game.battle, "battle_complete")

	Global.game.get_node("Background_music").stream = load("res://Audio/BGM/PU-Rival Theme.ogg")
	Global.game.get_node("Background_music").play()
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	if Global.game.battle.player_won:
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_54", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_55", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_56", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_57", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		bambo.call_deferred("move_multi", "Left", 1)
		yield(bambo, "done_movement")

		bambo.call_deferred("move_multi", "Down", 1)
		yield(bambo, "done_movement")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_58", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		# Fade screen and heal pokemon
		var fade = Global.game.get_node("CanvasLayer/Fade/AnimationPlayer")
		fade.play_backwards("Fade")
		yield(fade, "animation_finished")

		# Heal and effect sound
		Global.heal_party()
		var sound = load("res://Audio/ME/Pokemon Healing.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()
		yield(Global.game.get_node("Effect_music"), "finished")
		DialogueSystem.set_box_position(DialogueSystem.TOP)
		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_HEAL")
		yield(Global.game, "event_dialogue_end")
		fade.play("Fade")
		yield(fade, "animation_finished")
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

		theo.call_deferred("set_idle_frame", "Up")
		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.UP)

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_59", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_60", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_61", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_62", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_63", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.DOWN)
		theo.call_deferred("move_multi", "Down", 8)
		yield(theo, "done_movement")
		theo.queue_free()

		# Play lab music
		Global.game.get_node("Effect_music").stop()
		Global.game.get_node("Background_music").stream = load("res://Audio/BGM/PU-Radio_ Oak.ogg")
		Global.game.get_node("Background_music").play()

		bambo.call_deferred("move_multi", "Down", 1)
		yield(bambo, "done_movement")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_64", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_65", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		bambo.call_deferred("move_multi", "Down", 4)
		yield(bambo, "done_movement")

		bambo.call_deferred("set_idle_frame", "Up")

		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_66")
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_67")
		yield(Global.game, "event_dialogue_end")

		bambo.call_deferred("move_multi", "Down", 4)
		yield(bambo, "done_movement")

		bambo.queue_free()
		bambo = null
		Global.past_events.append("EVENT_BAMBOLAB_1_WIN")
	else:
		
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_54_LOSS", theo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		theo.call_deferred("move_multi", "Down", 8)
		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.DOWN)
		yield(theo, "done_movement")
		theo.queue_free()

		Global.game.get_node("Effect_music").stop()
		Global.game.get_node("Background_music").stream = load("res://Audio/BGM/PU-Lab.ogg")
		Global.game.get_node("Background_music").play()

		bambo.call_deferred("move_multi", "Down", 2)
		yield(bambo, "done_movement")
		
		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_55_LOSS", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.RIGHT)
		bambo.call_deferred("move_multi", "Left", 1)
		yield(bambo, "done_movement")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_56_LOSS", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_57_LOSS", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_58_LOSS", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_59_LOSS", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		# Fade screen and heal pokemon
		var fade = Global.game.get_node("CanvasLayer/Fade/AnimationPlayer")
		fade.play_backwards("Fade")
		yield(fade, "animation_finished")

		# Heal and effect sound
		Global.heal_party()
		var sound = load("res://Audio/ME/Pokemon Healing.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()
		yield(Global.game.get_node("Effect_music"), "finished")
		DialogueSystem.set_box_position(DialogueSystem.TOP)
		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_HEAL")
		yield(Global.game, "event_dialogue_end")
		fade.play("Fade")
		yield(fade, "animation_finished")
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.DOWN)
		bambo.call_deferred("move_multi", "Down", 3)
		yield(bambo, "done_movement")

		bambo.call_deferred("set_idle_frame", "Up")

		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_66")
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_67")
		yield(Global.game, "event_dialogue_end")

		bambo.call_deferred("move_multi", "Down", 4)
		yield(bambo, "done_movement")

		bambo.queue_free()

		bambo = null
		theo = null

		Global.past_events.append("EVENT_BAMBOLAB_1_LOSS")
		pass
	Global.past_events.append("EVENT_BAMBOLAB_1_COMPLETE")
	Global.game.release_player()

func block(_area):
	if (!Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && (Global.past_events.has("EVENT_BAMBOLAB_1_INTRO") || Global.past_events.has("EVENT_BAMBOLAB_1_PICK_UP_ENABLE")) ):
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.lock_player()
		Global.game.play_dialogue("EVENT_MOKI_LAB_FIRST_POK_PLAYER_RUN_AWAY")
		yield(Global.game, "event_dialogue_end")
		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 1)
		yield(Global.game.player, "done_movement")
		Global.game.release_player()
