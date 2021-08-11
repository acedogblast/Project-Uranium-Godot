extends Sprite

var rock_texture = "res://Graphics/Characters/fk107-rocksmash.png"
var boulder_texture = "res://Graphics/Characters/HGSS_091.png"
var poke_ball_texture = "res://Graphics/Characters/itemball.png"

export (String, "Pickable Item", "Smashable Rock", "Movable boulder") var type 

func _ready():
	match type:
		"Pickable Item":
			self.texture = load(poke_ball_texture)
			self.frame = 0
		"Smashable Rock":
			self.texture = load(rock_texture)
			self.frame = 0
		"Movable boulder":
			self.texture = load(boulder_texture)
			self.frame = 0
	pass