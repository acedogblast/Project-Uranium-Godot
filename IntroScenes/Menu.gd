extends Node

var enableSkip = false

#Plays the menu start animation as soon as the scene is ready
func _ready():
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
	
func _process(delta):
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
		get_tree().change_scene(scene)
	pass
