extends Node2D

#Loads the player scene
onready var player = null
var menu
var battle

var start_scene = preload("res://Maps/MokiTown/HeroHome.tscn")
var current_scene = null

var next_scene1 = null
var next_scene2 = null
var next_scene3 = null
var next_scene4 = null

var loaded = false
var isInteracting = false
var canInteract = true # Mabye redundant?
var isTransitioning = false


signal event_dialogue_end

onready var transition = $CanvasLayer/Transition

func _ready():
	Global.game = self
	menu = $CanvasLayer/Menu

	#Makes player an instance of Player, makes it a child, and adds it to the group save
	player = load("res://Utilities/PlayerNew.tscn").instance()
	add_child(player)
	add_to_group("save")

	#If load_game_from_id has a value, then load game from the id
	if Global.load_game_from_id != null:
		SaveSystem.load_game(Global.load_game_from_id)
		#change_scene(current_scene)
	#If the above is false change the scene to start_scene
	else:
		change_scene(start_scene)
	#Sets the player's position to TrainerX and TrainerY, it's z index to 8, facing direction to up
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.z_index = 8
	player.set_facing_direction(player.DIRECTION.UP)
	#DialogueSystem.connect("dialogue_start", self, "set_process", [false])
	#Connects the signal dialogue_end to the method self on dialog_end, sets the load_game_id to null, and lets the player move
	DialogueSystem.connect("dialogue_end", self, "dialog_end")
	Global.load_game_from_id = null
	player.canMove = true
	Global.location = current_scene.place_name

var menu_toggle = false

func _process(_delta):
	#change_menu_text()
	#Quick save
	if Input.is_key_pressed(KEY_F1):
		SaveSystem.save_game(1)
	if current_scene != null && current_scene.type == "Outside" && loaded == false:
		call_deferred("load_seemless")

func change_menu_text():
	if $CanvasLayer/Menu/Place_Text.bbcode_text != current_scene.place_name:
		$CanvasLayer/Menu/Place_Text.bbcode_text = "[center]" + current_scene.place_name + "[/center]"

#Plays the fade animation
func play_anim(fade):
	$CanvasLayer/Transition/AnimationPlayer.play(fade)

#If the current scene is not null, then the current scene is removed as a child
func change_scene(scene): # scene must be loaded!
	if current_scene != null:
		remove_child(current_scene)
	if current_scene is String:
		var new_scene = load(scene)
		current_scene = new_scene.instance()
	else:
		current_scene = scene.instance()

	#Adds the current scene to be a child
	add_child(current_scene)
	for node in get_tree().get_nodes_in_group("transition"):
		node.initialize(self)
	# Load and start background music if available.
	if current_scene.background_music != null:
		var music = load(current_scene.background_music)
		$Background_music.stream = music
		$Background_music.play()

#Gets the destination and direction from Stairs.gd, and goes to the next line
func room_transition(dest, dir):
	#Calls the change_input method from PlayerNew.gd
	player.change_input()
	
	#Calls the transition_visibility method, plays the fade_in animation, and then waits .28 seconds
	transition_visibility()
	play_anim("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	
	#If the dir variable in Stairs.gd is up, then diable the down stairs collision shape and set the trainerx and trainery to dest.x and dest.y repsectively
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = true
		Global.TrainerX = dest.x
		Global.TrainerY = dest.y
	#If the above is false and the dir variable in Stairs.gd is down, then disable the up stairs collistion shape and set the trainerx and trainery to dest.x and dest.y respectively
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = true
		Global.TrainerX = dest.x
		Global.TrainerY = dest.y
	
	#if dir is set to up, then set the player dircetion to 2, and if dir is down, then set the player direction to 1
	if dir == "Up":
		player.direction = 2
	elif dir == "Down":
		player.direction = 1
	
	#Set's the player's position to trainerx and trainery, waits .3 seconds, and then plays the fade_out animation
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	#player.movePrevious()
	yield(get_tree().create_timer(0.3), "timeout")
	play_anim("fade_out")
	
	#Calls the move method from PlayerNew.gd, and passes the true variable, disables input, and waits .3 seconds
	player.move(true)
	#player.movePrevious()
	player.inputDisabled = true
	yield(get_tree().create_timer(0.3), "timeout")
	
	#If the dir variable is up, then disable the downstairs collision shape
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = false
	#If the above is false and the variable is down, then disable the upstairs collision shape 
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = false
	
	#Calls the change_input method from PlayerNew.gd, and calls the transition_visibility method
	player.change_input()
	transition_visibility()
	Global.location = current_scene.place_name

#If the player is not transitioning, then set isTransitioning to true, and call the change_input method, and wait until the transition fade_to_color animation has finished
func door_transition(path_scene, new_position):
	if !isTransitioning:
		isTransitioning = true
		player.change_input()
		#player.canMove = false
		yield(transition.fade_to_color(), "completed")
		
		#Sets the scene variable to load the path_scene
		var scene = load(path_scene)
	
		#Calls the change_scene method
		change_scene(scene)
		
		
		#Sets the trainerx and trainery to new_position.x and new_position.y, and player.position to new_position. Allowing you to appear at the door you went in. Then it waits .3 seconds
		Global.TrainerX = new_position.x
		Global.TrainerY = new_position.y
		player.position = new_position
		#player.direction = 0
		#player.movePrevious()
		yield(get_tree().create_timer(0.3), "timeout")
		
		#Calls the move method and passes true to it. Waits until the transition is done fading from color, then sets the isTransitioning flag to false and calls the change_input method
		player.move(true)
		yield(transition.fade_from_color(), "completed")
		#player.movePrevious()
		isTransitioning = false
		#player.canMove = true
		player.change_input()
		Global.location = current_scene.place_name

#Loads the next scene and adds it to the scene tree
func load_seemless():
	loaded = true
	
	#next_scene1 = get_child(2).next_scene1.instance()
	next_scene1 = load(current_scene.next_scene1)
	next_scene1 = next_scene1.instance()
	next_scene1.position = Vector2(2272,26*32)
	add_child(next_scene1)

#Checks to see if the player is interacting, if not and the interaction title isn't null then is interacting is set to true, the change_input method is called, the play_dialogue method is called, we wait until the dialogue event has ended, and the change_input method is called again
func interaction(collider, direction): # Starts the dialogue instead of the scene script
	if isInteracting == false:
		var interaction_title = current_scene.interaction(collider, direction)
		if interaction_title != null:
			isInteracting = true
			#canInteract = false # Maybe redundant?
			player.change_input()
			#player.canMove = false
			play_dialogue(interaction_title)
			yield(self, "event_dialogue_end")
			player.change_input()
		#If the above is false then print collider
		else:
			print(collider)
	
#Wait .1 second, set isInteracting to false, and emit the signal event_dialogue_end
func dialog_end():
	yield(get_tree().create_timer(0.1), "timeout")
	isInteracting = false
	#player.change_input()
	#player.canMove = true
	emit_signal("event_dialogue_end")
	
#A position check for the node
func check_node(pos):
	for node in get_tree().get_nodes_in_group("interact"):
		if node.position == pos:
			return Node
		pass
	pass

#Sets the transition vanvas layer to be opposite of what it is currently
func transition_visibility():
	$CanvasLayer/Transition.visible = !$CanvasLayer/Transition.visible

func _exit_tree():
	#DialogueSystem.disconnect("dialogue_start", self, "set_process")
	#DialogueSystem.disconnect("dialogue_end", self, "set_process")
	#save_state()
	pass

#saves the state by saving the current_scene, player.position, and player.direction
func save_state():
	var state = {
		"current_scene": current_scene.filename,
		"player_position": player.position,
		"player_direction": player.direction
	}
	SaveSystem.set_state(filename, state)

func load_state(): # Automatically called when loading a save file
	if SaveSystem.has_state(filename):
		var state = SaveSystem.get_state(filename)
		change_scene(load(state["current_scene"]))
		var temp_position = state["player_position"]
		player.direction = state["player_direction"]
		Global.TrainerX = temp_position.x
		Global.TrainerY = temp_position.y
	# else:
	# it uses the default values

func play_dialogue(title): # Plays a dialogue without freezing player
	DialogueSystem.set_point_to(Vector2(0,0))
	DialogueSystem.start_dialog(title)
	
func play_dialogue_with_point(title, vector2): # Plays a dialogue with point and without freezing player
	DialogueSystem.set_point_to(vector2)
	DialogueSystem.start_dialog(title)
