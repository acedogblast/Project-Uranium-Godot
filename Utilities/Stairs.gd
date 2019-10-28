extends Area2D

export var destination = Vector2()
var game 

func initialize(_game):
	game = _game

func _on_Stairs_area_shape_entered(area_id, area, area_shape, self_shape):
	$CollisionShape2D.disabled = true
	game.room_transition(destination)
	$CollisionShape2D.disabled = false
