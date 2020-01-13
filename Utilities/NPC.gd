extends Node2D

export var random_movement = true
export var trainer = false
export var texture: StreamTexture = null

export var facing = ""

var move_direction = Vector2()
var foot = 0
var moving = false

func _ready():
	$Position2D/Sprite.texture = texture
	set_idle_frame(facing)


func _process(delta):
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

func move(_dir):
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
	$Tween.interpolate_property($Position2D, "position", - move_direction, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	position += move_direction
	$Position2D.position -= move_direction
	
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
	set_process(true)

func animate(_dir):
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
