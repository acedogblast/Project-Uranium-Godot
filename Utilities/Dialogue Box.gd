extends CanvasLayer

onready var ArrowBottomLeft = preload("res://Graphics/Pictures/Arrow1.png")
onready var ArrowBottomRight = preload("res://Graphics/Pictures/Arrow2.png")
onready var ArrowTopLeft = preload("res://Graphics/Pictures/Arrow3.png")
onready var ArrowTopRight = preload("res://Graphics/Pictures/Arrow4.png")

const TOP = Vector2(10,10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10,280)

signal dialogue_start
signal dialogue_end

var text = []
var text_lines = 0
var current_line = 0
var sliding_text = false
var is_finished = false
var force_arrow = false
var active = false

var dialogue_string = ""
var counter = 0

func load_text(text_array, force_arrow_show):
	text = parse_string(text_array)
	text_lines = text.size()
	force_arrow = force_arrow_show
	pass

func show_arrow(source_vector):
	print(source_vector)
	var arrow_height = 0
	var arrow_width = 0
	if $Box.rect_position == BOTTOM:
		print("bottom")
		arrow_height = 280 - source_vector.y
		arrow_width = int(arrow_height * 1.333)
		if source_vector.x >= 256:
			$Arrow.texture = ArrowBottomRight
			$Arrow.rect_position = Vector2(source_vector.x - arrow_width, source_vector.y)
			pass
		elif source_vector.x < 256:
			$Arrow.texture = ArrowBottomLeft
			$Arrow.rect_position = Vector2(source_vector.x, source_vector.y)
			pass
		pass
	elif $Box.rect_position == TOP:
		print("top")
		if source_vector.x >= 256:
			$Arrow.texture = ArrowTopRight
			$Arrow.rect_position = Vector2(10, 80)
			pass
		elif source_vector.x < 256:
			$Arrow.texture = ArrowTopLeft
			$Arrow.rect_position = Vector2(10, 80)
			pass
		arrow_height = source_vector.y - 80
		arrow_width = source_vector.x - 10
		pass
	$Arrow.rect_size = Vector2(arrow_width,arrow_height)
	$Arrow.visible = true
	pass

func reset():
	for node in [$Box/Text1, $Box/Text2]:
		node.bbcode_enabled = true
		node.bbcode_text = ""
		node.percent_visible = 0
	$Box/AudioStreamPlayer.play()
	$Box/PauseArrow.hide()
	$Box.show()
	is_finished = false
	current_line = 0
	active = true
	pass

func set_dialogue_sequence(text):
	dialogue_string = text + "_D"
	counter = 1

func next_dialogue(show_arrow = true, pos = BOTTOM, point_to = null):
	start_dialog(tr(dialogue_string + str(counter)), show_arrow, pos, point_to)
	counter += 1

func start_dialog(text, show_arrow = true, pos = BOTTOM, point_to = null):
	emit_signal("dialogue_start")
	reset()
	load_text(text, show_arrow)
	$Box.rect_position = pos
	if(point_to):
		show_arrow(point_to)

	if text_lines == 1:
		$Box/Text1.bbcode_text = self.text[0]
		$Box/Text1/AnimationPlayer.play("SingleText")
	else:
		$Box/Text1.bbcode_text = self.text[0]
		$Box/Text2.bbcode_text = self.text[1]
		$Box/Text1/AnimationPlayer.play("MultiText")
	pass
# warning-ignore:unused_argument
func _process(delta):
	if active and Input.is_action_just_pressed("ui_accept") and $Box/Text2/AnimationPlayer.is_playing() == false and $Box/Text1/AnimationPlayer.is_playing() == false:
		if text_lines == 1 and is_finished == true:
				$Box.hide()
				$Arrow.hide()
				active = false
				emit_signal("dialogue_end")
		else:
			if is_finished:
				$Box.hide()
				$Arrow.hide()
				active = false
				emit_signal("dialogue_end")
			else:
				slide_text()
	pass
func slide_text():
	$Box/PauseArrow.hide()
	if not sliding_text:
		if current_line != (text_lines - 2):
			sliding_text = true
			current_line = current_line + 1
			$Box/AnimationPlayer.play("Slide Text")
			yield($Box/AnimationPlayer, "animation_finished")
			$Box/AudioStreamPlayer.play()
		else:
			is_finished = true
	pass
func swap_text():
	var tempText = $Box/Text2.bbcode_text
	$Box/Text1.rect_position = Vector2(17,15)
	$Box/Text2.rect_position = Vector2(17,50)
	$Box/Text1.bbcode_text = tempText
	$Box/Text2.bbcode_text = text[current_line + 1]
	$Box/Text2.percent_visible = 0
	$Box/Text2/AnimationPlayer.play("Text")
	yield($Box/Text2/AnimationPlayer, "animation_finished")
	sliding_text = false
	pass
func load_single_example():
	text = ["This is an example text."]
	text_lines = text.size()
	force_arrow = true
	pass
func load_multi_example():
	text = ["This is an example text.",
	"This is also an example text.",
	"This is the third line",
	"This is the fourth line",
	"This should be the last line of text."]
	text_lines = text.size()
	force_arrow = true
	pass
func load_two_example():
	text = ["This is an example text.",
	"This is also an example text.",]
	text_lines = text.size()
	force_arrow = true
	pass
func second_line_printed():
	if text_lines != 2 and current_line != (text_lines - 2):
		$Box/PauseArrow.show()
	else:
		finished()
	pass
func FirstLinePrinted():
	$Box/Text2/AnimationPlayer.play("Text")
	if text_lines == 1:
		finished()
	pass
func finished():
	if force_arrow == true:
		$Box/PauseArrow.show()
	is_finished = true
	pass

func parse_string(text):
	var expanded_text = expand(text)
	return expanded_text.split("\n")

func expand(text):
	return text.format({"TrainerName": Global.TrainerName})