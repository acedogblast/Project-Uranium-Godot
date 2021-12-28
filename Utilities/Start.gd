extends Node2D

#Checks if the OS is android or ios, and if it is it makes the window unable to be resized and keeps the aspec ratio
func _ready() -> void:
	var force_touchscreen_controls = false

	for argument in OS.get_cmdline_args():
		if argument.find("-force_touchscreen_controls") > -1:
			force_touchscreen_controls = true
			break
			

	if OS.get_name() == "Android" || OS.get_name() == "iOS" || force_touchscreen_controls:
		Global.isMobile = true
		OS.window_resizable = false
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, OS.get_real_window_size())
		
		#Sets up the mobile controls
		get_tree().change_scene("res://Utilities/MobileControls.tscn")
	
	#If the above is false sets the window to be resizeable, and loads the intro scene
	else:
		Global.isMobile = false
		OS.window_resizable = true
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP, Vector2(512, 384))
		get_tree().change_scene("res://IntroScenes/Intro.tscn")
