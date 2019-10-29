extends Node2D

func _ready():
	if OS.get_name() == "Android" || OS.get_name() == "iOS":
		OS.window_resizable = false
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 384))
		
		get_tree().change_scene("res://Utilities/MobileControls.tscn")
	else:
		OS.window_resizable = true
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, Vector2(512, 384))
		get_tree().change_scene("res://IntroScenes/Intro.tscn")