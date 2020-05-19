extends Node2D

export var random_movement = false
export var trainer = false
export var texture: StreamTexture = null

export(String, "Down", "Up", "Left", "Right") var facing = "Up"


var move_direction = Vector2()
var foot = 0
var moving = false

signal done_movement
signal step
signal alert_done

func _ready():
	$Alert.visible = false
	$Position2D/Sprite.texture = texture
	set_idle_frame(facing)
	if texture == null:
		print("ERROR: No texture applied to NPC")

func _process(_delta):
	if !moving:
		if random_movement:
			var rand = randi()%7 + 1
			match rand:
				1:
					move("Down")
				2:
					move("Up")
				3:
					move("Left")
				4:
					move("Right")
				5:
					yield(get_tree().create_timer(0.8), "timeout")
				6:
					yield(get_tree().create_timer(0.4), "timeout")

func move(_dir): # Walk one step
	set_process(false)
	moving = true
	move_direction = Vector2.ZERO
	
	match _dir:
		"Down":
			move_direction.y = 32
		"Up":
			move_direction.y = -32
		"Left":
			move_direction.x = -32
		"Right":
			move_direction.x = 32
	
	animate(_dir)
	$Tween.interpolate_property(self, "position", self.position, self.position + move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.interpolate_property($Position2D, "position", - move_direction, Vector2(), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#position += move_direction
	#$Position2D.position -= move_direction
	
	$Tween.start()
	
	yield($AnimationPlayer, "animation_finished")
	match _dir:
		"Down":
			$Position2D/Sprite.frame = 0
		"Up":
			$Position2D/Sprite.frame = 12
		"Left":
			$Position2D/Sprite.frame = 4
		"Right":
			$Position2D/Sprite.frame = 8
	
	if foot == 0:
		foot = 1
	else:
		foot = 0
	moving = false
	#$Position2D.position = Vector2(0, -16)
	set_process(true)
	emit_signal("step")

func animate(_dir):
	#$AnimationPlayer.playback_speed = 2.0
	if foot == 0:
		match _dir:
			"Down":
				$AnimationPlayer.play("Down")
			"Up":
				$AnimationPlayer.play("Up")
			"Left":
				$AnimationPlayer.play("Left")
			"Right":
				$AnimationPlayer.play("Right")
	elif foot == 1:
		match _dir:
			"Down":
				$AnimationPlayer.play("Down2")
			"Up":
				$AnimationPlayer.play("Up2")
			"Left":
				$AnimationPlayer.play("Left2")
			"Right":
				$AnimationPlayer.play("Right2")

func set_idle_frame(_dir):
	match _dir:
		"Down":
			$Position2D/Sprite.frame = 0
		"Up":
			$Position2D/Sprite.frame = 12
		"Left":
			$Position2D/Sprite.frame = 4
		"Right":
			$Position2D/Sprite.frame = 8
		_:
			$Position2D/Sprite.frame = 0

func face_player(player_direction):
	var dir
	match player_direction:
		Global.game.player.DIRECTION.DOWN:
			dir = "Up"
		Global.game.player.DIRECTION.UP:
			dir = "Down"
		Global.game.player.DIRECTION.LEFT:
			dir = "Right"
		Global.game.player.DIRECTION.RIGHT:
			dir = "Left"
	set_idle_frame(dir)

func move_multi(dir, steps):
	for i in range(steps):
		move(dir)
		yield(self, "step")
	emit_signal("done_movement")

func alert():
	$Alert.visible = true
	$Alert/AnimationPlayer.play("Alert")
	yield($Alert/AnimationPlayer, "animation_finished")
	$Alert.visible = false
	$Alert/AnimationPlayer.seek(0.0, true)
	emit_signal("alert_done")
func jump():
	$AnimationPlayer.play("Jump")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("done_movement")
