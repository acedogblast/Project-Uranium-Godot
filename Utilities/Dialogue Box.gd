extends CanvasLayer

onready var ArrowBottomLeft = preload("res://Graphics/Pictures/Arrow1.png")
onready var ArrowBottomRight = preload("res://Graphics/Pictures/Arrow2.png")
onready var ArrowTopLeft = preload("res://Graphics/Pictures/Arrow3.png")
onready var ArrowTopRight = preload("res://Graphics/Pictures/Arrow4.png")

enum mode {
	SingleText,
	MultiText
}

const TOP = Vector2(10, 10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10, 280)

signal dialogue_start
signal dialogue_end

var text = []
var events = []
var current_event
var pos = 0
var text_lines = 0
var current_line = 0
var sliding_text = false
var is_finished = false
var force_arrow = false
var active = false

# Text formatting to copy to line below
var format_to_copy = ""

# Current text-mode: single or multi
var currentMode

var dialogue_string = ""
var counter = 0

func _ready():
	$Box.hide()

	#start_dialog(tr("TEST_SLOW_OUTPUT"))

func rescale_mobile(deviceSize):
	offset.x = (deviceSize.x - (deviceSize.y * 1.333)) / 2
	var boxRatio = ProjectSettings.get_setting("display/window/size/width") / $Box.rect_size.x
	var scale = deviceSize.y * 1.333 / boxRatio / $Box.rect_size.x
	
	self.scale.x = scale
	self.scale.y = scale

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
	format_to_copy = ""
	pos = 0
	events = []
	current_event = null
	pass

func set_dialogue_sequence(sequence):
	dialogue_string = sequence + "_D"
	counter = 1

func next_dialogue(show_arrow = true, pos = BOTTOM, point_to = null):
	start_dialog(tr(dialogue_string + str(counter)), show_arrow, pos, point_to)
	counter += 1

func start_dialog(text, show_arrow = true, pos = BOTTOM, point_to = null):
	emit_signal("dialogue_start")
	reset()
	load_text(text, show_arrow)
	pop_event()

	$Box.rect_position = pos
	if(point_to):
		show_arrow(point_to)

	if text_lines == 1:
		$Box/Text1.bbcode_text = self.text[0]
		currentMode = mode.SingleText
	else:
		$Box/Text1.bbcode_text = self.text[0]
		format_to_copy = TextParser.get_last_format(self.text[0])
		$Box/Text2.bbcode_text = format_to_copy + self.text[1]
		currentMode = mode.MultiText

	$Box/TypeDelay.start()
	active = true
	pass
# warning-ignore:unused_argument
func _process(delta):
	if active and Input.is_action_just_pressed("ui_accept") and $Box/TypeDelay.is_stopped():
		if is_finished == true:
			$Box.hide()
			$Arrow.hide()
			active = false
			emit_signal("dialogue_end")
		elif currentMode == mode.MultiText:
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
	if text_lines > 1:
		var tempText = $Box/Text2.bbcode_text
		$Box/Text1.rect_position = Vector2(17,15)
		$Box/Text2.rect_position = Vector2(17,50)
		$Box/Text1.bbcode_text = tempText
		format_to_copy = TextParser.get_last_format(tempText)
		$Box/Text2.bbcode_text = format_to_copy + text[current_line + 1]
		$Box/Text1.visible_characters = $Box/Text2.visible_characters
		$Box/Text2.visible_characters = 0
		$Box/TypeDelay.start()
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
func finished():
	if force_arrow == true:
		$Box/PauseArrow.show()
	is_finished = true
	pass

func parse_string(text):
	var returns = TextParser.extract_events(TextParser.expand(text), $Box/TypeDelay)
	var expanded_text = returns[0].split("\n")
	events = returns[1]

	# We need this while loop, because the size of the array
	# might change when text wrapping occurs
	var size_changed = true
	while size_changed:
		size_changed = false
		for index in expanded_text.size():
			var stripped_text_line = TextParser.strip_metadata(expanded_text[index])
			var text_line = expanded_text[index]
			# If text wraps, we move the last word to the next line, until it no longer overflows
			while $Box/Text1.get_font("normal_font").get_string_size(stripped_text_line).x > $Box/Text1.rect_size.x:
				var stripped_last_word = stripped_text_line.rsplit(" ", false, 1)[-1]
				var last_word = text_line.rsplit(" ", false, 1)[-1]
				# If the word itself is bigger than the text box, we exit the loop to prevent infinite tries of wrapping
				if($Box/Text1.get_font("normal_font").get_string_size(last_word).x > $Box/Text1.rect_size.x):
					break
				stripped_text_line = stripped_text_line.substr(0, stripped_text_line.length() - stripped_last_word.length() - 1)
				text_line = text_line.substr(0, text_line.length() - last_word.length() - 1)
				# If this was the last line, we need another one. We also notify size has changed
				if (index + 1) >= expanded_text.size():
					size_changed = true
					expanded_text.append("")
				expanded_text[index + 1] = expanded_text[index + 1].insert(0, last_word + " ")

				expanded_text[index] = text_line

	for index in expanded_text.size():
		expanded_text[index] = TextParser.parse_text(expanded_text[index])
	return expanded_text

func _on_TypeDelay_timeout():
	if($Box/Text1.visible_characters != $Box/Text1.text.length()):
		$Box/Text1.visible_characters += 1
		pos += 1
		while(current_event != null and current_event.pos == pos):
			yield(current_event.on_event(), "completed")
			pop_event()
	else:
		if(currentMode == mode.SingleText):
			$Box/TypeDelay.stop()
			finished()
		elif(currentMode == mode.MultiText):
			if($Box/Text2.visible_characters != $Box/Text2.text.length()):
				$Box/Text2.visible_characters += 1
				pos += 1
				while(current_event != null and current_event.pos == pos):
					yield(current_event.on_event(), "completed")
					pop_event()
			else:
				$Box/TypeDelay.stop()
				second_line_printed()

func pop_event():
	current_event = null
	if not events.empty():
		current_event = events[0]
		events.remove(0)