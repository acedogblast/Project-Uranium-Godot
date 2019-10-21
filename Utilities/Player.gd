extends Node

var walkTexture = null
var runTexture = null

export var canMove = true
var canRun = true
var isMoving = false
var canTurn = true
var facing = DOWN

var action = null
const STILL = 0
const WALK = 1
const RUN = 2
const BIKE = 3
const FISH = 4
const SURF = 5
const SURFBOARD = 6
const SCUBA = 7

var direction = null
const DOWN = 0
const LEFT = 1
const RIGHT = 2
const UP = 3

func _ready():
	#Camera2D.current = true
	if Global.TrainerGender == 0:
		walkTexture = preload("res://Graphics/Characters/HERO.png")
		runTexture = preload("res://Graphics/Characters/HERO-RUN.png")
		$Sprite.texture = walkTexture
		$Sprite.frame = 0
	if Global.TrainerGender == 1:
		walkTexture = preload("res://Graphics/Characters/PU-Pluto.png")
		runTexture = preload("res://Graphics/Characters/PU-PlutoRun.png")
		$Sprite.texture = walkTexture
		$Sprite.frame = 0
	if Global.TrainerGender == 2:
		walkTexture = preload("res://Graphics/Characters/HEROINE.png")
		runTexture = preload("res://Graphics/Characters/HEROINE-RUN.png")
		$Sprite.texture = walkTexture
		$Sprite.frame = 0
	$AudioStreamPlayer/Timer.start()
	pass

func _process(delta):
	if !isMoving:
		if Input.is_action_pressed("ui_down") and canMove and !Input.is_action_pressed("z"):
			direction = DOWN
			action = WALK
		elif Input.is_action_pressed("ui_up") and canMove and !Input.is_action_pressed("z"):
			direction = UP
			action = WALK
		elif Input.is_action_pressed("ui_left") and canMove and !Input.is_action_pressed("z"):
			direction = LEFT
			action = WALK
		elif Input.is_action_pressed("ui_right") and canMove and !Input.is_action_pressed("z"):
			direction = RIGHT
			action = WALK
	else:
		action = STILL
	
	if Input.is_action_just_pressed("ui_accept") and canMove:
		interact()
	if !checkIfBlocked():
		#$AudioStreamPlayer/Timer.stop()
		Update()
	else:
		$AnimationPlayer.stop()
		if direction == UP:
			$Sprite.frame = 12
		if direction == DOWN:
			$Sprite.frame = 0
		if direction == LEFT:
			$Sprite.frame = 4
		if direction == RIGHT:
			$Sprite.frame = 8
		#$AudioStreamPlayer/Timer.start()
	pass
func Update(): #Gets called every frame
	if isMoving:
		return 0
	if action == STILL:
		#canTurn = true
		$AnimationPlayer.stop()
		if direction == UP:
			$Sprite.frame = 12
		if direction == DOWN:
			$Sprite.frame = 0
		if direction == LEFT:
			$Sprite.frame = 4
		if direction == RIGHT:
			$Sprite.frame = 8
		pass
	elif action == WALK:
		if direction == UP:
			$Sprite.texture = walkTexture
			if !$AnimationPlayer.is_playing() or $AnimationPlayer.current_animation != "Up":
				$AnimationPlayer.play("Up")
		if direction == DOWN:
			$Sprite.texture = walkTexture
			if !$AnimationPlayer.is_playing() or $AnimationPlayer.current_animation != "Down":
				$AnimationPlayer.play("Down")
		if direction == LEFT:
			$Sprite.texture = walkTexture
			if !$AnimationPlayer.is_playing() or $AnimationPlayer.current_animation != "Left":
				$AnimationPlayer.play("Left")
		if direction == RIGHT:
			$Sprite.texture = walkTexture
			if !$AnimationPlayer.is_playing() or $AnimationPlayer.current_animation != "Right":
				$AnimationPlayer.play("Right")
		Move()
	pass
#func Turn():
#	print("Turned")
#	isMoving = true
#	if direction == UP:
#		$Sprite.frame = 12
#	if direction == DOWN:
#		$Sprite.frame = 0
#	if direction == LEFT:
#		$Sprite.frame = 4
#	if direction == RIGHT:
#		$Sprite.frame = 8
#	$TruningTimer.start()
#	pass
func interact():
	if $InteractRayDown.is_colliding() and direction == DOWN:
		var collider = $InteractRayDown.get_collider()
		getMapInteration(collider)
	elif $InteractRayLeft.is_colliding() and direction == LEFT:
		var collider = $InteractRayLeft.get_collider()
		getMapInteration(collider)
	elif $InteractRayRight.is_colliding() and direction == RIGHT:
		var collider = $InteractRayRight.get_collider()
		getMapInteration(collider)
	elif $InteractRayUp.is_colliding() and direction == UP:
		var collider = $InteractRayUp.get_collider()
		getMapInteration(collider)
	pass
func getMapInteration(collider):
	get_parent().interaction(collider)
	pass
func Move():
	#print($AnimationPlayer.current_animation)
	isMoving = true
	var V2Direction = Vector2()
	if direction == UP:
		V2Direction = Vector2(0, -32)
	elif direction == DOWN:
		V2Direction = Vector2(0, 32)
	elif direction == LEFT:
		V2Direction = Vector2(-32, 0)
	elif direction == RIGHT:
		V2Direction = Vector2(32, 0)
	$MoveTween.interpolate_property(self, "position", self.position,
		self.position + V2Direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$MoveTween.start()
	pass

func checkIfBlocked():
	if direction == UP:
		return $RayCastUp.is_colliding()
	if direction == DOWN:
		return $RayCastDown.is_colliding()
	if direction == LEFT:
		return $RayCastLeft.is_colliding()
	if direction == RIGHT:
		return $RayCastRight.is_colliding()
	pass
func _on_MoveTween_tween_completed(object, key):
	isMoving = false
	pass
func freezePlayer():
	canMove = false
func freePlayer():
	canMove = true
func _on_Timer_timeout():
	if checkIfBlocked() and action == WALK:
		$AudioStreamPlayer.play()
		action = STILL

