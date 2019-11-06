extends Node
var game = null
var gameInstance = null
var deviceResolution = OS.get_real_window_size()
func _ready():
	Global.isMobile = true
	$ColorRect.rect_size = deviceResolution
	$ColorRect.visible = true
	
	$ViewportContainer/GameViewport.set_size_override_stretch(true)
	$ViewportContainer/GameViewport.set_size_override(true, Vector2(512,384))
	
	resize()
	game = load("res://IntroScenes/Intro.tscn")
	#game = load("res://Maps/Moki Town/HeroHome.tscn") 
	
	
	gameInstance = game.instance()
	$ViewportContainer/GameViewport.add_child(gameInstance)
	pass

func resize():
	deviceResolution = OS.get_real_window_size()
	#print(deviceResolution)
	
	var horizontalSize = int(round(deviceResolution.y * 1.333))
	$ViewportContainer.rect_position = Vector2( (deviceResolution.x - horizontalSize) / 2, 0)
	$ViewportContainer.rect_size = Vector2(horizontalSize, deviceResolution.y)
	
	#print(horizontalSize)
	#print($ViewportContainer.rect_size)
	#print($ViewportContainer.rect_position)
	
	var controlScale = deviceResolution.y / 3000
	$D_Pad.position = Vector2(0, int(round(deviceResolution.y / 2)))
	$D_Pad.scale = Vector2(controlScale, controlScale)
	
	$Buttons.position = Vector2(deviceResolution.x - int(round(1500 * controlScale))   , int(round(deviceResolution.y / 2)))
	$Buttons.scale = Vector2(controlScale, controlScale)
	pass
func changeScene(scene):
	gameInstance.queue_free()
	game = load(scene)
	gameInstance = game.instance()
	$ViewportContainer/GameViewport.add_child(gameInstance)
	pass
func _on_Up_pressed():
	Input.action_press("ui_up")
	pass # replace with function body


func _on_Down_pressed():
	Input.action_press("ui_down")
	pass # replace with function body


func _on_Left_pressed():
	Input.action_press("ui_left")
	pass # replace with function body


func _on_Right_pressed():
	Input.action_press("ui_right")
	pass # replace with function body


func _on_Up_released():
	Input.action_release("ui_up")
	pass # replace with function body


func _on_Down_released():
	Input.action_release("ui_down")
	pass # replace with function body


func _on_Left_released():
	Input.action_release("ui_left")
	pass # replace with function body


func _on_Right_released():
	Input.action_release("ui_right")
	pass # replace with function body


func _on_Z_button_down():
	Input.action_press("z")
	pass # replace with function body


func _on_X_button_down():
	Input.action_press("x")
	pass # replace with function body


func _on_C_button_down():
	Input.action_press("c")
	pass # replace with function body


func _on_S_button_down():
	Input.action_press("ui_accept")
	pass # replace with function body


func _on_Z_button_up():
	Input.action_release("z")
	pass # replace with function body


func _on_X_button_up():
	Input.action_release("x")
	pass # replace with function body


func _on_C_button_up():
	Input.action_release("c")
	pass # replace with function body


func _on_S_button_up():
	Input.action_release("ui_accept")
	pass # replace with function body
