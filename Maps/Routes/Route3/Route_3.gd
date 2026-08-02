extends Node2D
var map_px_size = Vector2(4160, 2112)
var edge_connections = [["W", "res://Maps/MokiTown/Moki_Town.tscn", 832, 2288, 2048]]

#onready var next_scene1 = preload("res://Maps/MokiTown/MokiTown.tscn")
#var offset = Vector2(2272,26*32)

var background_music = "res://Audio/BGM/PU-Route_03.ogg";
var type = "Outside"
var place_name = "Route 03"
var grass_pos = []

# Wild encounters — generated 1:1 from the official encounters.dat (map 59, Land slots aggregated)
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[32,  30,   9,           10], # Mankey
	[40,  30,   9,           10], # Smore
	[35,  20,   9,           10], # Owten
	[29,  14,   9,           11], # Feleng
	[37,   5,   9,           11], # Lotad
	[71,   1,   9,           11]  # Buizel
]

func _ready():
	pass

func get_grass_cells():
	return get_node("Tile Layer 1/Grass").get_used_cells(0)