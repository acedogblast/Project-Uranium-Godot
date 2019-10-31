extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Vs/SpriteLeft/AnimationPlayer.play("Scroll")
	$Vs/SpriteRight/AnimationPlayer.play_backwards("Scroll")
	
	
	$Vs/PlayerBanner/Label.scroll_active = false
	$Vs/OpponentBanner/Label.scroll_active = false
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_Sound():
	var sound = load("res://Audio/SE/Flash2.ogg")
	var sound2 = load("res://Audio/SE/Sword2.ogg")
	sound2.loop = false
	sound.loop = false
	$Vs/AudioStreamPlayer.stream = sound
	$Vs/AudioStreamPlayer2.stream = sound2
	$Vs/AudioStreamPlayer.play()
	$Vs/AudioStreamPlayer2.play()