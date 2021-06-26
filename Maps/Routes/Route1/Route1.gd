extends Node2D


var next_scene1 = null

var background_music = "res://Audio/BGM/PU-Route 01.ogg";

var type = "Outside"
var place_name = "Route 01"

# Wild Poke table
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[7,   40,   2,           3],
	[9,   30,   2,           3],
	[12,  30,   2,           3]
]

# Called when the node enters the scene tree for the first time.
func _ready():


	pass # Replace with function body.


func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	pass

func get_grass_cells():
	return get_node("Tile Layer 1/PU_autotiles").get_used_cells()