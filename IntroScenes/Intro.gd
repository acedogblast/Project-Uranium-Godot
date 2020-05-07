extends Node

#Calls the animation player when it enters the scene
onready var animplayer = $AnimationPlayer

func _ready():
	#Play Intro Animation
	$AudioStreamPlayer.play()
	animplayer.play("IntroAnimation")
	pass

#Checks every frame for accept being pressed, and switches to the menu scene when it is
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		changeScene("res://IntroScenes/Menu.tscn")
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	
	#Sets all of the animations to be invisible besides pokemon showcase
	$Pokemon/Battle.visible = false
	$Pokemon/Curie.visible = false
	$Pokemon/Uranye.visible = false
	$Pokemon/Pokemon_Showcase.visible = true
	
	#Plays pokemon showcase
	$Pokemon/Pokemon_Showcase/AnimationPlayer.play("Pokemon")
	
	#Creates a timer and waits 11 seconds to stop the animation player
	yield(get_tree().create_timer(11), "timeout")
	$Pokemon/Pokemon_Showcase/AnimationPlayer.stop()
	
	#Sets pokemon showcase to invisible, and sets pokemon battle to visible
	$Pokemon/Pokemon_Showcase.visible = false
	$Pokemon/Battle/AnimationPlayer.play("Showcase")
	$Pokemon/Battle.visible = true
	#yield(get_tree().create_timer(0.6), "timeout")
	
	#Plays the battle animations for the starters
	$Pokemon/Battle/Orchynx/Orchynx_anim.play("Orchynx")
	$Pokemon/Battle/Eletux/Eletux_anim.play("Eletux")
	$Pokemon/Battle/Raptorch/Raptorch_anim.play("Raptorch")
	
	#Waits until the pokemon battle animation has finished, then goes to the next line
	yield($Pokemon/Battle/AnimationPlayer, "animation_finished")
	
	#Sets the pokemon battle animation to invisible, and sets the Curie animation to visible
	$Pokemon/Battle.visible = false
	$Pokemon/Curie.visible = true
	
	#Plays the Curie animation
	$Pokemon/Curie/AnimationPlayer.play("Curie")
	
	#Waits until the Curie animation has finished, then goes to the next line
	yield($Pokemon/Curie/AnimationPlayer, "animation_finished")
	
	#Sets pokemon Curie animation to invisible, and the Uranye animation to visible
	$Pokemon/Curie.visible = false
	$Pokemon/Uranye.visible = true
	
	#Plays the Uranye animation and the Uranye sprite animation
	$Pokemon/Uranye/AnimationPlayer.play("Uranye")
	$Pokemon/Uranye/Uranye_Sprite/AnimationPlayer.play("Uranye_Sprite")
	
	#Waits until the Uranye animation has finished, then goes to the next line
	yield($Pokemon/Uranye/AnimationPlayer, "animation_finished")
	
	#Changes the scene to the menu scene
	changeScene("res://IntroScenes/Menu.tscn")
	
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass
