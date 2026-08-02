extends Node2D
var map_px_size = Vector2(1600, 1600)
var edge_connections = [["N", "res://Maps/Routes/Route2/Route_2.tscn", -352, 1808, 1344]]

var adjacent_scenes = [
	["res://Maps/Routes/Route2/Route_2.tscn", Vector2(352, -1824)]
]

var background_music = "res://Audio/BGM/PU-Kevlar_Town.ogg";

var type = "Outside"
var place_name = "Kevlar Town"
var heal_point = Vector2(656,432)

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	
	pass