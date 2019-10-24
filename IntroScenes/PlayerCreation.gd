extends Node

var lastAnimationPos = 0.0
var lastAnimation = null

onready var dialogBox = preload("res://Utilities/Dialogue Box.tscn")
onready var dialog = null


func FirstD():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D1"),false)
	pass
func FadeBombo():
	#print("FadeBombo")
	Pause()
	$Bombo/AnimationPlayer.play("FadeBombo")
	pass
func Dp1():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D2"), true)
	pass
func Dp2():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D3"), true)
	pass
func Dp3():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D4"), true)
	pass
func Dp4():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D5"), false)
	pass
func Dp5():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D6"), false)
	pass
func PlayBomboSlide():
	Pause()
	$Bombo/AnimationPlayer.play("BomboSlideOut")
	pass
func Dp6():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D7"), false)
	pass	
func SlideBack():
	Pause()
	$Bombo/AnimationPlayer.play("BomboSlideBack")
	pass
func Dp7():
	new_dialog(tr("CUTSCENE_PLAYERCREATION_D8"), false)
	pass	
func ShowGenderSelect():
	Pause()
	$GenderSelect.Start()
	$GenderSelect/AnimationPlayer.play("FadeIn")
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
func new_dialog(var text, var forceArrow):
	Pause()
	dialog = dialogBox.instance()
	dialog.load_text(text, forceArrow)
	add_child(dialog)
	pass
func dialogEnd():
	#print("dialog ended")
	dialog.queue_free()
	Resume()
	pass
func Play035Cry():
	$Bombo/P035/AudioStreamPlayer.play()
	pass
func SlideFinished():
	Resume()
	pass
var blue = preload("res://Graphics/Pictures/Gender/genderboy.png")
var green = preload("res://Graphics/Pictures/Gender/genderneutral.png")
var red = preload("res://Graphics/Pictures/Gender/gendergirl.png")
var GenderBack = preload("res://Graphics/Pictures/Gender/genderbg2.png")
var Boy = preload("res://Graphics/Characters/trainer000.PNG")
var Neutral = preload("res://Graphics/Characters/trainer009.png")
var Girl = preload("res://Graphics/Characters/trainer001.png")
func Final():
	$BackGround.texture = GenderBack
	$Bombo.visible = false
	if Global.TrainerGender == 0:
		$GenderColor.texture = blue
		$GenderColor/Hero.texture = Boy
	if Global.TrainerGender == 1:
		$GenderColor.texture = green
		$GenderColor/Hero.texture = Neutral
	if Global.TrainerGender == 2:
		$GenderColor.texture = red
		$GenderColor/Hero.texture = Girl
	$GenderColor.rect_size = Vector2(512,384)
	$GenderColor.stretch_mode = TextureRect.STRETCH_TILE
	$GenderColor.visible = true
	new_dialog(tr("CUTSCENE_PLAYERCREATION_FINISH"), false)
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	changeScene("res://IntroScenes/FirstStoryCutScene.tscn")
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass