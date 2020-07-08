extends Node

#var isInteracting = false
#var canInteract = true

var place_name = Global.TrainerName + "'s House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

var event_1_name = "EVENT_HEROHOME_1"
var grass_pos = []

func _ready():
	$BlackBG.visible = true
	$Floor2/TileMap5.z_index = 9
	#yield(get_tree().create_timer(1), "timeout")

	$Aunt.set_idle_frame("Up")
	Global.game.get_node("CanvasLayer/Fade").visible = false

func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	if collider == $Floor2/Console.position:
		return "INTERACT_MOKITOWN_HOUSE_CONSOLE"
	if collider == $Floor2/TV.position:
		return "INTERACT_MOKITOWN_HOUSE_TV"
	if collider == $Floor2/TV2.position:
		return "INTERACT_MOKITOWN_HOUSE_TV"
	if collider == $Floor2/Shelf.position:
		return "INTERACT_MOKITOWN_HOUSE_BOOKSHELF"
	if collider == $Floor2/Shelf2.position:
		return "INTERACT_MOKITOWN_HOUSE_BOOKSHELF"
	if npc_collider == $Aunt.position: # NPC interaction
		#Face player
		$Aunt.face_player(direction)
		#Trigger event2
		event2()
	return null
func event1(body): # Aunt Calling player downstairs
	var event_name = "EVENT_HEROHOME_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.game.get_node("CanvasLayer/Fade").visible = true
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.player.change_input()
		#Global.game.player.canMove = false
		Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play("Fade")
		yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")
		Global.game.get_node("CanvasLayer/Fade").visible = false
		Global.game.play_dialogue_with_point(event_name, Vector2(120, 140))
		yield(Global.game, "event_dialogue_end")
		Global.game.player.change_input()
		#Global.game.player.canMove = true
		Global.past_events.append(event_name)
func event2():
	var event_name = "EVENT_HEROHOME_NPC_AUNT_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.past_events.append(event_name)
		Global.game.player.change_input()
		#Global.game.player.canMove = false
		DialogueSystem.set_box_position(DialogueSystem.TOP)

		for i in range(4):
			Global.game.play_dialogue_with_point("NPC_AUNT1_D" + str(i+1) , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			#Global.game.player.canMove = false

		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue_with_point("NPC_AUNT1_D5" , $Aunt.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		#Global.game.player.canMove = false

		Global.game.play_dialogue_with_point("NPC_AUNT1_D6" , Vector2(0,0))
		# Play key item sound
		var time = Global.game.get_node("Background_music").get_playback_position()
		Global.game.get_node("Background_music").stop()
		var sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()
		yield(Global.game.get_node("Effect_music"), "finished")
		Global.game.get_node("Background_music").play(time)
		#Global.game.player.canMove = false

		# Enable running
		Global.can_run = true
		
		Global.game.play_dialogue_with_point("NPC_AUNT1_D7" , Vector2(0,0))
		yield(Global.game, "event_dialogue_end")
		#Global.game.player.canMove = false

		DialogueSystem.set_box_position(DialogueSystem.TOP)
		for i in range(5):
			Global.game.play_dialogue_with_point("NPC_AUNT1_D" + str(i+8) , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			#Global.game.player.canMove = false
		#Global.game.player.canMove = true
		Global.game.player.change_input()
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		
