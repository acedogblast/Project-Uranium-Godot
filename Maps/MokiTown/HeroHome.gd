extends Node

#var isInteracting = false
#var canInteract = true

var place_name = Global.TrainerName + "'s House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

var event_1_name = "EVENT_HEROHOME_1"

func _ready():
	$BlackBG.visible = true
	$Floor2/TileMap5.z_index = 9
	#yield(get_tree().create_timer(1), "timeout")

	if !Global.past_events.has(event_1_name):
		# Blackscreen
		Global.game.get_node("CanvasLayer/Fade").visible = true
		pass

func interaction(collider): # collider is a Vector2 of the position of object to interact
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
	return null
func event1(body): # Aunt Calling player downstairs
	var event_name = "EVENT_HEROHOME_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.game.player.change_input()
		Global.game.player.canMove = false
		Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play("Fade")
		yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")
		Global.game.get_node("CanvasLayer/Fade").visible = false
		Global.game.play_dialogue_with_point(event_name, Vector2(120, 140))
		yield(Global.game, "event_dialogue_end")
		Global.game.player.canMove = true
		Global.past_events.append(event_name)
