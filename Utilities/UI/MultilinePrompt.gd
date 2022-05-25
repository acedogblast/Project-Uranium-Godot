extends CanvasLayer

var lines : int = 1
var size : Vector2 = Vector2(100, 110)
var selected_line : int = 0 # 0 is first, 1 is second, etc.
var mode : int = 0 # 0 is disabled, 1 is enabled

signal selected

func _ready():
	# Testing
	#setup("Yes,No,SuppeerLongLine", Vector2())
	#mode = 1

	pass

func setup(text_lines : String, given_size, screen_position : Vector2):
	$Node2D.position = screen_position
	var split_lines = text_lines.split(",")
	self.lines = split_lines.size()

	# Add Lable nodes
	var i = 0
	for line in split_lines:
		var label = Label.new()
		label.name = str(i)
		label.text = line
		label.rect_position = Vector2(0, i * 35)
		label.set("custom_fonts/font", load("res://Utilities/Battle/MoveTextFont.tres"))
		$Node2D/Lines.add_child(label)
		i += 1

	# Adjust size of prompt
	if given_size != Vector2(0,0) && given_size != null:
		#Use given size
		self.size = given_size
		$Node2D/NinePatchRect.rect_size = given_size
	else:
		# Calculate size
		var new_size = Vector2()
		new_size.y = 40 # Borders
		new_size.y += lines * 35 # Each line is 35px tall

		new_size.x = 30 # Borders

		# Get the longest lines
		var long = 0
		for label in $Node2D/Lines.get_children():
			if label.rect_size.x > long:
				long = label.rect_size.x
			pass
		new_size.x += long
		self.size = new_size
		$Node2D/NinePatchRect.rect_size = new_size
	mode = 1
	return $Node2D/NinePatchRect.rect_size

func setup_BLC(text_lines : String, given_size, screen_position : Vector2): # Like setup exect screen_position is bottom left corner
	var split_lines = text_lines.split(",")
	self.lines = split_lines.size()

	# Add Lable nodes
	var i = 0
	for line in split_lines:
		var label = Label.new()
		label.name = str(i)
		label.text = line
		label.rect_position = Vector2(0, i * 35)
		label.set("custom_fonts/font", load("res://Utilities/Battle/MoveTextFont.tres"))
		$Node2D/Lines.add_child(label)
		i += 1

	# Adjust size of prompt
	if given_size != Vector2(0,0) && given_size != null:
		#Use given size
		self.size = given_size
		$Node2D/NinePatchRect.rect_size = given_size
	else:
		# Calculate size
		var new_size = Vector2()
		new_size.y = 40 # Borders
		new_size.y += lines * 35 # Each line is 35px tall

		new_size.x = 30 # Borders

		# Get the longest lines
		var long = 0
		for label in $Node2D/Lines.get_children():
			if label.rect_size.x > long:
				long = label.rect_size.x
			pass
		new_size.x += long
		self.size = new_size
		$Node2D/NinePatchRect.rect_size = new_size
	$Node2D.position = screen_position - Vector2(0, $Node2D/NinePatchRect.rect_size.y)
	mode = 1
	return $Node2D/NinePatchRect.rect_size

func _input(event):
	if mode == 1:
		if event.is_action_pressed("ui_down"):
			if selected_line < lines - 1:
				selected_line += 1
				$Node2D/Select/AudioStreamPlayer.play()
				update_select()
		
		if event.is_action_pressed("ui_up"):
			if selected_line > 0:
				selected_line -= 1
				$Node2D/Select/AudioStreamPlayer.play()
				update_select()

		if event.is_action_pressed("ui_accept"):
			$Node2D/Select/AudioStreamPlayer.play()
			mode = 0
			yield($Node2D/Select/AudioStreamPlayer, "finished")
			emit_signal("selected")
			$Node2D.hide()
func update_select():
	$Node2D/Select.rect_position = Vector2(10,18 + 35 * selected_line)
func get_size(): # Must be called after setup
	return $Node2D/NinePatchRect.rect_size
func show():
	$Node2D.show()
func hide():
	$Node2D.hide()
func set_width(var width):
	$Node2D/NinePatchRect.rect_size.x = width
