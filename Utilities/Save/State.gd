extends Resource

class_name State

signal state_changed()

export var game_version = ''
export var data = {}

func has_key(var key):
	return data.has(key)

func get_data(var key):
	return data[key]

func update_data(var key, var _data):
	data[key] = _data
	emit_signal("state_changed")
