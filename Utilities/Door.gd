extends Node2D

export(String, FILE, "*.tscn") var scene_destination # The scene to change to
export(Vector2) var location # The location of the exit
export(bool) var exterior # Is the door an exterior or interior
export(String, "Type 1 - Wood", "Type 2 - Glass") var door_type # The texture of the exterior door

onready var type1_texture = load("res://Graphics/Characters/PU-doorsdew.PNG")
onready var type2_texture = load("res://Graphics/Characters/FKdoors1.png")

signal animation_finished

func _ready():
	if !exterior:
		$Exterior.visible = false
	else:
		$Exterior.visible = true
		match door_type:
			"Type 1 - Wood":
				$Exterior.texture = type1_texture
				$Exterior.vframes = 1
				$Exterior.hframes = 1
				$Exterior.frame = 0
				$Exterior.region_enabled = true
				$Exterior.region_rect = Rect2(4,0,32,32)
			"Type 2 - Glass":
				$Exterior.texture = type2_texture
				$Exterior.vframes = 4
				$Exterior.hframes = 4
				$Exterior.frame = 3
				$Exterior.region_enabled = false
	#animation_open()
	
func animation_open():
	match door_type:
		"Type 1 - Wood":
			$Exterior.region_rect = Rect2(4,0,32,32)
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.region_rect = Rect2(4,72,32,32)
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.region_rect = Rect2(4,36,32,32)
		"Type 2 - Glass":
			$Exterior.frame = 7
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.frame = 11
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.frame = 15
	emit_signal("animation_finished")

func animation_close():
	match door_type:
		"Type 1 - Wood":
			$Exterior.region_rect = Rect2(4,36,32,32)
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.region_rect = Rect2(4,72,32,32)
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.region_rect = Rect2(4,0,32,32)
		"Type 2 - Glass":
			$Exterior.frame = 15
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.frame = 11
			yield(get_tree().create_timer(0.2), "timeout")
			$Exterior.frame = 7
	emit_signal("animation_finished")

func transition():
	Global.game.lock_player()
	var sound = load("res://Audio/SE/Exit Door.WAV")
	$AudioStreamPlayer.stream = sound

	if exterior:
		sound = load("res://Audio/SE/Entering Door.wav")
		$AudioStreamPlayer.stream = sound
		$AudioStreamPlayer.play()
		animation_open()
		yield(self, "animation_finished")

		Global.game.player.move(true)
		yield(Global.game.player, "step")

		Global.game.player.visible = false

		animation_close()
		yield(self, "animation_finished")
	else:
		$AudioStreamPlayer.play()
	Global.game.door_transition(scene_destination, location)
func set_open():
	match door_type:
		"Type 1 - Wood":
			$Exterior.region_rect = Rect2(4,36,32,32)
		"Type 2 - Glass":
			$Exterior.frame = 15
