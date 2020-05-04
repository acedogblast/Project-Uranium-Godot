extends Node
var grayBox = Rect2(16,444,384,46)
var greenBox = Rect2(16,490,384,46)

var grayLoad = Rect2(0,0,408,222)
var greenLoad = Rect2(0,222,408,222)

var pannel_layout
enum PANNEL {
	NEW,
	FULL
}
enum SELECTED { # for the full pannel
	CONTINUE,
	NEW_GAME,
	OTHER_SAVES,
	DELETE_SAVE,
	UPDATE,
	OPTIONS,
	EXIT
}
var selected = 0
var save_id = 1
func _ready():
	# Check for existing save files
	var num = SaveSystem.get_number_of_saves()
	if num == 0:
		pannel_layout = PANNEL.NEW
		$Panels.visible = true
		$FullPanel.visible = false
		$Panels/NewGame.texture.region = greenBox
		$Panels/Exit.texture.region = grayBox
	else:
		pannel_layout = PANNEL.FULL
		$Panels.visible = false
		$FullPanel.visible = true
		$FullPanel/Load.region_rect = greenLoad

		# set Load pannel to data of save001.tres



func _process(delta):
	if pannel_layout == PANNEL.NEW:
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
	else:
		if Input.is_action_just_pressed("ui_down"):
			if selected == SELECTED.EXIT:
				selected = SELECTED.CONTINUE
			else:
				selected += 1
			updateBoxes()
		if Input.is_action_just_pressed("ui_up"):
			if selected == SELECTED.CONTINUE:
				selected = SELECTED.EXIT
			else:
				selected -= 1
			updateBoxes()
		
		#Selection choices
		if Input.is_action_just_pressed("ui_accept"):
			match selected:
				SELECTED.CONTINUE:
					continueGame(save_id)
				SELECTED.NEW_GAME:
					NewGame()
				SELECTED.EXIT:
					get_tree().quit()
		pass
	
func NewGame():
	changeScene("res://IntroScenes/PlayerCreation.tscn")
	pass
	
func updateBoxes():
	if pannel_layout == PANNEL.NEW:
		if selected == 0:
			$Panels/NewGame.texture.region = greenBox
			$Panels/Exit.texture.region = grayBox
			
		if selected == 1:
			$Panels/NewGame.texture.region = grayBox
			$Panels/Exit.texture.region = greenBox
		$AudioStreamPlayer.play()
	else:
		# Grey out all boxes
		$FullPanel/Load.region_rect = grayLoad
		$FullPanel/NewGame.texture.region = grayBox
		$FullPanel/OtherSave.texture.region = grayBox
		$FullPanel/Delete.texture.region = grayBox
		$FullPanel/Update.texture.region = grayBox
		$FullPanel/Options.texture.region = grayBox
		$FullPanel/Exit.texture.region = grayBox
		var pannel_pos
		match selected:
			SELECTED.CONTINUE:
				$FullPanel/Load.region_rect = greenLoad
				pannel_pos = 0
			SELECTED.NEW_GAME:
				$FullPanel/NewGame.texture.region = greenBox
				pannel_pos = 0
			SELECTED.OTHER_SAVES:
				$FullPanel/OtherSave.texture.region = greenBox
				pannel_pos = 0
			SELECTED.DELETE_SAVE:
				$FullPanel/Delete.texture.region = greenBox
				pannel_pos = 1
			SELECTED.UPDATE:
				$FullPanel/Update.texture.region = greenBox
				pannel_pos = 1
			SELECTED.OPTIONS:
				$FullPanel/Options.texture.region = greenBox
				pannel_pos = 1
			SELECTED.EXIT:
				$FullPanel/Exit.texture.region = greenBox
				pannel_pos = 1
		if pannel_pos == 0:
			$FullPanel.position = Vector2(50, 32)
		else:
			$FullPanel.position = Vector2(50, -160)
		$AudioStreamPlayer.play()
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass

func continueGame(id):
	Global.load_game_from_id = id
	changeScene("res://Maps/Game.tscn")
