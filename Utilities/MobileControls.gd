extends Node
var game = null
var gameInstance = null
var deviceResolution = OS.get_real_window_size()
func _ready():
	Global.isMobile = true
	$ColorRect.rect_size = deviceResolution
	
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
	
	DialogueSystem.rescale_mobile(deviceResolution)
	
	#print(horizontalSize)
	#print($ViewportContainer.rect_size)
	#print($ViewportContainer.rect_position)
	
	var controlScale = deviceResolution.y / 3000
	$CanvasLayer/D_Pad.position = Vector2(0, int(round(deviceResolution.y / 2)))
	$CanvasLayer/D_Pad.scale = Vector2(controlScale, controlScale)
	
	$CanvasLayer/Buttons.position = Vector2(deviceResolution.x - int(round(1500 * controlScale))   , int(round(deviceResolution.y / 2)))
	$CanvasLayer/Buttons.scale = Vector2(controlScale, controlScale)
	pass
func changeScene(scene):
	gameInstance.queue_free()
	game = load(scene)
	gameInstance = game.instance()
	$ViewportContainer/GameViewport.add_child(gameInstance)
	pass
func _on_Up_pressed():
	var a = InputEventAction.new()
	a.action = "ui_up"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("ui_up")


func _on_Down_pressed():
	var a = InputEventAction.new()
	a.action = "ui_down"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("ui_down")


func _on_Left_pressed():
	var a = InputEventAction.new()
	a.action = "ui_left"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("ui_left")


func _on_Right_pressed():
	var a = InputEventAction.new()
	a.action = "ui_right"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("ui_right")


func _on_Up_released():
	var a = InputEventAction.new()
	a.action = "ui_up"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("ui_up")


func _on_Down_released():
	var a = InputEventAction.new()
	a.action = "ui_down"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("ui_down")


func _on_Left_released():
	var a = InputEventAction.new()
	a.action = "ui_left"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("ui_left")


func _on_Right_released():
	var a = InputEventAction.new()
	a.action = "ui_right"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("ui_right")


func _on_Z_button_down():
	var a = InputEventAction.new()
	a.action = "z"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("z")


func _on_X_button_down():
	var a = InputEventAction.new()
	a.action = "x"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("x")


func _on_C_button_down():
	var a = InputEventAction.new()
	a.action = "c"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("c")


func _on_S_button_down():
	var a = InputEventAction.new()
	a.action = "ui_accept"
	a.pressed = true
	Input.parse_input_event(a)
	#Input.action_press("ui_accept")


func _on_Z_button_up():
	var a = InputEventAction.new()
	a.action = "z"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("z")


func _on_X_button_up():
	var a = InputEventAction.new()
	a.action = "x"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("x")


func _on_C_button_up():
	var a = InputEventAction.new()
	a.action = "c"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("c")


func _on_S_button_up():
	var a = InputEventAction.new()
	a.action = "ui_accept"
	a.pressed = false
	Input.parse_input_event(a)
	#Input.action_release("ui_accept")
