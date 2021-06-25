extends Node2D

#onready var next_scene1 = preload("res://Maps/MokiTown/MokiTown.tscn")
#var offset = Vector2(2272,26*32)

var background_music = "res://Audio/BGM/PU-Route 03.ogg";
var type = "Outside"
var place_name = "Route 03"
var grass_pos = []

func _ready():
	pass

func get_grass_cells():
	return get_node("Tile Layer 1/Grass").get_used_cells()