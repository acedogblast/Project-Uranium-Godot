extends Node2D

onready var anim = $AnimationPlayer

func fade_to_color():
	visible = true
	anim.play("fade_in")
	yield(anim, "animation_finished")

func fade_from_color():
	anim.play("fade_out")
	yield(anim, "animation_finished")
	visible = false