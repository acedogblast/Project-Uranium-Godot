extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var dialogBox = preload("res://Dialogue Box.tscn")
onready var dialog = null
onready var Player = preload("res://Player.tscn")
onready var player = null
var isInteracting = false
var canInteract = true

func _ready():
	print(str(self.name))
	
	$BlackBG.visible = true
	player = Player.instance()
	add_child(player)
	player.position = Vector2(192,160)
	player.z_index = 8
	$Floor2/TileMap5.z_index = 9
	pass
	
func interaction(node):
	if isInteracting == true or !canInteract:
		return null
	isInteracting = true
	canInteract = false
	player.freezePlayer()
	if node == $Floor2/Console:
		consoleDialoge()
	if node == $Floor2/TV:
		Floor2TVDialoge()
	if node == $Floor2/Self:
		Floor2SelfDialoge()
func Floor2TVDialoge():
	newdialog([
	"There's an ad for a new video game on TV.",
	"It's a Pokémon battle simulation game",
	"called \"Red and Blue Version\"",
	"...Okay, time to go!"
	], false)
func consoleDialoge():
	var text = [
	"It's a Nintendo Wii U.",
	"But the new Nintendo Switch is better."
	]
	newdialog(text,false)
	pass
func Floor2SelfDialoge():
	newdialog([
	"It's crammed full of books about Pokémon",
	"\"Me and my Owten\",",
	"\"Jerbolta's Big Adventure\",",
	"\"Quest for the Legends\".",
	"I've read all of these many times."
	], false)
func newdialog(var text, var forceArrow):
	dialog = dialogBox.instance()
	dialog.loadText(text, forceArrow)
	$DialogeBoxLayer.add_child(dialog)
	pass
func newRichDialog(var text, var forceArrow):
	dialog = dialogBox.instance()
	dialog.loadText(text, forceArrow)
	$DialogeBoxLayer.add_child(dialog)
	pass
func dialogEnd():
	isInteracting = false
	$InteractTimer.start()
	player.freePlayer()
	pass
func _on_InteractTimer_timeout():
	canInteract = true
	pass # replace with function body
func _on_DownStairs_body_entered(body):
	print("Going downstairs")
	pass # replace with function body
