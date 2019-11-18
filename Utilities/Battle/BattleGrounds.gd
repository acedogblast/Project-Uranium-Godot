extends Node2D
signal wait
signal ball_flash
signal unveil_finished
enum BattlePositions {INTRO_FADE, PLAYER_TOSS, CENTER, CENTER_IDLE, FOE_FOCUS, OPONENT_TALK}

var is_first_toss = true

func setPosistion(pos):
	var aniplayer = $AnimationPlayer
	match pos:
		BattlePositions.INTRO_FADE:
			aniplayer.play("FadeToIntroPos")
		BattlePositions.PLAYER_TOSS:
			aniplayer.play("player_toss")
			get_parent().get_parent().get_node("CanvasLayer/BattleInterfaceLayer/PlayerToss/AnimationPlayer").play("FadeIn")
		BattlePositions.CENTER:
			aniplayer.play("PlayerTossToCenter")
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
	yield($FoeBase/Battler/AnimationPlayer, "animation_finished")
	
	emit_signal("unveil_finished")
func player_unveil():
	var PlayerBar = get_parent().get_parent().get_node("CanvasLayer/BattleInterfaceLayer/BattleBars/PlayerBar")
	# Slide Player bar
	PlayerBar.get_parent().visible = true
	PlayerBar.visible = true
	PlayerBar.get_node("AnimationPlayer").play("Slide")

	# Play toss animation
	if is_first_toss == true:
		get_parent().get_parent().get_node("CanvasLayer/BattleInterfaceLayer/PlayerToss/AnimationPlayer").play("Toss")
		# Add Delay
		var t = Timer.new()
		t.set_wait_time(0.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		is_first_toss = false
	# Play sound for toss
	$PlayerBase/Ball/AudioStreamPlayer.play()
	get_parent().get_parent().get_node("CanvasLayer/BattleGrounds/PlayerBase/Ball/AnimationPlayer").play("PlayerBallToss")
	yield(get_parent().get_parent().get_node("CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer"), "animation_finished")
	emit_signal("unveil_finished")
	pass