extends TextureRect

func ball_flash():
	var scene = load("res://Utilities/Battle/BallFlash.tscn")
	var ballflash = scene.instance()
	$Ball.add_child(ballflash)
	#yield(ballflash, "free")
	pass