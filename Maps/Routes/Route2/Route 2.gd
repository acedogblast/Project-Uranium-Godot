extends Node2D

var adjacent_scenes = [
	["res://Maps/KevlarTown/Kevlar Town.tscn", Vector2(-352,1816)],
	["res://Maps/NowtochCity/Nowtoch City.tscn", Vector2(-480, -2368)]
]

var background_music = "res://Audio/BGM/PU-Route 01.ogg"; # Same as route 1 apparently

var type = "Outside"
var place_name = "Route 02"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
