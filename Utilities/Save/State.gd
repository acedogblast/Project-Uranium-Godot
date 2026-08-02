extends Resource

class_name State

signal state_changed()

@export var game_version = ''
@export var data = {}

func has_key(key):
	return data.has(key)

func get_data(key):
	return data[key]

func update_data(key, _data):
	data[key] = _data
	emit_signal("state_changed")
