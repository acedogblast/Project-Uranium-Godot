extends Node
var grayBox = Rect2(16,444,384,46)
var greenBox = Rect2(16,490,384,46)
var selected = 0
func _ready():
	$Panels/NewGame.texture.region = greenBox
	$Panels/Exit.texture.region = grayBox
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_down") && selected == 0:
		selected = 1
		updateBoxes()
	if Input.is_action_just_pressed("ui_up") && selected == 1:
		selected = 0
		updateBoxes()
	
	#Selection choices
	if Input.is_action_just_pressed("ui_accept") && selected == 0:
		NewGame()
	if Input.is_action_just_pressed("ui_accept") && selected == 1:
		get_tree().quit()
	pass
	
func NewGame():
	changeScene("res://IntroScenes/PlayerCreation.tscn")
	pass
	
func updateBoxes():
	if selected == 0:
		$Panels/NewGame.texture.region = greenBox
		$Panels/Exit.texture.region = grayBox
		
	if selected == 1:
		$Panels/NewGame.texture.region = grayBox
		$Panels/Exit.texture.region = greenBox
	$AudioStreamPlayer.play()
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass