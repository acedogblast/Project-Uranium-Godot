extends Node2D

#onready var next_scene1 = preload("res://Maps/MokiTown/MokiTown.tscn")
var offset = Vector2(2272,26*32)

var type = "Outdoor"
var place_name = "Route 03"

func _ready():
	$Layer2/Wild_Grass/GrassCheck.connect("area_entered", get_tree().get_root().get_child(4), "enter_grass")
	$Layer2/Wild_Grass/GrassCheck.connect("area_exited", get_tree().get_root().get_child(4), "exit_grass")

