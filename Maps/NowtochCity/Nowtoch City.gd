extends Node2D

var adjacent_scenes = [
	["res://Maps/Routes/Route2/Route 2.tscn", Vector2(480,2368)]
]

var background_music = "res://Audio/BGM/PU-Nowtoch City.ogg";

var type = "Outside"
var place_name = "Nowtoch City"

var npc_temp1

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

func event2():
	
	
	pass
