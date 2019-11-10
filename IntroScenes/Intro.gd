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
	
	$Pokemon/Battle.visible = false
	$Pokemon/Curie.visible = false
	$Pokemon/Uranye.visible = false
	$Pokemon/Pokemon_Showcase.visible = true
	$Pokemon/Pokemon_Showcase/AnimationPlayer.play("Pokemon")
	
	yield(get_tree().create_timer(11), "timeout")
	$Pokemon/Pokemon_Showcase/AnimationPlayer.stop()
	
	$Pokemon/Pokemon_Showcase.visible = false
	$Pokemon/Battle/AnimationPlayer.play("Showcase")
	$Pokemon/Battle.visible = true
	#yield(get_tree().create_timer(0.6), "timeout")
	$Pokemon/Battle/Orchynx/Orchynx_anim.play("Orchynx")
	$Pokemon/Battle/Eletux/Eletux_anim.play("Eletux")
	$Pokemon/Battle/Raptorch/Raptorch_anim.play("Raptorch")
	
	yield($Pokemon/Battle/AnimationPlayer, "animation_finished")
	
	$Pokemon/Battle.visible = false
	$Pokemon/Curie.visible = true
	
	$Pokemon/Curie/AnimationPlayer.play("Curie")
	
	yield($Pokemon/Curie/AnimationPlayer, "animation_finished")
	
	$Pokemon/Curie.visible = false
	$Pokemon/Uranye.visible = true
	
	$Pokemon/Uranye/AnimationPlayer.play("Uranye")
	$Pokemon/Uranye/Uranye_Sprite/AnimationPlayer.play("Uranye_Sprite")
	
	yield($Pokemon/Uranye/AnimationPlayer, "animation_finished")
	
	
	changeScene("res://IntroScenes/Menu.tscn")
	
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass
