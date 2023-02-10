extends Node

const SAVE_STATE = preload('res://Utilities/Save/State.gd')

var SAVE_FOLDER # The location of where the save is stored
var android_external_save_folder : String
var SAVE_NAME_TEMPLATE = "save_%03d.tres"

var save_state : SAVE_STATE

# save_id are to start at 1 to n
# This is to know how many save files there are.

var error_messages = ""

func _ready():
	if OS.is_debug_build():
		SAVE_FOLDER = "res://Utilities/Save"
	else:
		if OS.get_name() == "Android": # Special case for Android for saving in an external directory
			#SAVE_FOLDER = OS.get_external_data_dir().path_join("UraniumSaves") # Crashes for some reason
			# Workaround from: https://github.com/godotengine/godot/issues/23004#issue-369879623
			var has_permissions: bool = false
			
			while not has_permissions:
				var permissions: Array = OS.get_granted_permissions()
				
				if not permissions.has("android.permission.READ_EXTERNAL_STORAGE") or not permissions.has("android.permission.WRITE_EXTERNAL_STORAGE"):
					OS.request_permissions()
					await get_tree().create_timer(1).timeout
				else:
					has_permissions = true

			android_external_save_folder = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS, true).path_join("UraniumSaves")
			
		
		SAVE_FOLDER = "user://"

	save_state = State.new()

func has_state(key):
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
	var save_file_path = SAVE_FOLDER.path_join(SAVE_NAME_TEMPLATE % id)
	if not FileAccess.file_exists(save_file_path):
		print("Save file %s doesn't exist. Creating new save file." % save_file_path)
		var new_save = SAVE_STATE.new()
		return new_save
	print("Loading existing file.")
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	var save_game = load(save_file_path)
	return save_game

func save_file(id):	
	var directory = DirAccess.open(SAVE_FOLDER)
	if not directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)
	
	var save_path = SAVE_FOLDER.path_join(SAVE_NAME_TEMPLATE % id)
	var error = ResourceSaver.save(save_state, save_path)

	if OS.get_name() == "Android":
		# Make another save in external location
		save_path = android_external_save_folder.path_join(SAVE_NAME_TEMPLATE % id)
		error = ResourceSaver.save(save_state, save_path)

	if error != OK:
		print('There was an issue writing the save %s to %s' % [id, save_path])

func get_number_of_saves():
	var directory = DirAccess.open(SAVE_FOLDER)

	var dir = directory.open(SAVE_FOLDER)

	if dir.get_open_error() != 0:
		print("Error opening save folder")
		error_messages += "Error opening save folder\n"
		print("Error code: %d" % str(dir.get_open_error()))
		error_messages += "Error code: %d\n" % str(dir.get_open_error())
		return 0

	var num = 0
	while directory.file_exists(SAVE_NAME_TEMPLATE % (num + 1)):
		num += 1
	return num
