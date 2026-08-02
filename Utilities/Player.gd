extends Node2D

var walkTexture = null
var runTexture = null

@export var canMove = true
var isMoving = false
var last_facing_dir
var inputDisabled = false
var foot = 0

var bump = false

var check_x = 0
var check_y = 0
var check_pos = Vector2()

var holding_z = false

var move_direction = Vector2()
var stair_offset = Vector2.ZERO

var action
var direction
var movement_type = MOVEMENT_TYPE.FOOT
var movement_speed
var state

var found_grass = false
var entering_grass = false
var exiting_grass = false

var blocked = false
var do_jump = false

# Godot 4: Tweens are now created programmatically
var tween : Tween
var grass_tween : Tween

#signal step
signal step
signal done_movement
signal wild_battle
signal trainer_battle(npc_trainer)

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
	self.add_to_group("auto_z_layering")
	load_texture()
 
func _process(delta):
	#If the hero is not moving
	if !isMoving:
		#If the hero can move and is not pressing accept, then get input
		if canMove and !Input.is_action_pressed("ui_accept") and !isMoving:
			get_input()
		#If the hero can move and presses accept, then call the interact method
		elif canMove and Input.is_action_just_pressed("ui_accept"):
			interact()
			pass

func change_input(lock = false): # Disables/Enables the player to interaction and now movement
	if lock:
		$Collision/Area2D/CollisionShape2D.disabled = true
		inputDisabled = true
		canMove = false
	else:
		$Collision/Area2D/CollisionShape2D.disabled = false
		inputDisabled = false
		canMove = true
	set_idle_frame(direction)

func get_input():
	if Input.is_action_pressed("ui_down"):
		direction = DIRECTION.DOWN
	elif Input.is_action_pressed("ui_up"):
		direction = DIRECTION.UP
	elif Input.is_action_pressed("ui_left"):
		direction = DIRECTION.LEFT
	elif Input.is_action_pressed("ui_right"):
		direction = DIRECTION.RIGHT
	elif Input.is_action_pressed("ui_debug"):
		Global.debug = true
	else:
		Global.debug = false
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
		$Marker2D/Sprite2D.texture = runTexture
	#If the above is false, then movemnet speed is set to normal and the walk texture is used
	else:
		movement_speed = MOVEMENT_SPEED.NORMAL
		$Marker2D/Sprite2D.texture = walkTexture


	# Check if door is ahead
	var ahead
	match direction:
		DIRECTION.UP:
			ahead = get_position_relative_to_current_scene() + Vector2(0, -32)
		DIRECTION.DOWN:
			ahead = get_position_relative_to_current_scene() + Vector2(0, 32)
		DIRECTION.LEFT:
			ahead = get_position_relative_to_current_scene() + Vector2(-32, 0)
		DIRECTION.RIGHT:
			ahead = get_position_relative_to_current_scene() + Vector2(32, 0)
	var is_door_ahead = false

	for door in Global.game.doors:
		var door_pos = door.position
		
		if door_pos == ahead:
			is_door_ahead = true
			print("door is ahead")
			door.transition()
			return
	
	# Edge connections (connections.dat): walking off a connected edge transfers to the neighbor map
	var _cs = Global.game.current_scene
	if _cs != null and _cs.get("edge_connections") != null :
		var _sz: Vector2 = _cs.map_px_size
		for ec in _cs.edge_connections:
			var hit = false
			var newpos := Vector2.ZERO
			match ec[0]:
				"E":
					if direction == DIRECTION.RIGHT and ahead.x > _sz.x:
						hit = true
						newpos = Vector2(ec[3], ahead.y + ec[2])
				"W":
					if direction == DIRECTION.LEFT and ahead.x < 0:
						hit = true
						newpos = Vector2(ec[3], ahead.y + ec[2])
				"S":
					if direction == DIRECTION.DOWN and ahead.y > _sz.y:
						hit = true
						newpos = Vector2(ahead.x + ec[2], ec[3])
				"N":
					if direction == DIRECTION.UP and ahead.y < 0:
						hit = true
						newpos = Vector2(ahead.x + ec[2], ec[3])
			if hit:
				# Connection coverage: the mapped coordinate must land inside the destination
				var _axis = newpos.y if ec[0] in ["E", "W"] else newpos.x
				if _axis < 0 or _axis >= ec[4]:
					continue
				Global.game.lock_player()
				Global.game.door_transition(ec[1], newpos)
				return
	
	# Check if cliff is ahead
	var the_cliff = null
	for cliff in Global.game.cliffs:
		var cliff_positions = cliff.get_cliff_positions()
		if cliff_positions.has(ahead):
			the_cliff = cliff
			break
	do_jump = false
	blocked = false
	if the_cliff != null:
		match direction:
			DIRECTION.UP:
				if the_cliff.jump_direction == "Up":
					do_jump = true
			DIRECTION.DOWN:
				if the_cliff.jump_direction == "Down":
					do_jump = true
			DIRECTION.LEFT:
				if the_cliff.jump_direction == "Left":
					do_jump = true
			DIRECTION.RIGHT:
				if the_cliff.jump_direction == "Right":
					do_jump = true
		
		if do_jump:
			jump()
			return
		else:
			blocked = true

	#If input is disabled then you cannot move
	if !inputDisabled:
		move(false)


func check_grass(dir):
	for grass in get_tree().get_nodes_in_group("grass"):
		for collision in $NextCollision.get_children():
			for g in grass.get_used_cells_by_id(0):
				if collision.name == "Right":
					pass

				# Godot 4: tile_set.tile_size instead of cell_size
				var tile_center_pos = grass.map_to_local(g) + grass.tile_set.tile_size / 2
				if grass.map_to_local(g) == collision.global_position:
					if !Global.grassPos.has(collision.name):
						Global.grassPos.append(collision.name)
					found_grass = true
					break
				else:
					if Global.grassPos.has(collision.name):
						# Godot 4: remove_at() instead of remove()
						Global.grassPos.remove_at(Global.grassPos.find(collision.name))
		found_grass = false
	pass


func interact():
	var check = self.position
	match direction:
		DIRECTION.DOWN:
			check += Vector2(0, 32)
		DIRECTION.UP:
			check += Vector2(0, -32)
		DIRECTION.LEFT:
			check += Vector2(-32, 0)
		DIRECTION.RIGHT:
			check += Vector2(32, 0)
	print("Player.gd" + str(check))
	#Get the parent node and check the position and direction
	Global.game.interaction(check, direction)

func move(force_move : bool):
	set_process(false)
	isMoving = true
	move_direction = Vector2.ZERO

	var was_indoors = false
	if "type" in Global.game.current_scene && !Global.game.current_scene.type == "Outside":
		was_indoors = true
	
	if direction == DIRECTION.DOWN and ($NextCollision/Down.get_overlapping_bodies().size() == 0 or force_move or Global.debug):
			move_direction.y = 32
	if direction == DIRECTION.UP and ($NextCollision/Up.get_overlapping_bodies().size() == 0 or force_move or Global.debug):
			move_direction.y = -32
	if direction == DIRECTION.LEFT and ($NextCollision/Left.get_overlapping_bodies().size() == 0 or force_move or Global.debug):
			move_direction.x = -32
	if direction == DIRECTION.RIGHT and ($NextCollision/Right.get_overlapping_bodies().size() == 0 or force_move or Global.debug):
			move_direction.x = 32
	if direction == DIRECTION.DOWN_LEFT:
		move_direction.x = -32
		move_direction.y = 32
	if direction == DIRECTION.UP_RIGHT:
		move_direction.x = 32
		move_direction.y = -32
	last_facing_dir = direction

	if blocked:
		move_direction = Vector2.ZERO

	# Grass logic
	var grass1 = $Grass/Sprite2D # Current grass under player
	var grass2 = $Grass/Sprite2 # Grass player is moving to
	var grass_found = false
	entering_grass = false
	exiting_grass = false
	
	if move_direction != Vector2.ZERO:
		TerrainTags.get_tile_terrain_tag(self.position + move_direction)
	
	if Global.onStairsUp:
		Global.wasOnStairs = true
	elif Global.wasOnStairs and !Global.onStairsUp:
		if move_direction.x < 0:
			stair_offset = Vector2(0, -32)
		if move_direction.x > 0:
			stair_offset = Vector2(0, 32)
		Global.wasOnStairs = false
	else:
		stair_offset = Vector2.ZERO
	
	
	set_grass(direction)
	
	# Start Animation
	animate()
	
	# Godot 4: Create tween programmatically
	if tween:
		tween.kill()
	tween = create_tween()
	
	# Set Tween settings
	# Original timings (RMXP 40fps, realRes 128/tile): walk move_speed 3.6 -> 128/2^3.6/40 = 0.264 s/tile;
	# run 4.6 -> 0.132 s/tile (the remake was ~5% fast at 0.25/0.125)
	if movement_speed == MOVEMENT_SPEED.FAST:
		tween.tween_property(self, "position", self.position + move_direction + stair_offset, 0.132).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	else:
		tween.tween_property(self, "position", self.position + move_direction + stair_offset, 0.264).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	# Play bump effect is player can't move
	if move_direction == Vector2.ZERO:
		$AudioStreamPlayer2D.stream = load("res://Audio/SE/bump.WAV")
		$AudioStreamPlayer2D.play(0.0)

	# Wait until player finish move (Godot 4: await tween.finished)
	await tween.finished
	
	if Global.onGrass:
		$Grass.show()
		if !Global.grass_positions.has( self.position + Vector2(32, 0) ):
			$Grass/Sprite2.hide()
		$Grass/Sprite2D.show()
	else:
		$Grass.hide()
	

	$Grass.position = Vector2.ZERO
	
	if foot == 0:
		foot = 1
	else:
		foot = 0

	# Generate wild battle if on grass or if the scene calls for it.
	var wild_gen_on_step = false
	if "always_wild_gen_on_step" in Global.game.current_scene && Global.game.current_scene.always_wild_gen_on_step:
		wild_gen_on_step = true

	if (Global.onGrass || wild_gen_on_step) && !Global.block_wild && move_direction != Vector2.ZERO:
		wild_poke_encounter()

	set_process(true)
	isMoving = false
	set_idle_frame()
	trainer_encounter()
	
	emit_signal("step")

	# Check if player entered into a different scene. For outdoors only
	if !force_move && "type" in Global.game.current_scene && Global.game.current_scene.type == "Outside" && !was_indoors:
		var loc = Global.game.get_current_scene_where_player_is()
		if Global.game.current_scene != loc:
			if loc == null:
				print("PLAYER ERROR: Got Null on current_scene.")
			print("Player seamlessly entering different scene -> " + str(loc))
			Global.game.change_scene_to_file(null)

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
		runTexture = preload("res://Graphics/Characters/HEROINE-RUN.png")
	$Marker2D/Sprite2D.texture = walkTexture
	$Marker2D/Sprite2D.frame = 0
	
#Sets the sprite texture to the walkTexture and if the direction is not null then the sprite.frame is set to direction times 4
func set_idle_frame(_dir = null):
	state = STATE.IDLE
	$Marker2D/Sprite2D.texture = walkTexture
	if _dir == null: # Go with the last facing direction
		_dir = last_facing_dir
	match _dir:
		"Down", DIRECTION.DOWN:
			$Marker2D/Sprite2D.frame = 0
		"Up", DIRECTION.UP:
			$Marker2D/Sprite2D.frame = 12
		"Left", DIRECTION.LEFT:
			$Marker2D/Sprite2D.frame = 4
		"Right", DIRECTION.RIGHT:
			$Marker2D/Sprite2D.frame = 8
		_:
			$Marker2D/Sprite2D.frame = 0

func animate():
	#If the sprite texture is the walk texture
	if $Marker2D/Sprite2D.texture == walkTexture:
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
	elif $Marker2D/Sprite2D.texture == runTexture:
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

#This method stops the tween (Godot 4: use kill())
func stop_tween():
	if tween:
		tween.kill()

#Sets the texture to the walk texture
func set_facing_direction(facing_dir):
	if typeof(facing_dir) == TYPE_STRING:
		match facing_dir:
			"Up", DIRECTION.UP:
				facing_dir = DIRECTION.UP
			"Down", DIRECTION.DOWN:
				facing_dir = DIRECTION.DOWN
			"Left", DIRECTION.LEFT:
				facing_dir = DIRECTION.LEFT
			"Right", DIRECTION.RIGHT:
				facing_dir = DIRECTION.RIGHT
	direction = facing_dir
	$Marker2D/Sprite2D.texture = walkTexture
	$Marker2D/Sprite2D.frame = direction * 4

func move_player_event(_dir, steps): # Force moves player to direction and steps
	direction = _dir
	steps = steps
	movement_speed = MOVEMENT_SPEED.NORMAL
	for i in range(steps):
		move(true)
		await self.step
	emit_signal("done_movement")

func set_grass(dir):
	var speed := 0.125 if Global.sprint else 0.25
	if entering_grass:
		$Grass/Sprite2D.texture = load(Global.grassSprite)
		$Grass/Sprite2.texture = load(Global.grassSprite)
		
		# Godot 4: Create grass_tween programmatically
		if grass_tween:
			grass_tween.kill()
		grass_tween = create_tween()
		
		match dir:
			"Right", DIRECTION.RIGHT:
				$Grass.show()
				$Grass/Sprite2.show()
				$Grass/Sprite2D.hide()
				grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			"Left", DIRECTION.LEFT:
				$Grass.show()
				$Grass/Sprite2.hide()
				$Grass/Sprite2D.show()
				$Grass.position = Vector2(-32, 0)
				grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			"Up", DIRECTION.UP:
				grass_tween.tween_property($Grass/Sprite2D, "region_rect", Rect2(Vector2(32, 80 - 32), Vector2(32, 16)), speed).from(Rect2(Vector2(32, 80), Vector2(32, 16))).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
			"Down", DIRECTION.DOWN:
				$Grass.show()
				$Grass/Sprite2.hide()
				$Grass/Sprite2D.show()
				grass_tween.tween_property($Grass/Sprite2D, "region_rect", Rect2(Vector2(32, 80), Vector2(32, 16)), speed).from(Rect2(Vector2(32, 80 - 32), Vector2(32, 16))).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		return
	elif exiting_grass:
		# Godot 4: Create grass_tween programmatically
		if grass_tween:
			grass_tween.kill()
		grass_tween = create_tween()
		
		match dir:
			"Right", DIRECTION.RIGHT:
				$Grass.show()
				$Grass/Sprite2D.show()
				$Grass/Sprite2.hide()
				var duration = 0.25 if !Global.sprint else 0.125
				grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				return
			"Left", DIRECTION.LEFT:
				$Grass.show()
				$Grass/Sprite2.show()
				$Grass/Sprite2D.hide()
				$Grass.position = Vector2(-32, 0)
				var duration = 0.25 if !Global.sprint else 0.125
				grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				return
			"Down", DIRECTION.DOWN:
				$Grass.hide()
				return
			"Up", DIRECTION.UP:
				$Grass.show()
				$Grass/Sprite2D.show()
				$Grass/Sprite2.hide()
				var duration = 0.25 if !Global.sprint else 0.125
				var target_y = 32 if !Global.sprint else 16
				grass_tween.tween_property($Grass, "position", $Grass.position + Vector2(0, target_y), duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
				return
	else:
		if Global.onGrass:
			if !Global.grass_positions.has(self.position + Vector2(32, 0)):
				print("TEST")
			
			# Godot 4: Create grass_tween programmatically
			if grass_tween:
				grass_tween.kill()
			grass_tween = create_tween()
			
			$Grass.show()
			var duration = 0.125 if Global.sprint else 0.25
			match dir:
				"Right", DIRECTION.RIGHT:
					$Grass/Sprite2D.show()
					$Grass/Sprite2.show()
					print(Global.grass_positions)
					grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					return
				"Left", DIRECTION.LEFT:
					$Grass/Sprite2D.show()
					$Grass/Sprite2.show()
					$Grass.position = Vector2(-32, 0)
					grass_tween.tween_property($Grass, "position", $Grass.position - move_direction, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					return
				"Up", DIRECTION.UP:
					$Grass/Sprite2.hide()
					grass_tween.tween_property($Grass/Sprite2D, "region_rect", Rect2(Vector2(32, 80 - 32), Vector2(32, 16)), duration).from(Rect2(Vector2(32, 80), Vector2(32, 16))).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					return
				"Down", DIRECTION.DOWN:
					$Grass/Sprite2.hide()
					grass_tween.tween_property($Grass/Sprite2D, "region_rect", Rect2(Vector2(32, 80), Vector2(32, 16)), duration).from(Rect2(Vector2(32, 80 - 32), Vector2(32, 16))).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
					return
		else:
			$Grass.hide()


func remove_grass(exiting):
	if Global.onGrass:
		match exiting:
			"Right", DIRECTION.RIGHT:
				if direction == DIRECTION.RIGHT:
					Global.onGrass = false
					Global.exitGrassPos = ""
					Global.grassPos = ""
					$Grass/Sprite2.hide()
					return
				else:
					Global.grassPos = ""
					Global.onGrass = true
			"Left", DIRECTION.LEFT:
				if direction == DIRECTION.LEFT:
					Global.exitGrassPos = ""
					Global.grassPos = ""
					Global.onGrass = false
					$Grass/Sprite2D.hide()
					$Grass/Sprite2.show()
					return
				else:
					Global.grassPos = ""
					Global.onGrass = true
				return

func wild_poke_encounter():
	var trigger_wild_battle = false

	if entering_grass:
		var num = Global.rng.randf()
		if num <= 0.4:
			return
	
	var rate : int = 20
	
	if "base_encounter_rate" in Global.game.current_scene:
		rate = Global.game.current_scene.base_encounter_rate

	rate = rate * 16

	var modifier = 1.0
	rate = int(rate * modifier)

	if rate > 2888:
		rate = 2880

	var value = Global.rng.randi() % 2880

	if rate > value:
		trigger_wild_battle = true
	
	if trigger_wild_battle:
		canMove = false
		set_idle_frame(direction)
		emit_signal("wild_battle")

func trainer_encounter():
	if Global.game.trainers == null:
		return

	if !canMove:
		return

	for trainer in Global.game.trainers:
		if trainer != null && "seeking" in trainer && trainer.seeking:
			var check_positions = []
			var player_set_dir
			for i in range(trainer.trainer_search_range):
				var offset = trainer.position + Global.game.current_scene.position
				match trainer.facing:
					"Up":
						offset += Vector2(0,-32) * (i + 1) 
					"Down":
						offset += Vector2(0, 32) * (i + 1) 
					"Left":
						offset += Vector2(-32, 0) * (i + 1) 
					"Right":
						offset += Vector2(32,  0) * (i + 1) 
				check_positions.append(offset)
			if check_positions.has(self.position):
				print("Player found")
				canMove = false
				emit_signal("trainer_battle", trainer)
				return
	pass

func get_position_relative_to_current_scene():
	return self.position - Global.game.current_scene.position

func jump():
	canMove = false
	Global.game.menu.locked = true
	set_process(false)

	move_direction = Vector2.ZERO
	if direction == DIRECTION.DOWN:
		move_direction.y = 64
	if direction == DIRECTION.UP:
		move_direction.y = -64
	if direction == DIRECTION.LEFT:
		move_direction.x = -64
	if direction == DIRECTION.RIGHT:
		move_direction.x = 64

	# Godot 4: Create tween programmatically
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", self.position + move_direction, 0.25).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	$AudioStreamPlayer2D.stream = load("res://Audio/SE/jump.wav")
	$AudioStreamPlayer2D.play(0.0)

	$AnimationPlayer.play("Jump")
	await tween.finished

	var grass_found_local = false
	for pos in Global.grass_positions:
		if Global.game.player.position + move_direction == pos:
			grass_found_local = true

			if !Global.onGrass:
				entering_grass = true
			Global.onGrass = true
			break
	if !grass_found_local:
		if Global.onGrass:
			exiting_grass = true
		Global.onGrass = false
	
	set_grass(direction)
	
	canMove = true
	Global.game.menu.locked = false
	set_idle_frame()
	set_process(true)
