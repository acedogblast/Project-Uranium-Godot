extends Node

#var isInteracting = false
#var canInteract = true

var place_name = Global.TrainerName + "'s House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

func _ready():
	$BlackBG.visible = true
	$Floor2/TileMap5.z_index = 9
	#yield(get_tree().create_timer(1), "timeout")

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
