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
		if key == "BackSpace":
			$Name.text = str($Name.text).substr(0, str($Name.text).length() - 1)
		if key == "Enter":
			if $Name.text != "":
				get_parent().NameResult($Name.text)
	pass
