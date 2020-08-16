extends Node2D

var next_scene1 := "res://Maps/Routes/Route 3.tscn"

var background_music := "res://Audio/BGM/PU-Moki Town.ogg";

var type := "Indoors"
var place_name = "Pokecenter"
var is_inside := false

func _ready() -> void:
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_inside:
		if Input.is_action_pressed("ui_accept"):
			print("healing pokemon...")
			pass
	pass

func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	print("healing pokemon...")
	Global.heal_party()
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	return null


func _on_Area2D_area_entered(area: Area2D) -> void:
	print(area.name)
	# check if player collision is inside the event
	if area.name == "Area2D":
		is_inside == true
		pass
	
	pass # Replace with function body.
