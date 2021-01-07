extends Node2D
var screen_position : Vector2
signal selected
var selection # 0 is Yes, 1 is No
enum { YES, NO }
# Called when the node enters the scene tree for the first time.
func _ready():
	$MultiLinePrompt.setup("Yes,No", Vector2(100,110), screen_position)
	$MultiLinePrompt.mode = 1
	$MultiLinePrompt.connect("selected", self, "_on_selected")

func set_screen_position(position : Vector2): # Set before adding to scene tree!
	screen_position = position
func _on_selected():
	selection = $MultiLinePrompt.selected_line
	emit_signal("selected")