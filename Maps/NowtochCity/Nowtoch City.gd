extends Node2D

var adjacent_scenes = [
	["res://Maps/Routes/Route2/Route 2.tscn", Vector2(480,2368)]
]

var background_music = "res://Audio/BGM/PU-Nowtoch City.ogg";

var type = "Outside"
var place_name = "Nowtoch City"


func _ready():
	update_NPCs()

func update_NPCs():
	if !Global.past_events.has("NOWTOCH_CITY_EVENT_1"):
		




		pass