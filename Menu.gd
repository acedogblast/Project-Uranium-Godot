extends Node
var enableSkip = false
func _ready():
	$AnimationPlayer.play("MenuStart")
	pass

func StartMovingTiles():
	$AnimationPlayer2.play("MoveTiles")
	pass
	
func StartBreathing():
	$AnimationPlayer3.play("Glowing")
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and enableSkip:
		if $AnimationPlayer.is_playing():
			SaveMenu()
		else:
			$AnimationPlayer.play("NextScreenFadeOut")
		pass
	pass
func EnableSkip():
	enableSkip = true
	pass
func Cry():
	$Fader3/AudioStreamPlayer.play()
	pass	
func SaveMenu():
	changeScene("res://SaveMenu.tscn")
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass