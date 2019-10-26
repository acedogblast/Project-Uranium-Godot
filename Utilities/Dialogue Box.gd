extends NinePatchRect
const TOP = Vector2(10,10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10,280)

var text = []
var text_lines = 0
var current_line = 0
var is_finished = false
var force_arrow = false

func load_text(text_array, force_arrow_show):
	text = parse_string(text_array)
	text_lines = text.size()
	force_arrow = force_arrow_show
	pass
func load_rich_Text(text_array, force_arrow_show):
	text = parse_string(text_array)
	text_lines = text.size()
	force_arrow = force_arrow_show
	pass

func _ready():
	$Text1.bbcode_enabled = true
	$Text2.bbcode_enabled = true
	$AudioStreamPlayer.play()
	$Text1.bbcode_text = ""
	$Text2.bbcode_text = ""
	$Text1.percent_visible = 0
	$Text2.percent_visible = 0
	$PauseArrow.hide()
	#loadSingleExample()
	#load_multi_example()
	if text_lines <= 1:
		$Text1.bbcode_text = text[0]
		$Text1/AnimationPlayer.play("SingleText")
	else:
		$Text1.bbcode_text = text[0]
		$Text2.bbcode_text = text[1]
		$Text1/AnimationPlayer.play("MultiText")
	pass
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and $Text2/AnimationPlayer.is_playing() == false and $Text1/AnimationPlayer.is_playing() == false:
		if text_lines == 1 and is_finished == true:
			self.queue_free()
			if is_finished:
				get_parent().dialogEnd()
		else:
			if is_finished:
				get_parent().dialogEnd()
				#self.queue_free()
			else:
				slide_text()
	pass
func slide_text():
	$PauseArrow.hide()
	if current_line != (text_lines - 2):
		current_line = current_line + 1
		$AnimationPlayer.play("Slide Text")
		$AudioStreamPlayer.play()
	else:
		get_parent().dialogEnd()
		#self.queue_free()
	pass
func swap_text():
	var tempText = $Text2.bbcode_text
	$Text1.bbcode_text = ""
	$Text2.bbcode_text = ""
	$Text1.rect_position = Vector2(17,15)
	$Text2.rect_position = Vector2(17,50)
	$Text1.bbcode_text = tempText
	$Text2.percent_visible = 0
	$Text2.bbcode_text = text[current_line + 1]
	$Text2/AnimationPlayer.play("Text")
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
		$PauseArrow.show()
	else:
		finished()
	pass
func FirstLinePrinted():
	$Text2/AnimationPlayer.play("Text")
	if text_lines == 1:
		finished()
	pass
func finished():
	if force_arrow == true:
		$PauseArrow.show()
	is_finished = true
	pass

func parse_string(text):
	var expanded_text = expand(text)
	return expanded_text.split("\n")

func expand(text):
	return text.format({"TrainerName": Global.TrainerName})