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

var holding_z = false

var move_direction = Vector2()

var action
var direction
var movement_type = MOVEMENT_TYPE.FOOT
var movement_speed
var state


#signal step
signal step
signal door_check
signal done_movement

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

#Calls the load_texture method
func _ready():
	self.add_to_group("auto_z_layering")# Maybe removed due to grass effect?
	load_texture()
 
func _process(_delta):
	#If the hero is not moving
	if !isMoving:
		#If the hero can move and is not pressing accept, then get input
		if canMove and !Input.is_action_pressed("ui_accept"):
			get_input()
		#If the hero can move and presses accept, then call the interact method
		elif canMove and Input.is_action_just_pressed("ui_accept"):
			interact()

func change_input(): # Disables/Enables the player to interaction and now movement
	call_deferred("change_internal_input")	

func change_internal_input():
	#Enables the CollisionShape2D, enables input if disabled, makes the hero unable to move if they are able to, and calls the set_idle_frame method
	$Collision/Area2D/CollisionShape2D.disabled = !$Collision/Area2D/CollisionShape2D.disabled
	#get_tree().paused = !get_tree().paused
	inputDisabled = !inputDisabled
	canMove = !canMove
	set_idle_frame()
#Sets the direction based on the input and sets the state to STATE.MOVE
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
		return
	#if the player presses z and is not holding z and can run, then set holding_z to be true and global sprint to false
	if Input.is_action_pressed("z") and !holding_z and Global.can_run:
		holding_z = true
		Global.sprint = !Global.sprint
	#If the above is false and z is not pressed and holding_z is true, then holding_z is flase and global sprint is set to flase
	elif !Input.is_action_pressed("z") and holding_z:
		holding_z = false
		Global.sprint = !Global.sprint
	
	state = STATE.MOVE
	
	#If the state equals STATE.MOVE, the player is on foot and global sprint is on, then movement speed is set to fast and the texture is set to run
	if state == STATE.MOVE and movement_type == MOVEMENT_TYPE.FOOT and Global.sprint == true:
		movement_speed = MOVEMENT_SPEED.FAST
		$Position2D/Sprite.texture = runTexture
	#If the above is false, then movemnet speed is set to normal and the walk texture is used
	else:
		movement_speed = MOVEMENT_SPEED.NORMAL
		$Position2D/Sprite.texture = walkTexture


	# Check if door is ahead
	var ahead
	match direction:
		DIRECTION.UP:
			ahead = position + Vector2(0, -32)
		DIRECTION.DOWN:
			ahead = position + Vector2(0, 32)
		DIRECTION.LEFT:
			ahead = position + Vector2(-32, 0)
		DIRECTION.RIGHT:
			ahead = position + Vector2(32, 0)
	var is_door_ahead = false
	for door in get_tree().get_nodes_in_group("Doors"):
		if door.position.x == ahead.x && (door.position.y >= ahead.y - 4 && door.position.y <= ahead.y + 4):
			is_door_ahead = true
			#print("door is ahead")
			door.transition()
			break
	
	#If input is disabled then you cannot move
	if !inputDisabled:
		move(false)

func interact():
	#Set check_x and check_y to the player node's position.x and position.y
	check_x = self.position.x
	check_y = self.position.y
	
	#If the direction is zero, then add 16 to check_x and 32 to check_y
	if direction == 0:
		check_x += 16
		check_y += 32
	#If the direction is 3, then subtract 16 from check_x and 32 from check_y
	if direction == 3:
		check_x -= 16
		check_y -= 32
	#If the direction is 1, then subtract 48 from check_x
	if direction == 1:
		check_x -= 48
	#If the direction is 2 then add 16 to check_x
	if direction == 2:
		check_x += 16
	#Set check_pos.x and check_pos.y to check_x and check_y respectively
	check_pos.x = check_x
	check_pos.y = check_y
	
	#Print the position and facing direction of the player
	#print("Player: " + str(self.position))
	#print("Looking: " + str(check_pos))
	
	#Get the parent node and check the position and direction
	get_parent().interaction(check_pos, direction)

func move(force_move : bool):
	set_process(false)
	move_direction = Vector2.ZERO
	
	if direction == DIRECTION.DOWN and ($NextCollision/Down.get_overlapping_bodies().size() == 0 or force_move):
			move_direction.y = 32
	if direction == DIRECTION.UP and ($NextCollision/Up.get_overlapping_bodies().size() == 0 or force_move):
			move_direction.y = -32
	if direction == DIRECTION.LEFT and ($NextCollision/Left.get_overlapping_bodies().size() == 0 or force_move):
			move_direction.x = -32
	if direction == DIRECTION.RIGHT and ($NextCollision/Right.get_overlapping_bodies().size() == 0 or force_move):
			move_direction.x = 32
	if direction == DIRECTION.DOWN_LEFT:
		move_direction.x = -32
		move_direction.y = 32
	if direction == DIRECTION.UP_RIGHT:
		move_direction.x = 32
		move_direction.y = -32
	
	# Grass logic
	var entering_grass = false
	var exiting_grass = false
	var grass1 = $Grass/Sprite # Current grass under player
	var grass2 = $Grass/Sprite2 # Grass player is moving to
	var grass_tween = $GrassTween

	Global.onGrass = false
	for pos in Global.grass_positions:
		if Global.game.player.position + move_direction == pos:
			if Global.onGrass == false: # Transision into grass
				entering_grass = true
				Global.onGrass = true
				break


	set_grass()
	remove_grass() # check if player walks out of grass

	# Start Animation
	animate()
	
	# Set Tween settings
	if movement_speed == MOVEMENT_SPEED.FAST:
		$Tween.interpolate_property(self, "position", self.position, self.position + move_direction, 0.125, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		$Tween.interpolate_property(self, "position", self.position, self.position + move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	
	
	# Play bump effect is player can't move
	if move_direction == Vector2.ZERO:
		$AudioStreamPlayer2D.play(0.0)
	
	# Start Tween
	$Tween.start()
	$GrassTween.start()

	# Wait until player finish move
	yield($Tween, "tween_all_completed")
	
	if foot == 0:
		foot = 1
	else:
		foot = 0

	set_idle_frame()
	set_process(true)
	emit_signal("step")

#Loads the texture of the sprites you picked for your character
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
	
#Sets the sprite texture to the walkTexture and if the direction is not null then the sprite.frame is set to direction times 4
func set_idle_frame(_dir = null):
	state = STATE.IDLE
	$Position2D/Sprite.texture = walkTexture
	if _dir == null:
		$Position2D/Sprite.frame = direction * 4
	else:
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

func animate():
	#If the sprite texture is the walk texture
	if $Position2D/Sprite.texture == walkTexture:
		#If the above is true and foot is equal to 0, then play the animation based on the direction the player is facing
		if foot == 0:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right")
		#If the above is false and foot is equal to 1, then play the second animation based on the player's direction
		elif foot == 1:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down2")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up2")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left2")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right2")
	#If the sprite texture is not set to the walk texture and is set to the run texture
	elif $Position2D/Sprite.texture == runTexture:
		#If the above it true and foot is equal to 0, then play the animation based on the direction the character is facing
		if foot == 0:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down_sprint")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up_sprint")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left_sprint")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right_sprint")
		#If the above is false and the foot is equal to 1, then play the second animaiton based on the player's direction
		elif foot == 1:
			if direction == DIRECTION.DOWN:
				$AnimationPlayer.play("Down_sprint2")
			elif direction == DIRECTION.UP:
				$AnimationPlayer.play("Up_sprint2")
			elif direction == DIRECTION.LEFT:
				$AnimationPlayer.play("Left_sprint2")
			elif direction == DIRECTION.RIGHT:
				$AnimationPlayer.play("Right_sprint2")
#This method, does indeed, stop the tween
func stop_tween():
	$Tween.stop_all()

#Sets the texture to the walk texture, and if the pacing direction isn't null then set the frame to be the facing_dir * 4
func set_facing_direction(facing_dir):
	$Position2D/Sprite.texture = walkTexture
	if facing_dir != null:
		$Position2D/Sprite.frame = facing_dir * 4

func move_player_event(dir, steps): # Force moves player to direction and steps
	direction = dir
	steps = steps
	movement_speed = MOVEMENT_SPEED.NORMAL
	for i in range(steps):
		move(true)
		yield(self, "step")
	emit_signal("done_movement")

func set_grass():
	if !Global.onGrass:
		Global.exitGrassPos = ""
		if Global.grassPos != null:
			if Global.grassPos != "":
				match Global.grassPos:
					"Right":
						if direction == DIRECTION.RIGHT:
							Global.onGrass = true
							Global.exitGrassPos = ""
							$Grass.show()
							$Grass/Sprite.hide()
							$Grass/Sprite2.show()
							$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
						else:
							Global.grassPos = ""
							Global.onGrass = false
						return
					"Left":
						if direction == DIRECTION.LEFT:
							Global.onGrass = true
							Global.exitGrassPos = ""
							$Grass.show()
							$Grass/Sprite2.hide()
							$Grass/Sprite.show()
							
							$Grass.position = Vector2(-32, 0)
							$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
						else:
							Global.grassPos = ""
							Global.onGrass = false
						return
					"Up":
						if direction == DIRECTION.UP:
							Global.onGrass = true
						else:
							Global.grassPos = ""
							Global.onGrass = false
					"Down":
						if direction == DIRECTION.DOWN:
							Global.onGrass = true
						else:
							Global.grassPos = ""
							Global.onGrass = false
	
	if Global.onGrass:
		$Grass.show()
		if direction == DIRECTION.RIGHT:
			$Grass/Sprite.show()
			$Grass/Sprite2.show()
			$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif direction == DIRECTION.LEFT:
			$Grass/Sprite.show()
			$Grass/Sprite2.show()
			$Grass.position = Vector2(-32, 0)
			$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif direction == DIRECTION.DOWN:
			$GrassTween.interpolate_property($Grass/Sprite, "region_rect", Rect2(Vector2(32, 80 - 32), Vector2(32, 16)), Rect2(Vector2(32, 80), Vector2(32, 16)), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif direction == DIRECTION.UP:
			$GrassTween.interpolate_property($Grass/Sprite, "region_rect", Rect2(Vector2(32, 80), Vector2(32, 16)), Rect2(Vector2(32, 80 - 32), Vector2(32, 16)), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		$Grass.hide()
	pass

func remove_grass():
	if Global.onGrass:
		match Global.exitGrassPos:
			"Right":
				if direction == DIRECTION.RIGHT:
					Global.onGrass = false
					Global.exitGrassPos = ""
					Global.grassPos = ""
					$Grass/Sprite2.hide()
					#$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					return
				else:
					Global.grassPos = ""
					Global.onGrass = true
			"Left":
				if direction == DIRECTION.LEFT:
					Global.exitGrassPos = ""
					Global.grassPos = ""
					Global.onGrass = false
					$Grass/Sprite.hide()
					$Grass/Sprite2.show()
					return
					#$GrassTween.interpolate_property($Grass, "position", $Grass.position, $Grass.position - move_direction, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
					#return
				else:
					Global.grassPos = ""
					Global.onGrass = true
				return
