extends Node2D

func _ready() -> void:
	if OS.get_name() == "Android" || OS.get_name() == "iOS":
		OS.window_resizable = false
		OS.window_fullscreen = true
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP_HEIGHT, OS.get_real_window_size())
		Global.size = OS.get_real_window_size()
		print_debug(Global.size)
		get_tree().change_scene("res://Utilities/MobileControls.tscn")
	else:
		OS.window_resizable = true
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(512, 384))

		get_tree().change_scene("res://IntroScenes/Intro.tscn")