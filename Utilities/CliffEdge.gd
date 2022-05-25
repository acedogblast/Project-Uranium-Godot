tool
extends Node2D

export(int) var size = 1
export(String, "Up", "Down", "Left", "Right") var jump_direction = "Down"

func _process(_delta):
	if Engine.editor_hint:
		match jump_direction:
			"Up", "Down":
				$Area2D/CollisionShape2D.shape.extents = Vector2(size * 16, 16)
				$Area2D/CollisionShape2D.position = Vector2((size * 16) - 16, 0)
			"Left", "Right":
				$Area2D/CollisionShape2D.shape.extents = Vector2(16, size * 16)
				$Area2D/CollisionShape2D.position = Vector2(0, (size * 16) - 16)

func _ready():
	self.add_to_group("Cliff")
	pass

func get_cliff_positions():
	var positions = []
	for i in range(size):
		match jump_direction:
			"Up", "Down":
				positions.append(Vector2(self.position.x + (i * 32) , self.position.y))
			"Left", "Right":
				positions.append(Vector2(self.position.x  , self.position.y + (i * 32)))
	return positions
