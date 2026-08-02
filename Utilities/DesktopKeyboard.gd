extends Node

var max_length = 30

func setPrompt(prompt):
	$Prompt.text = prompt
func setPicture(picture):
	$Picture.texture = picture
func _input(event):
	if event is InputEventKey and event.is_pressed():
		var key = event.as_text()
		if key.begins_with("Kp ") and $Name.text.length() <= max_length:
			$Name.text = $Name.text + key.substr(3,1)
		if key.begins_with("Shift+") and $Name.text.length() <= max_length:
			$Name.text = $Name.text + key.substr(6,1)
		elif key.length() == 1 and $Name.text.length() <= max_length:
			$Name.text = $Name.text + key.to_lower()
		if event.keycode == KEY_BACKSPACE:
			$Name.text = str($Name.text).substr(0, str($Name.text).length() - 1)
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:
			if $Name.text != "":
				get_parent().NameResult($Name.text)
	pass
