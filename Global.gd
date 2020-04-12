extends Node
var TrainerName = "TrainerName"
var TrainerGender = 0 # 0 is boy, 1 is neutral, 2 is girl
var TrainerX = 192
var TrainerY = 144
var badges = 0
var time = 0

var printFPS = false
var size
var sprint = false
var game : Node

var can_run = false

var pokemon_group = [] # Cannot be more that 6

var past_events = [] # All events that had occured

var isMobile = false
func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("toggle_fps"):
		printFPS = true
	if printFPS == true:
		print(Engine.get_frames_per_second())
	pass