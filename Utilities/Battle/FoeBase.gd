extends TextureRect

var cry
onready var sprite = $Battler/Sprite
func _ready():
	$Battler/Sprite.queue_free()
	

func setup_by_pokemon(poke):
	cry = poke.get_cry()
	sprite = poke.get_battle_foe_sprite()
	$Battler.add_child(sprite)
	$Battler/Shadow.texture = sprite.texture

func ball_flash():
	$Battler.visible = true
	sprite.visible = true
	sprite.modulate = Color(1.0,1.0,1.0,1.0)
	$Battler.modulate = Color(1.0,1.0,1.0,1.0)
	var scene = load("res://Utilities/Battle/BallFlash.tscn")
	var ballflash = scene.instance()
	self.add_child(ballflash)
	ballflash.position = Vector2(140, -60)

	# Play Recall sound
	$Ball/AudioStreamPlayer.stream = load("res://Audio/SE/recall.wav")
	$Ball/AudioStreamPlayer.play()
	yield($Ball/AudioStreamPlayer, "finished")

	# Play cry sound
	$Ball/AudioStreamPlayer.stream = load(cry)
	$Ball/AudioStreamPlayer.play()

	# Play animation
	$Battler/AnimationPlayer.play("UnveilDrop")

func rotate_ball():
	var frame_cord = $Ball.frame_coords
	if frame_cord.y < 8:
		frame_cord.y += 1
	else:
		frame_cord.y = 0
	$Ball.frame_coords = frame_cord
func open_ball():
	$Ball.frame_coords.y = 10
func close_ball():
	$Ball.frame_coords.y = 0
func ball_shake():
	var frame_cord = $Ball.frame_coords
	if frame_cord.y < 16 && frame_cord.y > 10:
		frame_cord.y += 1
	else:
		frame_cord.y = 11
	$Ball.frame_coords = frame_cord
func set_ball(ball_id):
	match ball_id:
		211: # Poke Ball
			$Ball.frame_coords.x = 0
		210: # Great Ball
			$Ball.frame_coords.x = 1
		209: # Ultra Ball:
			$Ball.frame_coords.x = 3
		208: # Master Ball:
			$Ball.frame_coords.x = 4