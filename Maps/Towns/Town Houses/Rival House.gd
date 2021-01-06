extends Node2D

var place_name = "Theo's House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

var event_1_name = "EVENT_RIVAL_HOME_1"
var npc_layer

func _ready():
	npc_layer = $NPC_Layer
	$BG.show()
	yield(Global.game, "tranistion_complete")
	event1(null) # Play event on enter.
	pass
func event1(_body):
	var event_name = "EVENT_MOKI_TOWN_THEO_HOME_1"
	if Global.past_events.has(event_name) && Global.past_events.has("EVENT_BAMBOLAB_1_COMPLETE"):
		print("New Event: " + event_name)
		Global.game.player.change_input()
		Global.game.menu.locked = true

		# Spawn NPCs
		var theo = load("res://Utilities/NPC.tscn").instance()
		var cameron = load("res://Utilities/NPC.tscn").instance()
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

			Global.game.play_dialogue_with_point("EVENT_MOKI_LAB_FIRST_POK_52", cameron.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")





			pass
		if Global.past_events.has("EVENT_BAMBOLAB_1_LOSS"):
			pass
