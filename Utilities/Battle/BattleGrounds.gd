extends Node2D
signal wait
signal ball_flash
signal unveil_finished
enum BattlePositions {INTRO_FADE, PLAYER_TOSS, CENTER, CENTER_IDLE, FOE_FOCUS, OPONENT_TALK}

func setPosistion(pos):
	var aniplayer = $AnimationPlayer
	match pos:
		BattlePositions.INTRO_FADE:
			aniplayer.play("FadeToIntroPos")
	yield(aniplayer, "animation_finished")
	emit_signal("wait")


func foe_unveil():
	var FoeBar = get_parent().get_parent().get_node("CanvasLayer/BattleInterfaceLayer/BattleBars/FoeBar")
	# Play sound for toss
	$FoeBase/Ball/AudioStreamPlayer.play()
	
	# Slide foe bar
	FoeBar.get_parent().visible = true
	FoeBar.visible = true
	FoeBar.get_node("AnimationPlayer").play("Slide")
	
	# Play toss animation
	$FoeBase/Ball.visible = true
	$FoeBase/Ball/AnimationPlayer.play("Ball")
	yield(self, "ball_flash")
	
	emit_signal("unveil_finished")
	pass