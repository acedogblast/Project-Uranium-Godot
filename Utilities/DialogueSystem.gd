extends CanvasLayer

onready var ArrowBottomLeft = preload("res://Graphics/Pictures/Arrow1.png")
onready var ArrowBottomRight = preload("res://Graphics/Pictures/Arrow2.png")
onready var ArrowTopLeft = preload("res://Graphics/Pictures/Arrow3.png")
onready var ArrowTopRight = preload("res://Graphics/Pictures/Arrow4.png")

# Used to indicate current text mode
enum mode {
	SingleText,
	MultiText
}

const TOP = Vector2(10, 10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10, 280)

onready var typeTimer = $Box/TypeDelay

signal dialogue_start
signal dialogue_end
signal dialogue_sequence_start
signal dialogue_sequence_end
signal finished_printing

var text = []
var events = []
var current_event
var pos = 0
var text_lines = 0
var current_line = 0
var sliding_text = false
var is_finished = false
var active = false

var force_arrow = false
var point_to = null
var hold = false # If true, prevents the dialogue from closing

# Text formatting to copy to line below
var format_to_copy = ""

# Current text-mode: single or multi
var currentMode

var dialogue_string = ""
var counter = 0

func _ready():
	$Box.hide()

# Internal function: rescales the dialogue box for mobile displays
func rescale_mobile(deviceSize):
	offset.x = (deviceSize.x - (deviceSize.y * 1.333)) / 2
	var boxRatio = ProjectSettings.get_setting("display/window/size/width") / $Box.rect_size.x
	var scale = deviceSize.y * 1.333 / boxRatio / $Box.rect_size.x
	
	self.scale.x = scale
	self.scale.y = scale

	set_box_position(BOTTOM)

# Internal function: loads text
func load_text(text_array):
	text = parse_string(text_array)
	text_lines = text.size()

# Internal function: shows arrow pointing to source_vector
func show_arrow(source_vector):
	var arrow_height = 0
	var arrow_width = 0
	if $Box.rect_position == BOTTOM:
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

# Resets the dialogue system, clearing everything
func reset():
	for node in [$Box/Text1, $Box/Text2]:
		node.bbcode_enabled = true
		node.bbcode_text = ""
		node.percent_visible = 0
	$Box/AudioStreamPlayer.play()
	$Box/PauseArrow.hide()
	$Box.hide()
	is_finished = false
	current_line = 0
	format_to_copy = ""
	pos = 0
	events = []
	current_event = null

# Sets a dialogue sequence, useful for cutscenes
func set_dialogue_sequence(sequence):
	dialogue_string = sequence
	counter = 1

# Starts a dialogue sequence
func start_dialogue_sequence():
	$Box.show()
	emit_signal("dialogue_sequence_start")
	while next_dialogue():
		yield(self, "dialogue_end")
	
	emit_signal("dialogue_sequence_end")

# Show the next dialogue string. set_sequence must have been set
func next_dialogue():
	$Box.show()
	var string = dialogue_string + str(counter)
	if tr(string) == string:
		return false
	start_dialog(dialogue_string + str(counter))
	counter += 1
	return true

func set_show_arrow(show_arrow = true):
	force_arrow = show_arrow

func set_box_position(pos = BOTTOM):
	$Box.rect_position = pos

func set_point_to(point_to = null):
	self.point_to = point_to

# Starts a dialogue text
func start_dialog(text):
	emit_signal("dialogue_start")
	reset()
	load_text(tr(text))
	pop_event()

	if(force_arrow && point_to != null):
		show_arrow(point_to) # Makes arrow visable
	else:
		$Arrow.hide()

	if text_lines == 1:
		$Box/Text1.bbcode_text = self.text[0]
		currentMode = mode.SingleText
	else:
		$Box/Text1.bbcode_text = self.text[0]
		format_to_copy = TextParser.get_last_format(self.text[0])
		$Box/Text2.bbcode_text = format_to_copy + self.text[1]
		currentMode = mode.MultiText
	$Box.show()
	$Box/TypeDelay.start()
	active = true
	pass

# warning-ignore:unused_argument
func _process(delta):
	if active and Input.is_action_just_pressed("ui_accept"):
		if is_finished == true and !hold and $Box/TypeDelay.is_stopped():
			finish_dialogue()
		elif currentMode == mode.MultiText:

			if $Box/TypeDelay.is_stopped():
				slide_text()
				return
			else:
				# Skip printing text
				$Box/TypeDelay.stop()
				if(currentMode == mode.SingleText):
					$Box/Text1.visible_characters = $Box/Text1.text.length()
				else: # Multi-line
					$Box/Text1.visible_characters = $Box/Text1.text.length()
					$Box/Text2.visible_characters = $Box/Text2.text.length()
					second_line_printed()
				pass

func finish_dialogue():
		$Box.hide()
		$Arrow.hide()
		active = false
		emit_signal("dialogue_end")

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

func second_line_printed():
	if text_lines != 2 and current_line != (text_lines - 2):
		$Box/PauseArrow.show()
	else:
		finished()

func finished():
	if force_arrow == true:
		$Box/PauseArrow.show()
	is_finished = true
	emit_signal("finished_printing")

func parse_string(text):
	var returns = TextParser.extract_events(TextParser.expand(text), $Box/TypeDelay)
	var expanded_text = returns[0].split("\n")
	events = returns[1]
	var final_text = []

	# We need this while loop, because the size of the array
	# might change when text wrapping occurs
	for line in expanded_text:
		var text_array = [line]
		var index = 0
		var size_changed = true
		while size_changed:
			size_changed = false
			var text_line = text_array[index]
			var stripped_text_line = TextParser.strip_metadata(text_line)
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
				if (index + 1) >= text_array.size():
					size_changed = true
					text_array.append("")
				text_array[index + 1] = text_array[index + 1].insert(0, last_word + " ")

				text_array[index] = text_line
			index += 1

		for l in text_array:
			final_text.append(TextParser.parse_text(l))
	return final_text

func _on_TypeDelay_timeout():
	while(current_event != null and current_event.pos == pos):
		active = false
		yield(current_event.on_event(), "completed")
		pop_event()
	active = true
	if($Box/Text1.visible_characters < $Box/Text1.text.length()):
		$Box/Text1.visible_characters += 1
		pos += 1
	else:
		if(currentMode == mode.SingleText):
			$Box/TypeDelay.stop()
			finished()
		elif(currentMode == mode.MultiText):
			while(current_event != null and current_event.pos == pos):
				active = false
				yield(current_event.on_event(), "completed")
				pop_event()
			active = true
			if($Box/Text2.visible_characters < $Box/Text2.text.length()):
				$Box/Text2.visible_characters += 1
				pos += 1
			else:
				$Box/TypeDelay.stop()
				second_line_printed()

func pop_event():
	current_event = null
	if not events.empty():
		current_event = events[0]
		events.remove(0)
