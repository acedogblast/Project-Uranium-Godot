extends Node
onready var NuclearPlantMusic = preload("res://Audio/BGM/PU-Nuclear Plant.ogg")
onready var SpecialPokeMusic = preload("res://Audio/BGM/PU-Specialpoke.ogg")
onready var AlarmMusic = preload("res://Audio/BGS/Emergency Civil Defense Alarm [Air Raid Siren].ogg")
onready var EnteringDoor = preload("res://Audio/SE/Entering Door.wav")
onready var ExitingDoor = preload("res://Audio/SE/Exit Door.WAV")
onready var EarthQuakeSound = preload("res://Audio/SE/131-Earth03.ogg")
onready var EmotionSound = preload("res://Audio/SE/SE_EM.wav")
onready var ExplosionSound = preload("res://Audio/SE/049-Explosion02.ogg")
onready var ArrowBottomLeft = preload("res://Graphics/Pictures/Arrow1.png")
onready var ArrowBottomRight = preload("res://Graphics/Pictures/Arrow2.png")
onready var ArrowTopLeft = preload("res://Graphics/Pictures/Arrow3.png")
onready var ArrowTopRight = preload("res://Graphics/Pictures/Arrow4.png")
onready var EmotionIcon = preload("res://Graphics/Animations/029-Emotion01.png")

var lastAnimationPos = 0.0
var lastAnimation = null
var TrainerName = ""
const TOP = Vector2(10,10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10,280)

onready var dialogBox = preload("res://Utilities/Dialogue Box.tscn")
onready var dialog = null

func _ready():
	$AnimationPlayer.play("Story")
	TrainerName = Global.TrainerName
	pass

#func _process(delta):
#	pass
func d1():
	new_dialog(tr("CUTSCENE_INTRO_D1"), true)
	dialog.rect_position = MIDDLE
	pass
	
func d2():
	new_dialog(tr("CUTSCENE_INTRO_D2"), false)
	dialog.rect_position = BOTTOM
	pass
func d3():
	new_dialog(tr("CUTSCENE_INTRO_D3"), false)
	dialog.rect_position = BOTTOM
	pass
func d4():
	new_dialog(tr("CUTSCENE_INTRO_D4"), true)
	dialog.rect_position = MIDDLE
	pass	
func d5():
	new_dialog(tr("CUTSCENE_INTRO_D5"), true)
	dialog.rect_position = MIDDLE
	pass
func d6():
	new_dialog(tr("CUTSCENE_INTRO_D6"), false)
	dialog.rect_position = MIDDLE
	pass
func d7():
	new_dialog(tr("CUTSCENE_INTRO_D7"), false)
	dialog.rect_position = MIDDLE
	pass
func d8():
	new_dialog(tr("CUTSCENE_INTRO_D8"), false)
	dialog.rect_position = MIDDLE
	pass
func d9():
	stopLucilleAni()
	$Lucille.frame = 8
	new_dialog(tr("CUTSCENE_INTRO_D9"), false)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d10():
	$Room/Cam.frame = 4
	new_dialog(tr("CUTSCENE_INTRO_D10"), false)
	ShowArrow($Room.to_global($Room/Cam.position), BOTTOM)
	pass
func d11():
	new_dialog(tr("CUTSCENE_INTRO_D11"), false)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d12():
	$Lucille.frame = 4
	new_dialog(tr("CUTSCENE_INTRO_D12"), false)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d13():
	new_dialog(tr("CUTSCENE_INTRO_D13"), false)
	ShowArrow($Room.to_global($Room/Scientist2.position), BOTTOM)
	pass
func d14():
	stopLucilleAni()
	$Lucille.frame = 12
	new_dialog(tr("CUTSCENE_INTRO_D14"), false)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d15():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam.frame = 12
	new_dialog(tr("CUTSCENE_INTRO_D15"), false)
	ShowArrow($Room.to_global($Room/Cam.position), BOTTOM)
	pass
func d16():
	new_dialog(tr("CUTSCENE_INTRO_D16"), true)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d17():
	new_dialog(tr("CUTSCENE_INTRO_D17"), false)
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d18():
	new_dialog(tr("CUTSCENE_INTRO_D18"), false)
	dialog.rect_position = TOP
	ShowArrow($Room.to_global($Room/Cam.position), TOP)
	pass
func d19():
	new_dialog(tr("CUTSCENE_INTRO_D19"), false)
	dialog.rect_position = BOTTOM
	ShowArrow($Lucille.position, BOTTOM)
	pass
func d20():
	new_dialog(tr("CUTSCENE_INTRO_D20"), false)
	dialog.rect_position = TOP
	ShowArrow($Room.to_global($Room/Cam.position), TOP)
	pass
func d21():
	new_dialog(tr("CUTSCENE_INTRO_D21"), false)
	dialog.rect_position = MIDDLE
	pass
func d22():
	new_dialog(tr("CUTSCENE_INTRO_D22"), true)
	dialog.rect_position = MIDDLE
	pass
func d23():
	new_dialog(tr("CUTSCENE_INTRO_D23"), true)
	dialog.rect_position = MIDDLE
	pass
func d24():
	new_dialog(tr("CUTSCENE_INTRO_D24"), false)
	dialog.rect_position = BOTTOM
	pass
func d25():
	new_dialog(tr("CUTSCENE_INTRO_D25"), false)
	dialog.rect_position = MIDDLE	
	pass	
func d26():
	new_dialog(tr("CUTSCENE_INTRO_D26"), false)
	dialog.rect_position = MIDDLE	
	pass	
func final():
	changeScene("res://Maps/Moki Town/HeroHome.tscn")
	pass
func EarthShake():
	$Camera2D/AnimationPlayer.play("Shake")
	$AudioStreamPlayer3.stream = EarthQuakeSound
	$AudioStreamPlayer3.play()
	pass
func ShakeEnd():
	$Room/Scientist1/AlertEM.visible = true
	$Room/Scientist2/AlertEM.visible = true
	$Room/Scientist3/AlertEM.visible = true
	$Room/Cam/AlertEM2.visible = true
	$Lucille/AlertEM.visible = true
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = SpecialPokeMusic
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer2.stream = AlarmMusic
	$AudioStreamPlayer2.play()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer3.stream = EmotionSound
	$AudioStreamPlayer3.play()
	pass
func FlashRedAlert():
	$RedAlert/AnimationPlayer.play("Flashing")
	pass
func EndEM():
	$Room/Scientist1/AlertEM.visible = false
	$Room/Scientist2/AlertEM.visible = false
	$Room/Scientist3/AlertEM.visible = false
	$Room/Cam/AlertEM2.visible = false
	$Lucille/AlertEM.visible = false
	pass
func ScientistMove1():
	$Room/Scientist1/AnimationPlayer.play("WalkRight")
	$Room/Scientist3/AnimationPlayer.play("WalkLeft")
	pass
func ScientistMove2():
	$Room/Scientist1/AnimationPlayer.play("WalkAhead")
	$Room/Scientist3/AnimationPlayer.play("WalkForward")
	pass
func ScientistMove3():
	$Room/Scientist1/AnimationPlayer.stop()
	$Room/Scientist1.frame = 12
	$Room/Scientist3/AnimationPlayer.stop()
	$Room/Scientist3.frame = 12
	pass
func ScientistMove4():
	$Room/Scientist1/AnimationPlayer.stop()
	$Room/Scientist2/AnimationPlayer.stop()
	$Room/Scientist3/AnimationPlayer.stop()
	$Room/Scientist1/AnimationPlayer.play("WalkRight")
	$Room/Scientist2/AnimationPlayer.play("WalkAhead")
	$Room/Scientist3/AnimationPlayer.play("WalkLeft")
	pass
func ScientistMove5():
	$Room/Scientist1/AnimationPlayer.stop()
	$Room/Scientist1/AnimationPlayer.play("WalkAhead")
	pass
func ScientistMove6():
	$Room/Scientist3/AnimationPlayer.stop()
	$Room/Scientist3/AnimationPlayer.play("WalkAhead")
	pass
func ShowArrow(sourceVector2, dialogBoxPosition):
	var arrowHeight = 0
	var arrowWidth = 0
	if dialogBoxPosition == BOTTOM:
		arrowHeight = 280 - sourceVector2.y
		arrowWidth = int(arrowHeight * 1.333)
		if sourceVector2.x >= 256:
			$Arrow.texture = ArrowBottomRight
			$Arrow.rect_position = Vector2(sourceVector2.x - arrowWidth, sourceVector2.y)
			pass
		elif sourceVector2.x < 256:
			$Arrow.texture = ArrowBottomLeft
			$Arrow.rect_position = Vector2(sourceVector2.x, sourceVector2.y)
			pass
		pass
	elif dialogBoxPosition == TOP:
		if sourceVector2.x >= 256:
			$Arrow.texture = ArrowTopRight
			$Arrow.rect_position = Vector2(10, 80)
			pass
		elif sourceVector2.x < 256:
			$Arrow.texture = ArrowTopLeft
			$Arrow.rect_position = Vector2(10, 80)
			pass
		arrowHeight = sourceVector2.y - 80
		arrowWidth = sourceVector2.x - 10
		pass
	$Arrow.rect_size = Vector2(arrowWidth,arrowHeight)
	$Arrow.visible = true
	pass
func openDoorSound():
	$AudioStreamPlayer2.stream = EnteringDoor
	$AudioStreamPlayer2.play()
	pass
func exitDoorSound():
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer3.stream = ExitingDoor
	$AudioStreamPlayer3.play()
	pass
func stopLucilleAni():
	$Lucille/AnimationPlayer.stop()
	pass
func LucilleWalkForward():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play('WalkForward')
	pass
func LucilleWalkRight():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play("WalkRight")
	pass
func LucilleWalkLeft():
	$Lucille/AnimationPlayer.stop()
	$Lucille/AnimationPlayer.play("WalkLeft")
	pass
func CamWalkLeft():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam/AnimationPlayer.play("WalkLeft")
	pass
func CamMove2():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam/AnimationPlayer.play("WalkAhead")
	pass
func CamMove3():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam/AnimationPlayer.play("WalkLeft")
	pass
func CamMove4():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam/AnimationPlayer.play("WalkAhead")
	pass
func CamMove5():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam.frame = 12
	pass
func CamMove6():
	$Room/Cam/AnimationPlayer.stop()
	$Room/Cam.frame = 0
	
	pass
func explosion():
	$RedAlert/AnimationPlayer.stop()
	$RedAlert/AnimationPlayer.play("Explosion")
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer3.stop()
	$AudioStreamPlayer3.stream = ExplosionSound
	$AudioStreamPlayer3.play()
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
	$Arrow.visible = false
	Resume()
	pass
func playNuclearPlantMusic():
	$AudioStreamPlayer.stream = NuclearPlantMusic
	$AudioStreamPlayer.play()
	
	pass
func changeScene(scene):
	if Global.isMobile:
		get_parent().newScene(scene)
	else:
		get_tree().change_scene(scene)
	pass