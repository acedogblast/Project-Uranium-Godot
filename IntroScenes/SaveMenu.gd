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
	#Gets the number of saves from the save system
	var num = SaveSystem.get_number_of_saves()
	#If there are no saves, then set the panel layout to panel.new, set the panels to visible, set the FullPanel to invisible, uses the greenbox texture region for a new game, and greybox for the exit
	if num == 0:
		pannel_layout = PANNEL.NEW
		$Panels.visible = true
		$FullPanel.visible = false
		$Panels/NewGame.texture.region = greenBox
		$Panels/Exit.texture.region = grayBox
	#If there are saves, then set the panel layout to panel.full, set the panels to invisible, make the fullpanel visible, and use greenload for the fullpanel region_rect
	else:
		pannel_layout = PANNEL.FULL
		$Panels.visible = false
		$FullPanel.visible = true
		$FullPanel/Load.region_rect = greenLoad

		# set Load pannel to data of save001.tres
		var save = SaveSystem.load_file(save_id)
		var global_state = save.get_data("")
		var game_state = save.get_data("res://Game.tscn")

		var current_scene = load(game_state["current_scene"])
		var current_scene_instance = current_scene.instance()

		$FullPanel/Load/Location.text = current_scene_instance.place_name
		match global_state["TrainerGender"]:
			0:
				$FullPanel/Load/Player.texture = load("res://Graphics/Characters/HERO.png")
			1:
				$FullPanel/Load/Player.texture = load("res://Graphics/Characters/PU-Pluto.png")
			2:
				$FullPanel/Load/Player.texture = load("res://Graphics/Characters/HEROINE.png")

		$FullPanel/Load/Badges/Value.text = str(global_state["badges"])
		$FullPanel/Load/Pokedex/Value.text = str(global_state["pokedex_caught"].size())
		var minutes = global_state["time"]
		$FullPanel/Load/Time/Value.text = str("%02d" % (minutes / 60)) + ":" + str("%02d" % (minutes % 60))
		var poke_group = global_state["pokemon_group"]
		var index = 0
		for poke in poke_group:
			match index:
				0:
					$FullPanel/Load/P1.texture = poke.get_icon_texture()
					$FullPanel/Load/P1.show()
				1:
					$FullPanel/Load/P2.texture = poke.get_icon_texture()
					$FullPanel/Load/P2.show()
				2:
					$FullPanel/Load/P3.texture = poke.get_icon_texture()
					$FullPanel/Load/P3.show()
				3:
					$FullPanel/Load/P4.texture = poke.get_icon_texture()
					$FullPanel/Load/P4.show()
				4:
					$FullPanel/Load/P5.texture = poke.get_icon_texture()
					$FullPanel/Load/P5.show()
				5:
					$FullPanel/Load/P6.texture = poke.get_icon_texture()
					$FullPanel/Load/P6.show()
			index += 1




func _process(delta):
	#If panel layout is pannel.new then run the next line
	if pannel_layout == PANNEL.NEW:
		#If the selected is 0, and down is pressed, then select one and call the updateboxes method
		if Input.is_action_just_pressed("ui_down") && selected == 0:
			selected = 1
			updateBoxes()
		#If the selected is 1, and up is pressed, then select zero and call the updateboxes mehtod
		if Input.is_action_just_pressed("ui_up") && selected == 1:
			selected = 0
			updateBoxes()
		
		#If accept is pressed while 0 is selected, call the newgame method
		if Input.is_action_just_pressed("ui_accept") && selected == 0:
			NewGame()
		#If accept is pressed while 1 is selected, get the tree and call the quit method
		if Input.is_action_just_pressed("ui_accept") && selected == 1:
			get_tree().quit()
		pass
	#If the panel layout is not pannel.new, run the next line
	else:
		#If down is pressed and the selected is exit, then set the selected to continue. If not, set the seleced to itself + 1
		if Input.is_action_just_pressed("ui_down"):
			if selected == SELECTED.EXIT:
				selected = SELECTED.CONTINUE
			else:
				selected += 1
			updateBoxes()
		#If up is pressed and the selected is continue, then set the selected to exit. if not, set the slected to itself minus 1
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
	
#Changes the scene to character creation
func NewGame():
	changeScene("res://IntroScenes/PlayerCreation.tscn")
	pass
	
func updateBoxes():
	#If the pannel layout is PANNEL.NEW play the audio stream player and go to the next line
	if pannel_layout == PANNEL.NEW:
		#If the selected is 0, then set the newgame texture region to greenbox, and the exit texture region to graybox
		if selected == 0:
			$Panels/NewGame.texture.region = greenBox
			$Panels/Exit.texture.region = grayBox
			
		#If the selected is 1, then set the newgame texture region to graybox, and the exit texture region to greenbox
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
		
#Changes loads the method newscene in the parent node if on mobile, or gets change scene from the scene tree if not on mobile
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass

#Loads the map to continue your game
func continueGame(id):
	Global.load_game_from_id = id
	changeScene("res://Game.tscn")
