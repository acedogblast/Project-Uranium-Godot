extends Area2D

export(String, FILE, "*.tscn") var scene
export var destination = Vector2()
var game 

func initialize(_game):
	game = _game

func _on_Door_area_shape_entered(area_id, area, area_shape, self_shape):
		call_deferred("transision")
func transision():
	$CollisionShape2D.disabled = true
	print(scene)
	game.door_transition(scene, destination)
	$CollisionShape2D.disabled = false
