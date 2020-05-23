extends Sprite
signal free
var index = 0
var frames = [
	"res://Graphics/Pictures/a09.png",
	"res://Graphics/Pictures/a10.png",
	"res://Graphics/Pictures/a11.png",
	"res://Graphics/Pictures/a12.png",
	"res://Graphics/Pictures/a13.png",
	"res://Graphics/Pictures/a14.png",
	"res://Graphics/Pictures/a15.png",
	"res://Graphics/Pictures/a16.png",
	"res://Graphics/Pictures/a17.png",
	"res://Graphics/Pictures/a18.png",
	"res://Graphics/Pictures/a19.png",
	"res://Graphics/Pictures/a20.png",
	"res://Graphics/Pictures/a21.png",
	"res://Graphics/Pictures/a22.png",
	"res://Graphics/Pictures/a23.png",
	"res://Graphics/Pictures/a24.png",
	"res://Graphics/Pictures/a25.png",
	"res://Graphics/Pictures/a26.png",
	"res://Graphics/Pictures/a27.png",
	"res://Graphics/Pictures/a28.png",
	"res://Graphics/Pictures/a29.png",
	"res://Graphics/Pictures/a30.png",
	"res://Graphics/Pictures/a31.png",
	"res://Graphics/Pictures/a32.png",
	"res://Graphics/Pictures/a33.png",
	"res://Graphics/Pictures/a34.png",
	"res://Graphics/Pictures/a35.png",
	"res://Graphics/Pictures/a36.png",
	"res://Graphics/Pictures/a37.png"
	]
func nextFrame():
	if index == 28:
		emit_signal("free")
		self.queue_free()
	self.texture = load(frames[index])
	index += 1
func _ready():
	self.texture = load("res://Graphics/Pictures/a09.png")
	$AnimationPlayer.play("Flash")
