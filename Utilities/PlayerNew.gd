extends Node2D

var walkTexture = null
var runTexture = null

export var canMove = true
var isMoving = false
var facing = DIRECTION.DOWN
var inputDisabled = false
var foot = 0

var bump = false

var check_x = 0
var check_y = 0
var check_pos = Vector2()

var move_direction = Vector2()

var action
var direction
var movement_type = MOVEMENT_TYPE.FOOT
var movement_speed
var state

enum STATE {
	IDLE,
	MOVE,
	FISH
}
 
enum MOVEMENT_TYPE {
	FOOT,
	BIKE,
	SURF,
	SCUBA
}
       
enum MOVEMENT_SPEED {
	NORMAL,
	FAST
}

enum DIRECTION{
	DOWN,
	LEFT,
	RIGHT,
	UP,
	DOWN_LEFT,
	UP_RIGHT
}

func _ready():
	load_texture()

func _process(delta):
	if !isMoving:
		if canMove and !Input.is_action_pressed("z"):
			get_input()
		elif canMove and Input.is_action_just_pressed("z"):
			interact()

func disable_input():
	get_tree().paused = true
	inputDisabled = true

func enable_input():
	get_tree().paused = false
	inputDisabled = false

func get_input():
	if Input.is_action_pressed("ui_down"):
		direction = DIRECTION.DOWN
	elif Input.is_action_pressed("ui_up"):
		direction = DIRECTION.UP
	elif Input.is_action_pressed("ui_left"):
		direction = DIRECTION.LEFT
	elif Input.is_action_pressed("ui_right"):
		direction = DIRECTION.RIGHT
	else:
		state = STATE.IDLE
		set_idle_frame()
		return
	
	state = STATE.MOVE
	
	if state == STATE.MOVE and movement_type == MOVEMENT_TYPE.FOOT and Input.is_action_pressed("run"):
		movement_speed = MOVEMENT_SPEED.FAST
		$Position2D/Sprite.texture = runTexture
	else:
		movement_speed = MOVEMENT_SPEED.NORMAL
		$Position2D/Sprite.texture = walkTexture
	move()

func interact():
	check_x = self.position.x
	check_y = self.position.y
	
	if direction == 0:
		check_x += 16
		check_y += 32
	if direction == 3:
		check_x -= 16
		check_y -= 32
	if direction == 1:
		check_x -= 48
	if direction == 2:
		check_x += 16
	
	check_pos.x = check_x
	check_pos.y = check_y
	
	print(self.position)
	print(check_pos)
	
	get_parent().interaction(check_pos)


func move():
	set_process(false)
	inputDisabled = true
	move_direction = Vector2.ZERO
	
	if direction == DIRECTION.DOWN:
		move_direction.y = 32
	if direction == DIRECTION.UP:
		move_direction.y = -32
	if direction == DIRECTION.LEFT:
		move_direction.x = -32
	if direction == DIRECTION.RIGHT:
		move_direction.x = 32
	if direction == DIRECTION.DOWN_LEFT:
		move_direction.x = -32
		move_direction.y = 32
	if direction == DIRECTION.UP_RIGHT:
		move_direction.x = 32
		move_direction.y = -32
	
	
	# Start Animation
	animate()
	
	# Set Tween settings and position instantly
	$Tween.interpolate_property($Position2D, "position", - move_direction, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	position += move_direction
	$PreviousCollision.position -= move_direction
	$PreviousCollision/Area2D/CollisionShape2D.disabled = false
	$Position2D.position -= move_direction
	
	# Start Tween
	$Tween.start()
	
	# Wait Till animation finished
	yield($AnimationPlayer, "animation_finished")
	$PreviousCollision/Area2D/CollisionShape2D.disabled = true
	$PreviousCollision.position = $Position2D.position
	
	if foot == 0:
		foot = 1
	else:
		foot = 0
	
	inputDisabled = false
	set_process(true)

func load_texture():
	if Global.TrainerGender == 0:
		walkTexture = preload("res://Graphics/Characters/HERO.png")
		runTexture = preload("res://Graphics/Characters/HERO-RUN.png")
	if Global.TrainerGender == 1:
		walkTexture = preload("res://Graphics/Characters/PU-Pluto.png")
		runTexture = preload("res://Graphics/Characters/PU-PlutoRun.png")
	if Global.TrainerGender == 2:
		walkTexture = preload("res://Graphics/Characters/HEROINE.png")
		runTexture = preload("res://Graphics/Characters/HEROINE.png")
	$Position2D/Sprite.texture = walkTexture
	$Position2D/Sprite.frame = 0

func set_idle_frame():
	$Position2D/Sprite.texture = walkTexture
	if direction != null:
		$Position2D/Sprite.frame = direction * 4

func animate():
	if $Position2D/Sprite.texture == walkTexture:
		if foot == 0:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right")
		elif foot == 1:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down2")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up2")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left2")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right2")
	elif $Position2D/Sprite.texture == runTexture:
		if foot == 0:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down_sprint")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up_sprint")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left_sprint")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right_sprint")
		elif foot == 1:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down_sprint2")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up_sprint2")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left_sprint2")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right_sprint2")

func _on_Area2D_body_entered(body):
	bump = !bump
	collision()
	
	pass

func collision():
	if bump:
		disable_input()
		stop_tween()
		$PreviousCollision.position += move_direction
		position -= move_direction
		$Position2D.position = $Collision.position
		$AudioStreamPlayer2D.play(0.0)
		yield(get_tree().create_timer(0.3), "timeout")
		$PreviousCollision.position = $Collision.position
		enable_input()
		bump = false
	else:
		return

func stop_tween():
	$Tween.stop_all()

func movePrevious():
	disable_input()
	$PreviousCollision/Area2D/CollisionShape2D.disabled = true
	$PreviousCollision.position = $Collision.position
	$PreviousCollision/Area2D/CollisionShape2D.disabled = false
	pass

