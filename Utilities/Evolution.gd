extends Node2D

export var effect_weight = 0.0
var effect_shader
var effect_shader_2
var effect_enable = false
var start_sprite
var end_sprite
var start_name
var end_name
var start_cry
var end_cry

signal close

func _ready():
	$StartSprite.free()
	$EndSprite.free()

func _process(_delta):
	if effect_enable:
		effect_shader.set_shader_param("effect_weight" , effect_weight)
		effect_shader_2.set_shader_param("effect_weight" , effect_weight)
	pass

func setup(poke_start : Pokemon, poke_ID_end : int):
	start_name = poke_start.name
	start_cry = poke_start.get_cry()
	start_sprite = poke_start.get_battle_foe_sprite()
	start_sprite.position = Vector2(256,192)
	start_sprite.scale = Vector2(2,2)
	start_sprite.visible = true
	start_sprite.material = ShaderMaterial.new()
	start_sprite.material.shader = load("res://Utilities/Battle/WhiteFade.shader")
	start_sprite.material.set_shader_param("effect_weight", 0.0)
	start_sprite.name = "StartSprite"
	effect_shader = start_sprite.material
	effect_weight = 0.0
	self.add_child(start_sprite)

	var temp = Pokemon.new()
	temp.set_basic_pokemon_by_level(poke_ID_end, 1)
	end_name = temp.name
	end_cry = temp.get_cry()
	temp.is_shiny = poke_start.is_shiny
	end_sprite = temp.get_battle_foe_sprite()
	end_sprite.position = Vector2(256,192)
	end_sprite.scale = Vector2(2,2)
	end_sprite.visible = false
	end_sprite.material = ShaderMaterial.new()
	end_sprite.material.shader = load("res://Utilities/Battle/WhiteFade.shader")
	end_sprite.material.set_shader_param("effect_weight", 0.0)
	end_sprite.name = "EndSprite"
	effect_shader_2 = end_sprite.material
	effect_weight = 0.0
	self.add_child(end_sprite)

func run():
	effect_enable = true
	yield(get_tree().create_timer(1.0), "timeout")
	Global.game.get_node("Effect_music").stream = load(start_cry)
	Global.game.get_node("Effect_music").play()

	Global.game.play_dialogue("What?\n" + start_name + " is evolving!")
	yield(Global.game, "event_dialogue_end")

	$AudioStreamPlayer.stream = load("res://Audio/BGM/PU-evolve.ogg")
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("ShadeUp")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Evolve")
	yield($AnimationPlayer, "animation_finished")
	$AudioStreamPlayer.stop()
	start_sprite.hide()
	Global.game.get_node("Effect_music").stream = load(end_cry)
	Global.game.get_node("Effect_music").play()

	var sound = load("res://Audio/ME/PU-PokemonObtained.ogg")
	sound.loop = false
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()

	Global.game.play_dialogue("Congratulations!\nYour " + start_name + " evolved into " + end_name + "!")
	yield(Global.game, "event_dialogue_end")
	emit_signal("close")
	effect_enable = false
