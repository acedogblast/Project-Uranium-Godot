extends Node

var lastAnimationPos = 0.0
var lastAnimation = null

#onready var dialogBox = preload("res://Utilities/Dialogue Box.tscn")
#onready var dialog = null

func _ready():
	DialogueSystem.connect("dialogue_start", self, "pause")
	DialogueSystem.connect("dialogue_end", self, "resume")
	DialogueSystem.set_dialogue_sequence("CUTSCENE_PLAYERCREATION_D")

func _exit_tree():
	DialogueSystem.disconnect("dialogue_start", self, "pause")
	DialogueSystem.disconnect("dialogue_end", self, "resume")

func dialogue(show_arrow = true):
	DialogueSystem.set_show_arrow(show_arrow)
	DialogueSystem.next_dialogue()
	pass
func fade_bombo():
	#print("fade_bombo")
	pause()
	$Bombo/AnimationPlayer.play("FadeBombo")
	pass
func play_bombo_slide():
	pause()
	$Bombo/AnimationPlayer.play("BomboSlideOut")
	pass
func slide_back():
	pause()
	$Bombo/AnimationPlayer.play("BomboSlideBack")
	pass
func show_gender_select():
	pause()
	$GenderSelect.Start()
	$GenderSelect/AnimationPlayer.play("FadeIn")
	pass
func pause():
	lastAnimationPos = $AnimationPlayer.current_animation_position
	lastAnimation = $AnimationPlayer.current_animation
	$AnimationPlayer.stop(false)
	#print("paused")
	pass
func resume():
	$AnimationPlayer.play(lastAnimation)
	$AnimationPlayer.seek(lastAnimationPos)
	#print("resumed")
	pass
func play_035_cry():
	$Bombo/P035/AudioStreamPlayer.play()
	pass
func slide_finished():
	resume()
	pass
var blue = preload("res://Graphics/Pictures/Gender/genderboy.png")
var green = preload("res://Graphics/Pictures/Gender/genderneutral.png")
var red = preload("res://Graphics/Pictures/Gender/gendergirl.png")
var GenderBack = preload("res://Graphics/Pictures/Gender/genderbg2.png")
var Boy = preload("res://Graphics/Characters/trainer000.PNG")
var Neutral = preload("res://Graphics/Characters/trainer009.png")
var Girl = preload("res://Graphics/Characters/trainer001.png")
func final():
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
	DialogueSystem.set_show_arrow(false)
	DialogueSystem.start_dialog("CUTSCENE_PLAYERCREATION_FINISH")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	change_scene("res://IntroScenes/FirstStoryCutScene.tscn")
	pass
func change_scene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass
