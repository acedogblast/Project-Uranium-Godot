extends Node

var battle_type

# Called when the node enters the scene tree for the first time.
func _ready():
	test()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass

func test():
	$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-TheoBattle.ogg")
	$CanvasLayer/AudioStreamPlayer.play()
