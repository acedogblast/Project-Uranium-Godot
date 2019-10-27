extends Node

onready var next_scene = preload("res://Maps/Moki Town/Moki Town.tscn")

onready var dialogBox = preload("res://Utilities/Dialogue Box.tscn")
onready var dialog = null
var isInteracting = false
var canInteract = true

func _ready():
	print(str(self.name))
	$Floor2/DownStairs/CollisionShape2D.disabled = true
	
	$BlackBG.visible = true
#	player = Player.instance()
#	add_child(player)
#	player.position = Vector2(Global.TrainerX, Global.TrainerY)
#	player.z_index = 8
	$Floor2/TileMap5.z_index = 9
	yield(get_tree().create_timer(1), "timeout")
	$Floor2/DownStairs/CollisionShape2D.disabled = false

func interaction(collider):
	if isInteracting == true or !canInteract:
		return null
	isInteracting = true
	canInteract = false
	
	print($Floor2/TV.position)
	if collider == $Floor2/Console.position:
		get_tree().player.disable_input()
		consoleDialoge()
	if collider == $Floor2/TV.position:
		get_tree().player.disable_input()
		Floor2TVDialoge()
	if collider == $Floor2/TV2.position:
		get_tree().player.disable_input()
		Floor2TVDialoge()
	if collider == $Floor2/Shelf.position:
		get_tree().player.disable_input()
		Floor2SelfDialoge()
	if collider == $Floor2/Shelf2.position:
		get_tree().player.disable_input()
		Floor2SelfDialoge()

func check_node(pos):
	for node in get_tree().get_nodes_in_group("interact"):
		if node.position == pos:
			return Node
		pass
	pass

func Floor2TVDialoge():
	new_dialog(tr("INTERACT_MOKITOWN_HOUSE_TV"), false)
func consoleDialoge():
	new_dialog(tr("INTERACT_MOKITOWN_HOUSE_CONSOLE"),false)
	pass
func Floor2SelfDialoge():
	new_dialog(tr("INTERACT_MOKITOWN_HOUSE_BOOKSHELF"), false)
func new_dialog(var text, var forceArrow):
	dialog = dialogBox.instance()
	dialog.load_text(text, forceArrow)
	$DialogeBoxLayer.add_child(dialog)
	pass
func newRichDialog(var text, var forceArrow):
	dialog = dialogBox.instance()
	dialog.load_text(text, forceArrow)
	$DialogeBoxLayer.add_child(dialog)
	pass
func dialogEnd():
	isInteracting = false
	$InteractTimer.start()
	get_parent().player.enable_input()
	pass
func _on_InteractTimer_timeout():
	canInteract = true
	pass # replace with function body

func _on_DownStairs_area_shape_entered(area_id, area, area_shape, self_shape):
	get_parent().room_transition("Down")


#func room_transition(dir):
#	player.disable_input()
#
#	get_tree().transition_visibility()
#	get_tree().play_anim("fade_in")
#	yield(get_tree().create_timer(0.28), "timeout")
#
#	if dir == "Up":
#		$Floor2/DownStairs/CollisionShape2D.disabled = true
#		Global.TrainerX = 64
#		Global.TrainerY = 80
#	elif dir == "Down":
#		$Floor1/UpStairs/CollisionShape2D.disabled = true
#		Global.TrainerX = 1184
#		Global.TrainerY = 80
#
#	if dir == "Up":
#		player.direction = 2
#	elif dir == "Down":
#		player.direction = 1
#
#	player.position = Vector2(Global.TrainerX, Global.TrainerY)
#	player.movePrevious()
#	yield(get_tree().create_timer(0.3), "timeout")
#	get_tree().play_anim("fade_out")
#
#
#	player.move()
#	player.movePrevious()
#	player.inputDisabled = true
#	yield(get_tree().create_timer(0.3), "timeout")
#
#	if dir == "Up":
#		$Floor2/DownStairs/CollisionShape2D.disabled = false
#	elif dir == "Down":
#		$Floor1/UpStairs/CollisionShape2D.disabled = false
#
#	player.enable_input()
#	get_tree().transition_visibility()



func _on_UpStairs_area_shape_entered(area_id, area, area_shape, self_shape):
	get_parent().room_transition("Up")


func _on_Outside_area_shape_entered(area_id, area, area_shape, self_shape):
	get_parent().door_transition(next_scene)
