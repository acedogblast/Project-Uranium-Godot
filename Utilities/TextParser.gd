extends Node

var last_format_string = ""

class EventSorter:
	static func sort(a, b):
		if a.pos < b.pos:
			return true
		return false

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
	parsed_text = parsed_text.replace("<i>", "[i]")
	parsed_text = parsed_text.replace("</i>", "[/i]")

	return parsed_text

func get_last_format(text):
	var formatCodes = ""
	for bbcode in ["color", "b", "/b", "i", "/i"]:
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
				'<':
					index = text.find(">", index)
				'.':
					pass
				'|':
					pass
		elif text[index] == '<':
			index = text.find(">", index)
		else:
			strippedText += text[index]

		index += 1

	return strippedText

func extract_events(text, timer):
	preload("res://Utilities/Dialogue/Events/WaitEvent.gd")
	preload("res://Utilities/Dialogue/Events/SkipTextEvent.gd")
	var event_array = []
	var extracted_text = text

	var index = 0
	while index < extracted_text.length():
		if extracted_text[index] == "\\":
			if extracted_text[index + 1] != "\\":
				for object in ["|", ".", "wtnp", "wt"]:
					var length = object.length() + 1
					var trueIndex = index
					var newline_index = extracted_text.find('\n', 0)
					while newline_index < index and newline_index != -1:
						trueIndex -= 1
						newline_index = extracted_text.find('\n', newline_index + 1)
					var keyword = extracted_text.find(object, index)
					if keyword != -1 and keyword == index + 1:
						match object:
							"|":
								event_array.push_back(WaitEvent.new(trueIndex, get_tree(), 1))
							".":
								event_array.push_back(WaitEvent.new(trueIndex, get_tree(), 0.25))
							"wt":
								var value = float(extract_arg(extracted_text, index))
								event_array.push_back(WaitEvent.new(trueIndex, get_tree(), value / 20.0))
								length += 2 + str(value).length()
							"wtnp":
								var value = float(extract_arg(extracted_text, index))
								event_array.push_back(WaitEvent.new(trueIndex, get_tree(), value / 20.0))
								event_array.push_back(SkipTextEvent.new(trueIndex, get_tree()))
								length += 2 + str(value).length()

						extracted_text.erase(index, length)
						index -= 1

		index += 1

	# Sort the events array by pos
	return [extracted_text, event_array]

func extract_arg(text, index):
	var bracket_start = text.find("[", index)
	var bracket_end = text.find("]", bracket_start)
	if bracket_start == -1 or bracket_end == -1:
		push_error("Invalid command! No [] brackets found on \"" + text + "\" at reported index " + index)
		get_tree().quit()
	else:
		return text.substr(bracket_start + 1, bracket_end - (bracket_start + 1))

