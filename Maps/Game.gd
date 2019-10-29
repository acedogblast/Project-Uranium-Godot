extends Node2D

onready var Player = preload("res://Utilities/PlayerNew.tscn")
onready var player = null

var start_scene = preload("res://Maps/Moki Town/HeroHome.tscn")
var current_scene = null

var next_scene1 = null
var next_scene2 = null
var next_scene3 = null
var next_scene4 = null

var loaded = false
var isInteracting = false
var canInteract = true

onready var transition = $CanvasLayer/Transition

func _ready():
	player = Player.instance()
	add_child(player)
	change_scene(start_scene)
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.z_index = 8

func _process(delta):
	if get_child(2).name == "Moki Town" && loaded == false:
		load_seemless()

func transition_visibility():
	$CanvasLayer/Node2D.visible = !$CanvasLayer/Node2D.visible

func play_anim(fade):
	$CanvasLayer/Node2D/AnimationPlayer.play(fade)

func room_transition(dir):
	player.disable_input()
	
	transition_visibility()
	play_anim("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = true
		Global.TrainerX = 64
		Global.TrainerY = 80
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = true
		Global.TrainerX = 1184
		Global.TrainerY = 80
	
func room_transition(new_position):
	player.disable_input()
	yield(transition.fade_to_color(), "completed")
	
	Global.TrainerX = new_position.x
	Global.TrainerY = new_position.y
	player.position = new_position
	player.movePrevious()
	yield(transition.fade_from_color(), "completed")
	
	player.move()
	player.movePrevious()
	player.enable_input()

func door_transition(path_scene, new_position):
	player.disable_input()
	yield(transition.fade_to_color(), "completed")
	
	change_scene(load(path_scene))
	
	play_anim("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	remove_child(get_child(2))
	current_scene.free()
	current_scene = scene.instance()
	
	add_child(current_scene)
	player.position = Vector2(get_child(2).hero_home_x, get_child(2).hero_home_y)
	yield(get_tree().create_timer(0.3), "timeout")
	player.direction = 0
	player.movePrevious()
	yield(transition.fade_from_color(), "completed")
	
	player.move()
	player.movePrevious()
	player.enable_input()

func interaction(collider):
	if isInteracting == true or !canInteract:
		return null
	isInteracting = true
	canInteract = false
	
	if collider == $Map/Floor2/Console.position:
		player.disable_input()
		get_child(2).consoleDialoge()
	if collider == $Map/Floor2/TV.position:
		player.disable_input()
		get_child(2).Floor2TVDialoge()
	if collider == $Map/Floor2/TV2.position:
		player.disable_input()
		get_child(2).Floor2TVDialoge()
	if collider == $Map/Floor2/Shelf.position:
		player.disable_input()
		get_child(2).Floor2SelfDialoge()
	if collider == $Map/Floor2/Shelf2.position:
		player.disable_input()
		get_child(2).Floor2SelfDialoge()

func check_node(pos):
	for node in get_tree().get_nodes_in_group("interact"):
		if node.position == pos:
			return Node
		pass
	pass

func load_seemless():
	loaded = true
	
	next_scene1 = get_child(2).next_scene1.instance()
	next_scene1.position = Vector2(2272,26*32)
	add_child(next_scene1)