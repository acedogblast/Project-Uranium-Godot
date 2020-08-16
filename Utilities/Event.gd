tool
extends Area2D

export var event_name : String
export(Vector2) var size = Vector2(16,16)
#export var commands = []
func _ready():
	$CollisionShape2D.shape.extents = size
func _process(_delta):
	if Engine.editor_hint:
		$CollisionShape2D.shape.extents = size


