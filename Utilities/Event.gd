tool
extends Area2D

export(String, "1x1", "2x1", "custom") var size
export(Vector2) var custom_size
export(Vector2) var custom_offset
func _ready():
	if size != "custom":
		match size:
			"1x1":
				$CollisionShape2D.shape.extents = Vector2(16,16)
				$CollisionShape2D.position = Vector2(0,0)
			"2x1":
				$CollisionShape2D.shape.extents = Vector2(32,16)
				$CollisionShape2D.position = Vector2(16,0)
	else:
		$CollisionShape2D.shape.extents = custom_size
		$CollisionShape2D.position = custom_offset
func _process(_delta):
	if Engine.editor_hint:
		if size != "custom":
			match size:
				"1x1":
					$CollisionShape2D.shape.extents = Vector2(16,16)
					$CollisionShape2D.position = Vector2(0,0)
				"2x1":
					$CollisionShape2D.shape.extents = Vector2(32,16)
					$CollisionShape2D.position = Vector2(16,0)
		else:
			$CollisionShape2D.shape.extents = custom_size
			$CollisionShape2D.position = custom_offset
