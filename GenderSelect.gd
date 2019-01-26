extends Node2D
var lastAnimationPos = 0.0
var lastAnimation = null
var selection = 0  # 0 is boy, 1 is neutral, 2 is girl
var prevSelection = 0
var inGenderSelect = false
var canSelect = true
var confirmed = false
var confirmationSelect = 0 # 0 is Yes, 1 in No
var selectStage = 0 # 0 is Gender, 1 is Confirmation

func Start():
	$ConfirmationBox.visible = false
	$Dialoge.visible = false
	$NameBG.visible = false
	$GenderColor/AnimationPlayerSlide.play("ColorSlide")
	pass
func DoneFade():
	$Neutral/AnimationPlayer.play("Shrink")
	$Girl/AnimationPlayer.play("Shrink")
	pass
func ShowDialog():
	inGenderSelect = true
	#print("ShowDialog")
	canSelect = true
	newdialog("Who are you?")
	pass
func Confirmation():
	#print("Confirmation")
	canSelect = false
	newdialog("Are you sure?")
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right") and canSelect == true and selection != 2:
		prevSelection = selection
		selection = selection + 1
		ShowSelected()	
		pass
	elif Input.is_action_just_pressed("ui_left") and canSelect == true and selection != 0:
		prevSelection = selection
		selection = selection - 1
		ShowSelected()
		pass
	if Input.is_action_just_pressed("ui_up") and canSelect == false and confirmationSelect != 0:
		confirmationSelect = 0
		$ConfirmationBox/Arrow/AudioStreamPlayer.play()
		$ConfirmationBox/Arrow.rect_position = Vector2(10, 15)
		pass	
	elif Input.is_action_just_pressed("ui_down") and canSelect == false and confirmationSelect != 1:
		confirmationSelect = 1
		$ConfirmationBox/Arrow/AudioStreamPlayer.play()
		$ConfirmationBox/Arrow.rect_position = Vector2(10, 50)
		pass
	if Input.is_action_just_pressed("ui_accept") and selectStage == 0 and inGenderSelect == true:
		#print("working")
		canSelect = false
		selectStage = 1
		$ConfirmationBox.visible = true
		#print("visable")
		Confirmation()
		pass
	elif Input.is_action_just_pressed("ui_accept") and selectStage == 1:
		if confirmationSelect == 0:
			selectStage = 2
			newdialog("I'd like to know your name.\nPlease tell me.")
			pass
		if confirmationSelect == 1:
			ShowDialog()
			canSelect = true
			selectStage = 0
			$ConfirmationBox.visible = false
			pass
		pass
	elif Input.is_action_just_pressed("ui_accept") and selectStage == 2:
		if selection == 0:
			$NameBG/Hero.texture = $Boy.texture
		elif selection == 1:
			$NameBG/Hero.texture = $Neutral.texture
		elif selection == 2:
			$NameBG/Hero.texture = $Girl.texture
		$NameBG.visible = true
		selectStage = 3
		pass
		
	pass
var blue = preload("res://Graphics/Pictures/Gender/genderboy.png")
var green = preload("res://Graphics/Pictures/Gender/genderneutral.png")
var red = preload("res://Graphics/Pictures/Gender/gendergirl.png")
func ShowSelected():
	if selection == 1:
		$GenderColor.texture = green
		if prevSelection == 0:
			$Boy/AnimationPlayer.play("Shrink")
			$Neutral/AnimationPlayer.play_backwards("Shrink")
		if prevSelection == 2:
				$Girl/AnimationPlayer.play("Shrink")
				$Neutral/AnimationPlayer.play_backwards("Shrink")
		pass
	if selection == 2:
		$GenderColor.texture = red
		$Neutral/AnimationPlayer.play("Shrink")
		$Girl/AnimationPlayer.play_backwards("Shrink")
		pass
	if selection == 0:
		$GenderColor.texture = blue
		$Boy/AnimationPlayer.play_backwards("Shrink")
		$Neutral/AnimationPlayer.play("Shrink")
		pass
	$AudioStreamPlayer.play()
	pass
func newdialog(text):
	Pause()
	$Dialoge/Text.text = text
	$Dialoge.visible = true
	pass
func dialogEnd():
	Resume()
	pass
func Pause():
	lastAnimationPos = $AnimationPlayer.current_animation_position
	lastAnimation = $AnimationPlayer.current_animation
	$AnimationPlayer.stop(false)
	#print("Paused")
	pass
func Resume():
	$AnimationPlayer.play(lastAnimation)
	$AnimationPlayer.seek(lastAnimationPos)
	#print("Resumed")
	pass

func _on_LineEdit_text_entered(new_text):
	Global.TrainerName = new_text
	Global.TrainerGender = selection
	#Global.TrainerImage = $NameBG/Hero.texture
	$GenderColor/AnimationPlayerSlide.stop(true)
	$NameBG.visible = false
	self.visible = false
	#print(Global.TrainerName)
	#print(Global.TrainerGender)
	get_parent().Resume()
	pass
