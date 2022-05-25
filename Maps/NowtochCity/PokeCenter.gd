extends Node2D

var background_music = "res://Audio/BGM/PU-PokeCenter.ogg";

var type = "Indoors"
var place_name = "Pokecenter"
var reference

func _ready():
	reference = $PokeCenterReference

func interaction(check_pos, _direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == Vector2(240, 400):
		reference.heal()
		# Add new heal point
		Global.game.last_heal_point = "res://Maps/NowtochCity/Nowtoch City.tscn"