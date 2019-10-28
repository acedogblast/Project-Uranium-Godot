extends Node2D

onready var Player = preload("res://Utilities/PlayerNew.tscn")
onready var player = null

var start_scene = preload("res://Maps/Moki Town/HeroHome.tscn")
var current_scene = null

var next_scene2 = null
var next_scene3 = null
var next_scene4 = null

var isInteracting = false
var canInteract = true

func _ready():
	player = Player.instance()
	add_child(player)
	
	current_scene = start_scene.instance()
	add_child(current_scene)
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.z_index = 8

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
	
	if dir == "Up":
		player.direction = 2
	elif dir == "Down":
		player.direction = 1
	
	player.position = Vector2(Global.TrainerX, Global.TrainerY)
	player.movePrevious()
	yield(get_tree().create_timer(0.3), "timeout")
	play_anim("fade_out")
	
	
	player.move()
	player.movePrevious()
	player.inputDisabled = true
	yield(get_tree().create_timer(0.3), "timeout")
	
	if dir == "Up":
		$Map/Floor2/DownStairs/CollisionShape2D.disabled = false
	elif dir == "Down":
		$Map/Floor1/UpStairs/CollisionShape2D.disabled = false
	
	player.enable_input()
	transition_visibility()

func door_transition(scene):
	player.disable_input()
	
	transition_visibility()
	
	play_anim("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	remove_child($Map)
	current_scene = scene.instance()
	
	add_child(current_scene)
	player.position = Vector2(get_child(2).hero_home_x, get_child(2).hero_home_y)
	yield(get_tree().create_timer(0.3), "timeout")
	player.direction = 0
	player.movePrevious()
	player.move()
	play_anim("fade_out")
	yield($CanvasLayer/Node2D/AnimationPlayer, "animation_finished")
	player.movePrevious()
	transition_visibility()
	
	player.enable_input()
	
	pass

func interaction(collider):
	if isInteracting == true or !canInteract:
		return null
	isInteracting = true
	canInteract = false
	
	print($Map/Floor2/TV.position)
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