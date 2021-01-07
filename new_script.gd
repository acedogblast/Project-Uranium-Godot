tool
extends EditorScript


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _run():
	var x = 0
	var y = 4
	
	var changer = false
	
	for i in range(191, 191 + 3*19):
		print("{\n'autotile_coord': Vector2( " + str(x) + ", " + str(y) + " ),\n'one_way': false,\n'one_way_margin': 1.0,\n'shape': SubResource( " + str(i) + " ),\n'shape_transform': Transform2D( 1, 0, 0, 1, 0, 0 )\n}, ")
		if x < 57 and (y == 0 or y == 2):
			x += 1
		elif x < 57 and y == 1:
			if changer:
				x += 1
			else:
				x += 2
		elif x < 57 and (y == 3 or y == 4):
			if changer:
				x += 2
			else:
				x += 1
			pass
		else:
			x = 0
			y += 1
			changer = false
		
		changer = !changer
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
