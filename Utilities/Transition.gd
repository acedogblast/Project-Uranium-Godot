extends Node2D

@onready var anim = $AnimationPlayer

signal finished

func fade_to_color():
	visible = true
	anim.play("fade_in")
	await anim.animation_finished
	emit_signal("finished")

func fade_from_color():
	anim.play("fade_out")
	await anim.animation_finished
	visible = false
	emit_signal("finished")
