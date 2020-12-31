extends Node2D

export var displayname = ""
export var trainer = false
export var texture: StreamTexture = null
export var battle_texture: Texture = null
export var battle_music: AudioStream = null
export var random_movement = false
export(String, "Down", "Up", "Left", "Right") var facing = "Up"


enum BattleType {
	SINGLE_WILD, DOUBLE_WILD, SINGLE_TRAINER, DOUBLE_TRAINER, SINGLE_GYML, DOUBLE_GYML, RIVAL, URAYNE, LEGENDARY
}
export(BattleType) var battle_type = BattleType.SINGLE_TRAINER
enum BattleBack {
	BEACH, CAVE, CHAMPIONSHIP_1, CHAMPIONSHIP_2, CITY, DIVE, FEILD_1, FEILD_2, FEILD_3, 
	FLOWER, GAMMA, GYM_4, ICE_CAVE, INDOOR_1, INDOOR_2, MOUNTAIN, NUCLEAR, PVP, RIVER, 
	SHELTER, SNOW, VOLCANO, WATER, FOREST
}
export(BattleBack) var battle_back = BattleBack.INDOOR_1
enum OpponentType {OPPONENT_RIVAL, OPPONENT_TRAINER, OPPONENT_WILD}
export(OpponentType) var opponent_type = OpponentType.OPPONENT_TRAINER
enum AIBehavior {WILD , TESTING_1}
export (AIBehavior) var AI_behavior = AIBehavior.WILD

export var pokemon1_ID = int()
export var pokemon1_level = int()
export var pokemon2_ID = int()
export var pokemon2_level = int()
export var pokemon3_ID = int()
export var pokemon3_level = int()
export var pokemon4_ID = int()
export var pokemon4_level = int()
export var pokemon5_ID = int()
export var pokemon5_level = int()
export var pokemon6_ID = int()
export var pokemon6_level = int()


var move_direction = Vector2()
var foot = 0
var moving = false

#onready var player_direction = player.direction

signal done_movement
signal step
signal alert_done

#testing
func _input(event):
	if Input.is_action_pressed("debug"):
		battle_start()

func _ready():
	self.add_to_group("auto_z_layering")
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
	if trainer == true:
		alert()

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

func battle_start():
	Global.game.battle = load("res://Utilities/Battle/Battle.tscn").instance()
	Global.game.add_child(Global.game.battle)

	var bid = BattleInstanceData.new()
	
	
	bid.battle_type = battle_type
	bid.battle_back = battle_back
	bid.opponent = Opponent.new()
	if displayname != "":
		bid.opponent.name = displayname
	else:
		print("ERROR: No name applied to NPC")
	bid.opponent.opponent_type = opponent_type
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD

	var poke = Pokemon.new()
	if pokemon1_level and pokemon1_ID != null:
		poke.set_basic_pokemon_by_level(pokemon1_ID, pokemon1_level)
	else:
		print("ERROR: NPC has no first pokemon")
	if pokemon2_level and pokemon2_ID != null:
		poke.set_basic_pokemon_by_level(pokemon2_ID, pokemon2_level)
	if pokemon3_level and pokemon3_ID != null:
		poke.set_basic_pokemon_by_level(pokemon3_ID, pokemon3_level)
	if pokemon4_level and pokemon4_ID != null:
		poke.set_basic_pokemon_by_level(pokemon4_ID, pokemon4_level)
	if pokemon5_level and pokemon5_ID != null:
		poke.set_basic_pokemon_by_level(pokemon5_ID, pokemon5_level)
	if pokemon6_level and pokemon6_ID != null:
		poke.set_basic_pokemon_by_level(pokemon6_ID, pokemon6_level)
	
	bid.opponent.pokemon_group.append(poke)
	
	
	if battle_texture != null:
		bid.opponent.battle_texture = battle_texture
	else:
		print("ERROR: NPC has no battle texture")
	Global.game.battle.Start_Battle(bid) # YEET!!!
	yield(Global.game.battle, "battle_complete")
	
	if battle_music != null:
		Global.game.get_node("Background_music").stream = battle_music
	else:
		print("ERROR: NPC has no battle music")
	Global.game.get_node("Background_music").play()
