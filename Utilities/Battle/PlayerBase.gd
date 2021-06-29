extends TextureRect

var cry
onready var sprite = $Battler/Sprite
func _ready():
	$Battler/Sprite.queue_free()
	pass
func setup_by_pokemon(poke):
	cry = poke.get_cry()
	sprite = poke.get_battle_player_sprite()
	sprite.name = "Sprite"
	# Check if there is already a sprite
	if self.get_node("Battler/Sprite") != null:
		self.get_node("Battler/Sprite").free()

	$Battler.add_child(sprite)
	
	$Battler/Shadow.texture = poke.get_battle_player_sprite().texture
func ball_flash():
	$Battler.visible = true
	sprite.visible = true
	var scene = load("res://Utilities/Battle/BallFlash.tscn")
	var ballflash = scene.instance()
	self.add_child(ballflash)
	ballflash.position = Vector2(272, -100)

	# Play Recall sound
	$Ball/AudioStreamPlayer.stream = load("res://Audio/SE/recall.wav")
	$Ball/AudioStreamPlayer.play()
	yield($Ball/AudioStreamPlayer, "finished")
	# Play cry sound
	$Ball/AudioStreamPlayer.stream = load(cry)
	$Ball/AudioStreamPlayer.play()

	# Play animation
	$Battler/AnimationPlayer.play("UnveilDropPlayer")
