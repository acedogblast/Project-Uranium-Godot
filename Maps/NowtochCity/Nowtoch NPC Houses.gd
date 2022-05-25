extends Node2D

var type = "Indoor"
var place_name = "Nowtoch City"
var npc_temp1

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.past_events.has("NOWTOCH_CITY_EVENT_1") && !Global.past_events.has("NOWTOCH_CITY_EVENT_2"):
		yield(Global.game, "tranistion_complete")
		event2()
	pass

func event2():
	Global.game.lock_player()
	# Keep screen black
	Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").stop()
	Global.game.get_node("CanvasLayer/Fade").show()
	Global.game.get_node("CanvasLayer/Fade").modulate = Color(0.0, 0.0, 0.0, 1.0)
	
	npc_temp1 = load("res://Utilities/NPC.tscn").instance()
	npc_temp1.texture = load("res://Graphics/Characters/PU-Maria.png")
	npc_temp1.position = Vector2(1840, 1040)
	npc_temp1.set_idle_frame("Down")
	$NPC_Layer.add_child(npc_temp1)
	#wait
	yield(get_tree().create_timer(1.0), "timeout")
	
	DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
	Global.game.play_dialogue("EVENT_NOWTOCH_CITY_6")
	yield(Global.game, "event_dialogue_end")
	
	Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play("Fade")
	yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")

	npc_temp1.alert()
	yield(npc_temp1, "alert_done")

	npc_temp1.move_multi("Right", 2)
	yield(npc_temp1, "done_movement")
	npc_temp1.move_multi("Down", 2)
	yield(npc_temp1, "done_movement")
	npc_temp1.move_multi("Right", 1)
	yield(npc_temp1, "done_movement")
	npc_temp1.set_idle_frame("Down")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_7", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_8", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_9", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_10", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue("EVENT_NOWTOCH_CITY_11")
	yield(Global.game, "event_dialogue_end")

	# remove key
	var key = Global.inventory.get_item_by_id(579)
	Global.inventory.remove_item(key)

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_12", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")
	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_13", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_14", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue_with_point("EVENT_NOWTOCH_CITY_15", npc_temp1.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	Global.game.player.move_player_event(Global.game.player.DIRECTION.LEFT, 1)
	npc_temp1.move_multi("Down", 2)
	yield(npc_temp1, "done_movement")
	Global.game.player.set_facing_direction("Right")

	yield(get_tree().create_timer(0.25), "timeout")
	npc_temp1.queue_free()
	npc_temp1 = null

	Global.past_events.append("NOWTOCH_CITY_EVENT_2")
	Global.game.release_player()