extends CanvasLayer

var stage = 0 # -1 = disabled, 0 = YesNo, 1 = Test
var arrow_pos : int = TOP
enum {TOP, MID, BOT}
var arrow_top = Vector2(12,14)
var arrow_mid = Vector2(12,46)
var arrow_bot = Vector2(12,80)

signal selected

func _ready():
	$YesNo/NinePatchRect/Label1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_1"
	$YesNo/NinePatchRect/Label2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_2"
	$Test/Box/Option1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_3"
	$Test/Box/Option2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_4"
	$Test/Box/Option3.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_5"

	$Test/Box/Option1.modulate = Color(.941, .102, .031)
	$Test/Box/Option2.modulate = Color(.463, .886, .494)
	$Test/Box/Option3.modulate = Color(.161, .325, .757)

	$Test.visible = false
	$YesNo.visible = false

	$PokeGet/Grid.texture.flags = Texture.FLAG_REPEAT
	$PokeGet/Grid2.texture.flags = Texture.FLAG_REPEAT
	$PokeGet/Light.texture.flags = Texture.FLAG_REPEAT


func _input(event):
	match stage:
		0:
			if event.is_action_pressed("ui_down")&& arrow_pos == TOP:
				arrow_pos = BOT
				update_arrow()
			if event.is_action_pressed("ui_up") && arrow_pos == BOT:
				arrow_pos = TOP
				update_arrow()
			if event.is_action_pressed("ui_accept"):
				emit_signal("selected")
				stage = -1

		1:
			if event.is_action_pressed("ui_down") && arrow_pos != BOT:
				arrow_pos += 1
				update_arrow()
			if event.is_action_pressed("ui_up") && arrow_pos != TOP:
				arrow_pos -= 1
				update_arrow()
			if event.is_action_pressed("ui_accept"):
				$Test.visible = false
				emit_signal("selected")
				stage = -1


func update_arrow():
	match stage:
		0:
			match arrow_pos:
				TOP:
					$YesNo/NinePatchRect/Arrow.rect_position = Vector2(14,18)
				BOT:
					$YesNo/NinePatchRect/Arrow.rect_position = Vector2(14,58)
		1:
			match arrow_pos:
				TOP:
					$Test/Box/Arrow.rect_position = arrow_top
				MID:
					$Test/Box/Arrow.rect_position = arrow_mid
				BOT:
					$Test/Box/Arrow.rect_position = arrow_bot
		

func prompt_yes_no():
	stage = 0
	$Test.visible = false
	$YesNo.visible = true
	$ColorRect.visible = false
	yield(self, "selected")
	$YesNo.visible = false
	stage = -1
	#arrow_pos = TOP
	
func get_yes_no_responce() -> bool:
	if arrow_pos == TOP:
		return true
	return false


enum TEST {Q1, Q2, Q3, Q4}
func prompt_test(question):
	var label1 = $Test/Box/Option1
	var label2 = $Test/Box/Option2
	var label3 = $Test/Box/Option3
	$YesNo.visible = false
	arrow_pos = TOP
	call_deferred("update_arrow")
	match question:
		TEST.Q1:
			label1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_3"
			label2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_4"
			label3.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_5"
		TEST.Q2:
			label1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_6"
			label2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_7"
			label3.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_8"
		TEST.Q3:
			label1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_9"
			label2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_10"
			label3.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_11"
		TEST.Q4:
			label1.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_12"
			label2.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_13"
			label3.text = "EVENT_MOKI_LAB_FIRST_POK_OPTION_14"
	$Test.visible = true
	stage = 1

func get_test_responce() -> int:
	print("Arrow Position:" + str(arrow_pos))
	if arrow_pos == TOP:
		return 0
	if arrow_pos == MID:
		return 1
	if arrow_pos == BOT:
		return 2
	return 0

func Poke_get():
	$Test.visible = false
	$YesNo.visible = false
	$PokeGet.visible = false

	$PokeGet/Orchynx.position = Vector2(100,170)
	$PokeGet/Electux.position = Vector2(392,170)
	$PokeGet/Raptorch.position = Vector2(246,170)

	$PokeGet/Orchynx.modulate = Color(0,0,0,1)
	$PokeGet/Electux.modulate = Color(0,0,0,1)
	$PokeGet/Raptorch.modulate = Color(0,0,0,1)


	#Fade
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("Fade")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	emit_signal("selected")


func Poke_get_slide(poke : int):
	var orchynx = $PokeGet/Orchynx/AnimationPlayer
	var electux = $PokeGet/Electux/AnimationPlayer
	var raptorch = $PokeGet/Raptorch/AnimationPlayer

	match poke:
		0:
			orchynx.play("FadeOut")
			electux.play("FadeOut")
			raptorch.play("FadeIn")
			yield(raptorch, "animation_finished")
		1:
			orchynx.play("FadeIn")
			electux.play("FadeOut")
			raptorch.play("FadeOut")

			$PokeGet/Tween.interpolate_property($PokeGet/Orchynx, "position", $PokeGet/Orchynx.position, Vector2(246,170), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$PokeGet/Tween.start()
			yield($PokeGet/Tween, "tween_completed")
		2:
			orchynx.play("FadeOut")
			electux.play("FadeIn")
			raptorch.play("FadeOut")

			$PokeGet/Tween.interpolate_property($PokeGet/Electux, "position", $PokeGet/Electux.position, Vector2(246,170), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$PokeGet/Tween.start()
			yield($PokeGet/Tween, "tween_completed")
	# Play music
	var time = Global.game.get_node("Background_music").get_playback_position()
	Global.game.get_node("Background_music").stop()
	var sound = load("res://Audio/ME/BW_captured.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()

	yield(Global.game.get_node("Effect_music"), "finished")
	Global.game.get_node("Effect_music").stop()
	Global.game.get_node("Background_music").play(time)
	emit_signal("selected")

func fadeout():
	$Test.visible = false
	$YesNo.visible = false

	$ColorRect/AnimationPlayer.play_backwards("Fade")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	
	emit_signal("selected")
