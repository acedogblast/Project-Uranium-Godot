extends Node2D


func _ready():
	var grid_texture = load("res://Graphics/Pictures/Pokedex/dexbg_grid.png")
	grid_texture.flags = Texture.FLAG_REPEAT
	$BG/Sprite.texture = grid_texture
	pass

