extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Vs/SpriteLeft.texture.flags = Texture.FLAG_REPEAT;
	$Vs/SpriteRight.texture.flags = Texture.FLAG_REPEAT;
	$Vs/SpriteLeft/AnimationPlayer.play("Scroll")
	$Vs/SpriteRight/AnimationPlayer.play_backwards("Scroll")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_Sound():
	$Vs/AudioStreamPlayer.stream = load("") # Need to find sound