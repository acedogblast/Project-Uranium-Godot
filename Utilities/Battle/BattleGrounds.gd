extends Node2D

enum BattlePositions {INTRO_FADE, PLAYER_TOSS, CENTER, CENTER_IDLE, FOE_FOCUS, OPONENT_TALK}


func setPosistion(pos):
	var aniplayer = $AnimationPlayer
	match pos:
		BattlePositions.INTRO_FADE:
			aniplayer.play("FadeToIntroPos")
	pass