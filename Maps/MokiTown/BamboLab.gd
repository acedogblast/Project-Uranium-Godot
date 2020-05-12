extends Node2D

var background_music = "res://Audio/BGM/PU-Radio_ Oak.ogg";
var type = "Indoors"
var place_name = "Bambo's Lab"
var npc_layer

func _ready():
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
		var theo = load("res://Utilities/NPC.tscn").instance()
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

		Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_14", $NPC_Layer/Bambo.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.player.change_input()
		Global.past_events.append(event_name)
	pass