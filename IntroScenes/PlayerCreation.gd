extends Node

var lastAnimationPos = 0.0
var lastAnimation = null

onready var dialogBox = preload("res://Utilities/Dialogue Box.tscn")
onready var dialog = null


func FirstD():
	newdialog([
	"Huh? Who is it?", 
	"Oh, hello there!",
	"Welcome to the world of Pokémon!"
	],false)
	pass
func FadeBombo():
	#print("FadeBombo")
	Pause()
	$Bombo/AnimationPlayer.play("FadeBombo")
	pass
func Dp1():
	newdialog([
	"My name is Bamb'o.", 
	"",
	], true)
	pass
func Dp2():
	newdialog([
	"...Er, but if you find that hard to",
	"pronounce, you can just call me the",
	"Pokémon Professor."
	], true)
	pass
func Dp3():
	newdialog([
	"You're the kid who's applying for a job,",
	"right?"
	], true)
	pass
func Dp4():
	newdialog([
	"Great!"
	], false)
	pass
func Dp5():
	newdialog([
	"I'll have you journey across the region,",
	"collecting specimens for my research.",
	"Along the way, you're sure to encounter",
	"all kinds of people.",
	"Some will be willing to cooperate and",
	"some not, but you should try",
	"and be friendly with everybody.",
	"We don't want a bad reputation, right?",
	"People will ask for your help solving",
	"mysteries or lending them a hand when",
	"they're down.",
	"And it won't be easy ---",
	"there's dangers everywhere.",
	"Whether it be wild creatures or people with",
	"ill intent, you'll need to be on your guard.",
	"But keep a clear head on your shoulders,",
	"kid, and I'm sure you'll pull through just",
	"fine."
	], false)
	pass
func PlayBomboSlide():
	Pause()
	$Bombo/AnimationPlayer.play("BomboSlideOut")
	pass
func Dp6():
	newdialog([
	"We humans share this world with",
	"creatures know as Pokémon.",
	"More than mere animals, Pokémon possess",
	"astonishing powers and remarkable",
	"intelligence.",
	"People and Pokémon coexist in many ways.",
	"Some Pokémon are kept as pets,",
	"others help us with work, and still others",
	"are used in battle by Trainers such as",
	"yourself."
	], false)
	pass	
func SlideBack():
	Pause()
	$Bombo/AnimationPlayer.play("BomboSlideBack")
	pass
func Dp7():
	newdialog([
	"But there's so much we still",
	"don't know about Pokémon.",
	"That's my job! I study Pokémon for a living.",
	"Specifically, I'm an expert on Pokémon",
	"elements.",
	"Every Pokémon has an elemental type,",
	"and each type has its own strengths and",
	"weaknesses.",
	"But... why do they exist?",
	"Are there new types we haven't discovered",
	"yet?",
	"Ah, but I'll tell you more at",
	"your first day on the job.",
	"Report to my lab tomorrow to",
	"get your first Pokémon.",
	"Now, if you'd just fill out this form here..."
	], false)
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
func newdialog(var text, var forceArrow):
	Pause()
	dialog = dialogBox.instance()
	dialog.loadText(text, forceArrow)
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
	newdialog([
	Global.TrainerName + ", are you ready?",
	"Your journey --- your story",
	"--- is about to unfold",
	"The future is a blank slate. You, together",
	"with your Pokémon, are going to fill it.",
	"There will be challenges and thrills, and",
	"you're bound to make exciting discoveries.",
	"Let's go!"
	], false)
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