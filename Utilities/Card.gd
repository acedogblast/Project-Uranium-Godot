extends Node2D

var mode = 0

signal close

func _input(event):
	if mode == 1 && event.is_action_pressed("x"):
		emit_signal("close")
		mode = 0
func setup():
	mode = 1

	match Global.TrainerGender:
		0:
			$Pic.texture = load("res://Graphics/Characters/trainer000.PNG")
		1:
			$Pic.texture = load("res://Graphics/Characters/trainer009.PNG")
		2:
			$Pic.texture = load("res://Graphics/Characters/trainer001.PNG")

	$Text/Name.text = "NAME: " + Global.TrainerName
	$Text/Money/number.text = "[right]$" + str(Global.money) + "[/right]"
	$Text/Pokedex/number.text = "[right]" + str(Global.pokedex_caught.size()) + "[/right]"

	#warning-ignore:INTEGER_DIVISION
	var hours : int = Global.time / 60
	$Text/Time/number.text = "[right]" + str("%02d" % hours) + ":" + str("%02d" % (Global.time % 60)) + "[/right]"

	# TODO check if player has badges.