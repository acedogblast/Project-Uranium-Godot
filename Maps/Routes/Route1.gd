extends Node2D


var next_scene1 = null

var background_music = "res://Audio/BGM/PU-Route 01.ogg";

var type = "Outside"
var place_name = "Route 01"


# Called when the node enters the scene tree for the first time.
func _ready():


	pass # Replace with function body.


func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	pass