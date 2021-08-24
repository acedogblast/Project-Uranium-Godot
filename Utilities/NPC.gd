extends Node2D

export(bool) var trainer = false
export var texture : StreamTexture = null
export(int, 8) var trainer_search_range : int = 3
export var trainer_name : String
export var trainer_reward : int
export(String, "Still", "Turning", "Walking") var trainer_behavior : String
export(bool) var seeking = false
export(String, "Down", "Up", "Left", "Right") var facing = "Down"
export var trainer_poke_group = [] # Array of arrays of poke ID, then level
var defeated = false

var move_direction = Vector2()
var foot = 0
var moving = false
var timer

var turning_directions = [] # Array of facing strings for turning. Empty if using all 4 directions
var turning_index : int = 0

signal done_movement
signal step
signal alert_done

func _ready():
	self.add_to_group("auto_z_layering")

	if trainer:
		self.add_to_group("trainers")

	$Alert.visible = false
	$Position2D/Sprite.texture = texture
	set_idle_frame(facing)
	if texture == null:
		print("WARNING: No texture applied to NPC")
	
	if trainer_behavior == "Turning":
		timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "turning")
		timer.wait_time = 3.0
		timer.one_shot = false
		timer.start()
		if turning_directions.empty() || turning_directions == null:
			for i in range(turning_directions.size()):
				if turning_directions[i] == facing:
					turning_index = i
					break


func _process(_delta):
	# if !moving:
	# 	if random_movement:
	# 		var rand = randi()%7 + 1
	# 		match rand:
	# 			1:
	# 				move("Down")
	# 			2:
	# 				move("Up")
	# 			3:
	# 				move("Left")
	# 			4:
	# 				move("Right")
	# 			5:
	# 				yield(get_tree().create_timer(0.8), "timeout")
	# 			6:
	# 				yield(get_tree().create_timer(0.4), "timeout")
	pass

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
	if _dir == null:
		_dir = facing

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
	facing = _dir

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

func move_to_player(): # Walk staight to the player. Must already be facing the player
	var game_position = self.position + Global.game.current_scene.position
	var distance = int(game_position.distance_to(Global.game.player.position) / 32) - 1
	if distance == 0:
		yield(get_tree().create_timer(0.02), "timeout")
		emit_signal("done_movement")
		return
	move_multi(facing, distance)

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
func get_poke_group():
	var group = []
	for i in trainer_poke_group:
		var poke = Pokemon.new()
		poke.set_basic_pokemon_by_level(i[0],i[1])
		group.append(poke)
	return group
func turning():
	# Check if we already have been defeated
	if defeated:
		timer.stop()
		timer.queue_free()
	else:
		if seeking:
			# Turn
			if turning_directions.empty() || turning_directions == null:
				match facing:
					"Down":
						facing = "Right"
					"Up":
						facing = "Left"
					"Left":
						facing = "Down"
					"Right":
						facing = "Up"
			else:
				if turning_index == turning_directions.size() - 1:
					turning_index = 0
				else:
					turning_index += 1	
				facing = turning_directions[turning_index]
			set_idle_frame(facing)
			# check for player
			Global.game.player.trainer_encounter()
