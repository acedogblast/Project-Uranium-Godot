extends Node
var TrainerName = "TrainerName"
var TrainerGender = 1 # 0 is boy, 1 is neutral, 2 is girl
var TrainerX = 192
var TrainerY = 144
var printFPS = false

var pokemon_group = [] # Cannot be more that 6

var isMobile = false
func _process(delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("toggle_fps"):
		printFPS = true
	if printFPS == true:
		print(Engine.get_frames_per_second())
	pass