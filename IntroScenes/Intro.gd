extends Node

onready var animplayer = $AnimationPlayer

func _ready():
	#Play Intro Animation
	$AudioStreamPlayer.play()
	animplayer.play("IntroAnimation")
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		changeScene("res://IntroScenes/Menu.tscn")
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	changeScene("rres://IntroScenes/Menu.tscn")
	
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass
