extends Node

var x = 0
var y = 0
var prevSelect = null
var isUpper = false
var max_length = 30

func _ready():
	moveSelector()
	pass
func setPrompt(prompt):
	$Prompt.text = prompt
func setPicture(picture):
	$Picture.texture = picture
func _process(delta):
	if Input.is_action_just_pressed("ui_up") and y != 0:
		y = y - 1
		moveSelector()
	elif Input.is_action_just_pressed("ui_down") and y != 3:
		if (y == 2 and x == 7) or (y == 2 and x == 8):
			pass
		else:
			y = y + 1
			moveSelector()
	elif Input.is_action_just_pressed("ui_left") and x != 0:
		if (x == 9 and y == 3): # OK
			x = 6
			y = 3
			moveSelector()
		else:
			x = x - 1
			moveSelector()
	elif Input.is_action_just_pressed("ui_right") and x != 9:
		if (x == 6 and y == 3): # Case switch
			x = 9
			y = 3
			moveSelector()
		else:
			x = x + 1
			moveSelector()
	if Input.is_action_just_pressed("ui_accept"):
		#print(Vector2(x,y))
		if x == 9 and y == 2: # Case switch
			isUpper = !isUpper
			switchCase()
			pass
		elif x == 9 and y == 3: # OK
			if $Name.text != "":
				get_parent().NameResult($Name.text)
			pass
		else:
			if $Name.text.length() <= max_length:
				$Name.text = $Name.text + getNodeByCord(x,y).text
	
	
	if Input.is_action_just_pressed("x"):
		$Name.text = str($Name.text).substr(0, str($Name.text).length() - 1)
	pass
func getNodeByCord(X, Y):
	var nodePath = null
	if y == 0:
		nodePath = NodePath("Keyboard/Numbers/" + str(X))
	elif y == 1:
		nodePath = NodePath("Keyboard/LetterRow1/" + str(X))
	elif y == 2:
		nodePath = NodePath("Keyboard/LetterRow2/" + str(X))
	elif y == 3:
		nodePath = NodePath("Keyboard/LetterRow3/" + str(X))
	return get_node(nodePath)
	pass
func switchCase():
	#print($Keyboard/Numbers.get_child_count())
	if isUpper == true:
		for node in $Keyboard/LetterRow1.get_children():
			node.text = node.text.to_upper()
		for node in $Keyboard/LetterRow2.get_children():
			node.text = node.text.to_upper()
		for node in $Keyboard/LetterRow3.get_children():
			node.text = node.text.to_upper()
		$Keyboard/LetterRow3/"9".text = tr("UI_KEYBOARD_MOBILE_OK")
		$Keyboard/LetterRow2/"9".text = tr("UI_KEYBOARD_MOBILE_LOWER")
	if isUpper == false:
		for node in $Keyboard/LetterRow1.get_children():
			node.text = node.text.to_lower()
		for node in $Keyboard/LetterRow2.get_children():
			node.text = node.text.to_lower()
		for node in $Keyboard/LetterRow3.get_children():
			node.text = node.text.to_lower()
		$Keyboard/LetterRow3/"9".text = tr("UI_KEYBOARD_MOBILE_OK")
		$Keyboard/LetterRow2/"9".text = tr("UI_KEYBOARD_MOBILE_UPPER")
	pass
func moveSelector():
	if prevSelect == null:
		pass
	else:
		prevSelect.modulate = Color(255,255,255)
		if $Beep.playing == false:
			$Beep.play()
	var letter = getNodeByCord(x, y)
	letter.modulate = Color(255,0,0)
	prevSelect = letter
	pass
