extends Node

const SAVE_STATE = preload('res://Utilities/Save/State.gd')

var SAVE_FOLDER = "user://debug/save"
var SAVE_NAME_TEMPLATE = "save_%03d.tres"

var save_state : SAVE_STATE

func has_state(var key):
	return save_state.has_key(key)

func get_state(key):
	return save_state.get_data(key)

func set_state(key, state):
	save_state.update_data(key, state)

func load_game(save_id):
	save_state = load_file(save_id)
	for node in get_tree().get_nodes_in_group("save"):
		node.load_state()

func save_game(save_id):
	for node in get_tree().get_nodes_in_group("save"):
		node.save_state()
	save_file(save_id)

func load_file(id):
	var save_file_path = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var file : File = File.new()
	if not file.file_exists(save_file_path):
		print("Save file %s doesn't exist. Creating new save file." % save_file_path)
		var new_save = SAVE_STATE.new()
		return new_save
	var save_game = load(save_file_path)
	return save_game

func save_file(id):	
	var directory : Directory = Directory.new()
	if not directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)
	
	var save_path = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var error = ResourceSaver.save(save_path, save_state)
	if error != OK:
		print('There was an issue writing the save %s to %s' % [id, save_path])