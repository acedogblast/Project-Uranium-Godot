extends Node2D

#var next_scene1 = "res://Maps/Route03/Route03.tscn"
var next_scene1 = "res://Maps/Routes/Route 3.tscn"
var next_scene1_offset = Vector2(2272,26*32)

var background_music = "res://Audio/BGM/PU-Moki Town.ogg";

var type = "Outside"
var place_name = "Moki Town"

var hero_home_x = 880
var hero_home_y = 1008
var npc_layer
var grass_pos = []

func _ready():
	npc_layer = $NPC_Layer

func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	return null
	
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
		
		Global.game.player.direction = Global.game.player.DIRECTION.RIGHT
		Global.game.player.call_deferred("set_idle_frame")
		npc.position = Vector2(1104,496)
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
