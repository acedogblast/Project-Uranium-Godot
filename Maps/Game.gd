extends Node2D

onready var Player = preload("res://Utilities/PlayerNew.tscn")
onready var player = null

var start_scene = preload("res://Maps/Moki Town/HeroHome.tscn")
var current_scene = null

var isInteracting = false
var canInteract = true

onready var transition = $CanvasLayer/Transition

func _ready():
	player = Player.instance()
	add_child(player)
	change_scene(start_scene)
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.z_index = 8

func change_scene(scene):
	if current_scene:
		remove_child(current_scene)
	current_scene = scene.instance()
	add_child(current_scene)
	for node in get_tree().get_nodes_in_group("transition"):
		node.initialize(self)
	
func room_transition(new_position):
	player.disable_input()
	yield(transition.fade_to_color(), "completed")
	
	Global.TrainerX = new_position.x
	Global.TrainerY = new_position.y
	player.position = new_position
	player.move(true)
	yield(transition.fade_from_color(), "completed")
	
	player.enable_input()

func door_transition(path_scene, new_position):
	player.disable_input()
	yield(transition.fade_to_color(), "completed")
	
	change_scene(load(path_scene))
	
	Global.TrainerX = new_position.x
	Global.TrainerY = new_position.y
	player.position = new_position
	
	player.move(true)
	yield(transition.fade_from_color(), "completed")
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