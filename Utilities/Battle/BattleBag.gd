extends Node2D

var enabled = false

func _ready():
	pass # Replace with function body.

func start():
	enabled = true
	self.visible = true
	# Slide
	$AnimationPlayer.play("SlideBag")

func _input(event):
	if enabled:
		if event.is_action_pressed("x"):
			enabled = false
			self.visible = false
			# Close menu and go back
			$AnimationPlayer.play_backwards("SlideBag")
			yield($AnimationPlayer, "animation_finished")
			self.get_parent().get_node("BattleComandSelect").enabled = true
			self.get_parent().get_node("BattleComandSelect").visible = true
