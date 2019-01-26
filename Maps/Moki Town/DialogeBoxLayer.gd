extends CanvasLayer

func dialogEnd():
	get_child(0).queue_free()
	get_parent().dialogEnd()