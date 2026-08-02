extends Node

var enableSkip = false

#Plays the menu start animation as soon as the scene is ready
func _ready():
	Global.localize_textures(self)
	$AnimationPlayer.play("MenuStart")
	pass

#Plays the movetiles animation
func StartMovingTiles():
	$AnimationPlayer2.play("MoveTiles")
	pass

#Playes the Glowing animation
func StartBreathing():
	$AnimationPlayer3.play("Glowing")
	pass
	
var _para_base := {}
func _mouse_parallax():
	# The logo follows the mouse slightly, like the original title screen
	var center = get_viewport().get_visible_rect().size / 2.0
	var offset = (get_viewport().get_mouse_position() - center) / center
	offset.x = clampf(offset.x, -1.0, 1.0)
	offset.y = clampf(offset.y, -1.0, 1.0)
	for nm in ["PokemonIcon", "UraniumIcon", "PokemonIconOutline"]:
		var node = get_node_or_null(nm)
		if node == null:
			continue
		if not _para_base.has(nm):
			_para_base[nm] = node.position
		var depth = 6.0 if nm == "PokemonIcon" else 3.0
		if $AnimationPlayer.is_playing():
			_para_base.erase(nm)  # laisser l'animation piloter, rebaser après
		else:
			node.position = _para_base[nm] + offset * depth

func _process(delta):
	_mouse_parallax()
	#If accept is pressed and skip is enabled then go to the next line
	if Input.is_action_just_pressed("ui_accept") and enableSkip:
		#If the animation player is playing then call the SaveMenu method
		if $AnimationPlayer.is_playing():
			SaveMenu()
		#If the above is false then play the NextScreenFadeOut animation
		else:
			$AnimationPlayer.play("NextScreenFadeOut")
		pass
	pass
	
#Enables Skip
func EnableSkip():
	enableSkip = true
	pass
	
func Cry():
	$Fader3/AudioStreamPlayer.play()
	pass	
	
#Changes the scene to the save menu
func SaveMenu():
	changeScene("res://IntroScenes/SaveMenu.tscn")
	pass
	
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene_to_file(scene)
	pass
