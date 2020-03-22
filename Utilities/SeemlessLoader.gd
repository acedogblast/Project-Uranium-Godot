extends VisibilityNotifier2D

var loaded = false
onready var game = get_parent().get_parent()

func load_connected():
	game.next_scene1 = get_parent().next_scene1.instance()
	game.next_scene1.position = Vector2(2272,26*32)
	game.add_child(game.next_scene1)

func unload_connected():
	var last = game.get_child_count()
	
	game.get_child(last - 1).free()
	pass


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	if !loaded:
			loaded = true
			load_connected()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	if loaded:
			loaded = false
			unload_connected()
