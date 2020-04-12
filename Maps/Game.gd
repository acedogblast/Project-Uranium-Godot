extends Node2D

onready var Player = preload("res://Utilities/PlayerNew.tscn")
onready var player = null

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
	$CanvasLayer/Menu.visible = false
	
	add_to_group("save")
	SaveSystem.load_game(1)
	
	player = Player.instance()
	add_child(player)
	change_scene(start_scene)
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.z_index = 8
	player.set_facing_direction(player.DIRECTION.UP)

	#DialogueSystem.connect("dialogue_start", self, "set_process", [false])
	DialogueSystem.connect("dialogue_end", self, "dialog_end")

func _process(delta):
	#change_menu_text()
	if Input.is_key_pressed(KEY_F1):
		SaveSystem.save_game(1)
	if Input.is_action_just_pressed("x"):
		player.change_input()
		$CanvasLayer/Menu.visible = !$CanvasLayer/Menu.visible
		$CanvasLayer/Menu.open = !$CanvasLayer/Menu.open
		yield(get_tree().create_timer(0.4), "timeout")
	#if get_child(2).type == "Outside" && loaded == false:
	if current_scene.type == "Outside" && loaded == false:
		load_seemless()

func change_menu_text():
	if $CanvasLayer/Menu/Place_Text.bbcode_text != current_scene.place_name:
		$CanvasLayer/Menu/Place_Text.bbcode_text = "[center]" + current_scene.place_name + "[/center]"

func play_anim(fade):
	$CanvasLayer/Transition/AnimationPlayer.play(fade)

func change_scene(scene):
	#if current_scene:
	remove_child(current_scene)
	current_scene = scene.instance()
	add_child(current_scene)
	for node in get_tree().get_nodes_in_group("transition"):
		node.initialize(self)
	# Load and start background music if available.
	if current_scene.background_music != null:
		var music = load(current_scene.background_music)
		$Background_music.stream = music
		$Background_music.play()

func room_transition(dest, dir):
	player.change_input()
	
	transition_visibility()
	play_anim("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = true
		Global.TrainerX = dest.x
		Global.TrainerY = dest.y
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = true
		Global.TrainerX = dest.x
		Global.TrainerY = dest.y
	
	if dir == "Up":
		player.direction = 2
	elif dir == "Down":
		player.direction = 1
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	#player.movePrevious()
	yield(get_tree().create_timer(0.3), "timeout")
	play_anim("fade_out")
	
	
	player.move(true)
	#player.movePrevious()
	player.inputDisabled = true
	yield(get_tree().create_timer(0.3), "timeout")
	
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = false
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = false
	
	player.change_input()
	transition_visibility()

func door_transition(path_scene, new_position):
	if !isTransitioning:
		isTransitioning = true
		player.change_input()
		player.canMove = false
		yield(transition.fade_to_color(), "completed")
		
		var scene = load(path_scene)
	
		change_scene(scene)
		
		
		
		Global.TrainerX = new_position.x
		Global.TrainerY = new_position.y
		player.position = new_position
		#player.direction = 0
		#player.movePrevious()
		yield(get_tree().create_timer(0.3), "timeout")
		
		
		player.move(true)
		yield(transition.fade_from_color(), "completed")
		#player.movePrevious()
		isTransitioning = false
		player.canMove = true
		player.change_input()

func load_seemless():
	loaded = true
	
	#next_scene1 = get_child(2).next_scene1.instance()
	next_scene1 = current_scene.next_scene1.instance()
	next_scene1.position = Vector2(2272,26*32)
	add_child(next_scene1)

func interaction(collider, direction): # Starts the dialogue instead of the scene script
	if isInteracting == false:
		var interaction_title = current_scene.interaction(collider, direction)
		if interaction_title != null:
			isInteracting = true
			#canInteract = false # Maybe redundant?
			player.change_input()
			player.canMove = false
			play_dialogue(interaction_title)
		else:
			print(collider)
	
func dialog_end():
	yield(get_tree().create_timer(0.1), "timeout")
	isInteracting = false
	player.change_input()
	player.canMove = true
	emit_signal("event_dialogue_end")
func check_node(pos):
	for node in get_tree().get_nodes_in_group("interact"):
		if node.position == pos:
			return Node
		pass
	pass

func transition_visibility():
	$CanvasLayer/Transition.visible = !$CanvasLayer/Transition.visible

func _exit_tree():
	DialogueSystem.disconnect("dialogue_start", self, "set_process")
	DialogueSystem.disconnect("dialogue_end", self, "set_process")
	save_state()

func save_state():
	var state = {
		"current_scene": current_scene.filename,
		"player_position": player.position
	}
	SaveSystem.set_state(filename, state)

func load_state():
	if SaveSystem.has_state(filename):
		var state = SaveSystem.get_state(filename)
		start_scene = load(state["current_scene"])
		var temp_position = state["player_position"]
		Global.TrainerX = temp_position.x
		Global.TrainerY = temp_position.y
	# else:
	# it uses the default values

func get_game():
	return self

func play_dialogue(title): # Plays a dialogue without freezing player
	DialogueSystem.set_point_to(Vector2(0,0))
	DialogueSystem.start_dialog(title)
	
func play_dialogue_with_point(title, vector2): # Plays a dialogue with point and without freezing player
	DialogueSystem.set_point_to(vector2)
	DialogueSystem.start_dialog(title)
