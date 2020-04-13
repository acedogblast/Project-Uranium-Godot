extends Node2D

var next_scene1 = "res://Maps/Route03/Route03.tscn"

var background_music = "res://Audio/BGM/PU-Moki Town.ogg";

var type = "Outside"
var place_name = "Moki Town"

var hero_home_x = 880
var hero_home_y = 1008

func _ready():
    #next_scene1 = load("res://Maps/Route03/Route03.tscn")
    
    pass

func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y) # Not sure exactly why npcs have an ofset of 16.
	
	return null