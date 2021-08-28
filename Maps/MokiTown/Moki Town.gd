extends Node2D

var adjacent_scenes = [
	["res://Maps/Routes/Route3/Route 3.tscn", Vector2(2304,832)]
]

var background_music = "res://Audio/BGM/PU-Moki Town.ogg";

var type = "Outside"
var place_name = "Moki Town"

var npc_layer

var base_encounter_rate = 10 # Not sure if correct value

# NPCs
var theo
var bambo

# Wild Poke table
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[7,  100,    2,           6]
]

func _ready():
	npc_layer = $NPC_Layer
	if Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && !Global.past_events.has("EVENT_MOKI_TOWN_DEMO"): #TODO add check if event 2 is over
		event2_prep()
	
	if Global.past_events.has("MOKI_TOWN_ROCK1_SMASHED"):
		$NPC_Layer/Rock1.queue_free()
	if Global.past_events.has("MOKI_TOWN_ROCK2_SMASHED"):
		$NPC_Layer/Rock2.queue_free()
	if Global.past_events.has("MOKI_TOWN_ROCK3_SMASHED"):
		$NPC_Layer/Rock3.queue_free()


func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == $NPC_Layer/Rock1.position || check_pos == $NPC_Layer/Rock2.position || check_pos == $NPC_Layer/Rock3.position:
		Global.game.lock_player()
		Global.game.play_dialogue("SMASHABLE_ROCK")
		yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
	if check_pos == Vector2(816, 1040):
		print("Modded")
		var poke = Pokemon.new()
		poke.set_basic_pokemon_by_level(3, 20)
		Global.pokemon_group.append(poke)
		pass
	return null


func block_exit(_body):
	# Check if player has pokes
	if (Global.pokemon_group.empty() && !Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE")):
		# Wait for player to stop moving
		Global.game.lock_player()
		yield(Global.game.player, "step")
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue("MOKI_TOWN_BLOCK")
		yield(Global.game, "event_dialogue_end")
		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.RIGHT, 1)
		yield(Global.game.player, "done_movement")
		Global.game.release_player()
		pass
	if Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && !Global.past_events.has("EVENT_MOKI_TOWN_THEO_HOME_1"):
		# Wait for player to stop moving
		Global.game.lock_player()
		yield(Global.game.player, "step")
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue_with_point("NPC_BAMBO_MOKI_TOWN_CATCH_DEMO_PREP_1", bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.RIGHT, 1)
		yield(Global.game.player, "done_movement")
		Global.game.release_player()
		pass
	if Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE") && Global.past_events.has("EVENT_MOKI_TOWN_THEO_HOME_1") && !Global.past_events.has("EVENT_MOKI_TOWN_DEMO"):
		event2()
		pass

func event1(_body):
	var event_name = "EVENT_MOKI_TOWN_THEO_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		DialogueSystem.set_box_position(DialogueSystem.TOP) # Not the same as original
		Global.game.lock_player()
		# Message
		Global.game.play_dialogue("EVENT_MOKI_TOWN_THEO_1")
		yield(Global.game, "event_dialogue_end")
		# Change music and move to center at same time
		var time = Global.game.get_node("Background_music").get_playback_position()
		Global.game.get_node("Background_music").stop()
		var sound = load("res://Audio/BGM/PU-Rival Theme.ogg")
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()
		# Move player to center if not already
		#var center = Vector2(816,496) # Top: 464 and 432 Bottom: 528 and 560
		var dir
		var steps
		match Global.game.player.position.y:
			464.0: # These need to be floats! TOOK ME HOURS TO FIGURE THAT OUT!
				dir = Global.game.player.DIRECTION.DOWN
				steps = 1
				Global.game.player.call_deferred("move_player_event", dir, steps)
				yield(Global.game.player, "done_movement")
			432.0:
				dir = Global.game.player.DIRECTION.DOWN
				steps = 2
				Global.game.player.call_deferred("move_player_event", dir, steps)
				yield(Global.game.player, "done_movement")
			528.0:
				dir = Global.game.player.DIRECTION.UP
				steps = 1
				Global.game.player.call_deferred("move_player_event", dir, steps)
				yield(Global.game.player, "done_movement")
			560.0:
				dir = Global.game.player.DIRECTION.UP
				steps = 2
				Global.game.player.call_deferred("move_player_event", dir, steps)
				yield(Global.game.player, "done_movement")
		
		# Spawn NPC
		var npc = load("res://Utilities/NPC.tscn").instance()
		npc.texture = load("res://Graphics/Characters/Rivaltheo.PNG")
		npc_layer.add_child(npc)
		
		#Global.game.player.direction = Global.game.player.DIRECTION.RIGHT
		Global.game.player.set_facing_direction(Global.game.player.DIRECTION.RIGHT)
		npc.position = Vector2(1136,496)
		npc.call_deferred("move_multi", "Left", 8)
		yield(npc, "done_movement")
		#print("NPC done")
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_THEO_2", npc.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		npc.call_deferred("move_multi", "Up", 1)
		yield(npc, "done_movement")
		npc.call_deferred("move_multi", "Left", 10)
		yield(npc, "done_movement")
		npc.queue_free()
		Global.game.get_node("Effect_music").stop()
		Global.game.get_node("Background_music").play(time)
		Global.game.release_player()
		Global.past_events.append(event_name)
func event2_prep():
	# Spawn npcs
	bambo = load("res://Utilities/NPC.tscn").instance()
	bambo.texture = load("res://Graphics/Characters/phone035.PNG")
	npc_layer.add_child(bambo)
	bambo.position = Vector2(496, 1424)
	bambo.set_idle_frame("Right")

	if Global.past_events.has("EVENT_MOKI_TOWN_THEO_HOME_1"):
		theo = load("res://Utilities/NPC.tscn").instance()
		theo.texture = load("res://Graphics/Characters/Rivaltheo.PNG")
		npc_layer.add_child(theo)
		theo.position = Vector2(528, 1456)
		theo.set_idle_frame("Left")
	pass
func event2():
	Global.game.lock_player()
	yield(Global.game.player, "step")
	if Global.game.player.position == Vector2(528,1392):
		#Move player down
		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.DOWN, 1)
		yield(Global.game.player, "done_movement")
		Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.LEFT)

	Global.game.get_node("Background_music").stream = load("res://Audio/BGM/PU-Radio_ Oak.ogg")
	Global.game.get_node("Background_music").play()

	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_1", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_2", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	# Turn bambo right
	bambo.set_idle_frame("Left")
	yield(get_tree().create_timer(0.50), "timeout")
	
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_3", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_4", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_5", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_6", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	bambo.call_deferred("move_multi", "Left", 1)
	yield(bambo, "done_movement")

	yield(get_tree().create_timer(0.50), "timeout")

	# Spawn Chyinmunk
	var chyinmunk = load("res://Utilities/NPC.tscn").instance()
	chyinmunk.texture = load("res://Graphics/Characters/PU-Chyinmunk.png")
	npc_layer.add_child(chyinmunk)
	chyinmunk.position = Vector2(400, 1424)
	chyinmunk.set_idle_frame("Left")

	# Play cry SE
	var sound = load("res://Audio/SE/007Cry.wav")
	sound.loop_mode = AudioStreamSample.LOOP_DISABLED
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()
	
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_7", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	# Bambo's pokemon
	var bambo_mon = load("res://Utilities/NPC.tscn").instance()

	if Global.past_events.has("EVENT_MOKI_LAB_GOT_RAPTORCH"): #Eletux
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_8_Eletux", bambo.get_global_transform_with_canvas().get_origin())
		bambo_mon.texture = load("res://Graphics/Characters/PU-Eletux.png")
	if Global.past_events.has("EVENT_MOKI_LAB_GOT_ORCHYNX"): #Raptorch
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_8_Raptorch", bambo.get_global_transform_with_canvas().get_origin())
		bambo_mon.texture = load("res://Graphics/Characters/PU-Raptorch.png")
	if Global.past_events.has("EVENT_MOKI_LAB_GOT_ELETUX"): #Orchynx
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_8_Orchynx", bambo.get_global_transform_with_canvas().get_origin())
		bambo_mon.texture = load("res://Graphics/Characters/PU-Orchynx.png")
	yield(Global.game, "event_dialogue_end")
	
	npc_layer.add_child(bambo_mon)
	bambo_mon.position = Vector2(432, 1424)
	bambo_mon.set_idle_frame("Left")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_9", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_10", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_11", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	if Global.past_events.has("EVENT_MOKI_LAB_GOT_RAPTORCH"): #Eletux
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_12_Eletux", bambo.get_global_transform_with_canvas().get_origin())
	if Global.past_events.has("EVENT_MOKI_LAB_GOT_ORCHYNX"): #Raptorch
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_12_Raptorch", bambo.get_global_transform_with_canvas().get_origin())
	if Global.past_events.has("EVENT_MOKI_LAB_GOT_ELETUX"): #Orchynx
		Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_12_Orchynx", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	# Play hit SE
	sound = load("res://Audio/SE/Blow1.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()

	yield(get_tree().create_timer(0.10), "timeout")

	chyinmunk.set_idle_frame("Right")

	# Play cry SE
	sound = load("res://Audio/SE/007Cry.wav")
	sound.loop_mode = AudioStreamSample.LOOP_DISABLED
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()

	Global.game.play_dialogue("EVENT_MOKI_TOWN_CAPTURE_DEMO_13")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_14", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	
	sound = load("res://Audio/SE/throw.wav")
	sound.loop_mode = AudioStreamSample.LOOP_DISABLED
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()

	# Pokeball go!
	chyinmunk.texture = load("res://Graphics/Characters/itemball.png")

	sound = load("res://Audio/SE/balldrop.wav")
	sound.loop_mode = AudioStreamSample.LOOP_DISABLED
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()

	# Remove chyinmunk
	chyinmunk.queue_free()

	sound = load("res://Audio/SE/recall.wav")
	sound.loop_mode = AudioStreamSample.LOOP_DISABLED
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()

	bambo.call_deferred("move_multi", "Left", 1)
	yield(bambo, "done_movement")

	# Remove Bambo's pokemon
	bambo_mon.queue_free()

	yield(get_tree().create_timer(0.10), "timeout")

	bambo.call_deferred("move_multi", "Right", 1)
	yield(bambo, "done_movement")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_15", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_16", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	bambo.call_deferred("move_multi", "Right", 1)
	yield(bambo, "done_movement")

	bambo.call_deferred("move_multi", "Left", 1) # TODO: Change to move backwards when NPCs can do that.
	yield(bambo, "done_movement")

	bambo.set_idle_frame("Right")

	var time = Global.game.get_node("Background_music").get_playback_position()
	Global.game.get_node("Background_music").stop()
	sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()

	Global.game.play_dialogue("EVENT_MOKI_TOWN_CAPTURE_DEMO_17")
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Background_music").play(time)
	
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_18", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_19", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_20", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	bambo.call_deferred("move_multi", "Right", 1)
	yield(bambo, "done_movement")

	bambo.call_deferred("move_multi", "Left", 1) # TODO: Change to move backwards when NPCs can do that.
	yield(bambo, "done_movement")

	bambo.set_idle_frame("Right")

	# Add pokeballs to inventory
	Global.inventory.add_item_by_name_multiple("Pokéball", 5)

	time = Global.game.get_node("Background_music").get_playback_position()
	Global.game.get_node("Background_music").stop()
	sound = load("res://Audio/ME/Jingle - Regular Item.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	Global.game.play_dialogue("EVENT_MOKI_TOWN_CAPTURE_DEMO_21")
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Background_music").play(time)

	Global.game.play_dialogue("EVENT_MOKI_TOWN_CAPTURE_DEMO_22")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_23", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_24", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_25", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	time = Global.game.get_node("Background_music").get_playback_position()
	Global.game.get_node("Background_music").stop()
	sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()
	Global.game.play_dialogue("EVENT_MOKI_TOWN_CAPTURE_DEMO_26")
	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Background_music").play(time)


	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_27", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_28", bambo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	bambo.call_deferred("move_multi", "Up", 1)
	yield(bambo, "done_movement")	
	bambo.call_deferred("move_multi", "Right", 4)
	yield(bambo, "done_movement")	
	bambo.call_deferred("move_multi", "Down", 2)
	yield(bambo, "done_movement")	
	bambo.call_deferred("move_multi", "Right", 9)
	yield(bambo, "done_movement")	

	bambo.queue_free()

	# Face player and theo together
	theo.set_idle_frame("Up")
	Global.game.player.call_deferred("set_facing_direction", Global.game.player.DIRECTION.DOWN)
	
	yield(get_tree().create_timer(0.2), "timeout")

	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_29", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_MOKI_TOWN_CAPTURE_DEMO_30", theo.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	theo.call_deferred("move_multi", "Left", 1)
	yield(theo, "done_movement")	
	theo.call_deferred("move_multi", "Up", 1)
	yield(theo, "done_movement")
	theo.call_deferred("move_multi", "Left", 7)
	yield(theo, "done_movement")

	theo.queue_free()
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.past_events.append("EVENT_MOKI_TOWN_DEMO")
	Global.game.release_player()
	pass
func get_grass_cells():
	return get_node("Tile Layer 1/Grass").get_used_cells()

