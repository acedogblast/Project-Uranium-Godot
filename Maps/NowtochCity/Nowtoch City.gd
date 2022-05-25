extends Node2D

var adjacent_scenes = [
	["res://Maps/Routes/Route2/Route 2.tscn", Vector2(480,2368)]
]

var background_music = "res://Audio/BGM/PU-Nowtoch City.ogg";

var type = "Outside"
var place_name = "Nowtoch City"
var heal_point = Vector2(656,432)

var npc_temp1
var npc_temp2

func _ready():
	update_NPCs()


func interaction(check_pos : Vector2, direction):
	if npc_temp1 != null && npc_temp1.position == check_pos:
		npc_temp1.face_player(Global.game.player.direction)
		if !Global.past_events.has("NOWTOCH_CITY_EVENT_1"):
			event1()
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NOWTOCH_CITY_CREEPY_GUY" , npc_temp1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			npc_temp1.set_idle_frame("Down")
			Global.game.release_player()
	
	pass


func update_NPCs():
	if !Global.past_events.has("NOWTOCH_CITY_EVENT_3"):
		npc_temp1 = load("res://Utilities/NPC.tscn").instance()
		npc_temp1.texture = load("res://Graphics/Characters/HGSS_130.png")
		npc_temp1.position = Vector2(1584,496)
		$NPC_Layer.add_child(npc_temp1)
		$NPC_Layer/MariaDoor.locked = true
		$NPC_Layer/MariaDoor.key_id = 579

		if Global.past_events.has("NOWTOCH_CITY_EVENT_2"):
			# Add in Maria NPC
			npc_temp2 = load("res://Utilities/NPC.tscn").instance()
			npc_temp2.texture = load("res://Graphics/Characters/PU-Maria.png")
			npc_temp2.position = Vector2(1584,528)
			$NPC_Layer.add_child(npc_temp2)
			npc_temp2.set_idle_frame("Up")
			

func event1():
	Global.game.lock_player()
	npc_temp1.alert()
	yield(npc_temp1, "alert_done")

	DialogueSystem.set_box_position(DialogueSystem.TOP)

	for i in range(1, 5): # Plays 1,2,3,4
		Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_" + str(i), npc_temp1.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

	# Add key to inventory
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	Global.game.recive_item(579)
	yield(Global.game, "end_of_event")

	DialogueSystem.set_box_position(DialogueSystem.TOP)
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_5" , npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")


	npc_temp1.set_idle_frame("Down")
	Global.game.release_player()
	Global.past_events.append("NOWTOCH_CITY_EVENT_1")

func event3(_body):

	if !Global.past_events.has("NOWTOCH_CITY_EVENT_2") || Global.past_events.has("NOWTOCH_CITY_EVENT_3"):
		return

	yield(Global.game.player, "step")
	Global.game.lock_player()

	# Move to center if not already
	var pos = Global.game.player.get_position_relative_to_current_scene()
	match pos:
		Vector2(1552, 624): # Move to right
			Global.game.player.move_player_event(Global.game.player.DIRECTION.RIGHT, 1)
			yield(Global.game.player, "done_movement")
		Vector2(1616, 624): # Move to left
			Global.game.player.move_player_event(Global.game.player.DIRECTION.LEFT, 1)
			yield(Global.game.player, "done_movement")
	
	Global.game.player.set_facing_direction("Up")
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_16" , npc_temp2.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_17" , npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_18" , npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_19" , npc_temp2.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_20" , npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_21" , npc_temp2.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	npc_temp1.move_multi("Right", 1)
	yield(npc_temp1, "done_movement")
	npc_temp1.move_multi("Down", 14)
	yield(npc_temp1, "done_movement")

	npc_temp1.queue_free()
	npc_temp1 = null

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_22" , npc_temp2.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	npc_temp2.set_idle_frame("Down")

	for i in range(23, 27):
		Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_" + str(i), npc_temp2.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

	npc_temp2.move_multi("Up", 2)
	yield(npc_temp2, "done_movement")

	npc_temp2.queue_free()
	npc_temp2 = null

	Global.past_events.append("NOWTOCH_CITY_EVENT_3")
	Global.game.release_player()
