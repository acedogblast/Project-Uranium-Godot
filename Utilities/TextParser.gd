extends Node

var last_format_string = ""

func parse_text(text):
	var parsed_text = text
	parsed_text = parsed_text.replace("\\c[0]", "[color=white]")
	parsed_text = parsed_text.replace("\\c[1]", "[color=blue]")
	parsed_text = parsed_text.replace("\\c[2]", "[color=red]")
	parsed_text = parsed_text.replace("\\c[3]", "[color=green]")
	parsed_text = parsed_text.replace("\\c[4]", "[color=aqua]")
	parsed_text = parsed_text.replace("\\c[5]", "[color=fuchsia]")
	parsed_text = parsed_text.replace("\\c[6]", "[color=yellow]")
	parsed_text = parsed_text.replace("\\c[7]", "[color=gray]")
	parsed_text = parsed_text.replace("\\c[8]", "[color=white]")
	parsed_text = parsed_text.replace("<b>", "[b]")
	parsed_text = parsed_text.replace("</b>", "[/b]")

	return parsed_text

func get_last_format(text):
	var formatCodes = ""
	for bbcode in ["color", "b", "i"]:
		var startIndex = text.rfind("[" + bbcode)
		if startIndex >= 0:
			var endIndex = text.find("]", startIndex)
			var length = endIndex - startIndex + 1
			formatCodes += text.substr(startIndex, length)
	
	return formatCodes

func expand(text):
	var parsedText = text
	
	parsedText = parsedText.replace("\\PN", Global.TrainerName)
	
	return parsedText

func strip_metadata(text):
	var strippedText = ""
	var index = 0
	while index < text.length():
		if text[index] == '\\':
			index += 1
			match text[index]:
				'\\':
					pass
				'c':
					index = text.find("]", index)
				'.':
					pass
				'|':
					pass
		else:
			strippedText += text[index]

		index += 1

	return strippedText

func extract_events(text, timer):
	preload("res://Utilities/Dialogue/Events/WaitEvent.gd")
	var event_array = []
	var extracted_text = text

	for object in ["\\|", "\\.", "\\wt"]:
		var index = extracted_text.find(object)
		while index != -1:
			match object:
				"\\|":
					event_array.push_back(WaitEvent.new(index, get_tree(), 1, timer))
				"\\.":
					event_array.push_back(WaitEvent.new(index, get_tree(), 0.25, timer))
				#"\\wt":
				#	var value = extract_arg(extracted_text, index)
			
			extracted_text.erase(index, object.length())
			index = extracted_text.find(object)

	return [extracted_text, event_array]

#func extract_arg(text, index)