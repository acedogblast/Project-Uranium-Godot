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
	yield(self, "selected")
	$YesNo.visible = false
	stage = -1
	arrow_pos = TOP
	
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
	#yield(self, "selected")
	print("Arrow Position:" + str(arrow_pos))
	if arrow_pos == TOP:
		return 0
	if arrow_pos == MID:
		return 1
	if arrow_pos == BOT:
		return 2
	return 0

