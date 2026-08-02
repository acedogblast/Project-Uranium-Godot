extends Node
class_name BattlerSheet
# Configures a Sprite2D for a battler sheet. Sheets were originally a single
# row of square frames; those wider than 8192 px (GPU texture limit) have been
# re-tiled into grids of <=4096 px width. Frame size = original sheet height.
# TRUE_FRAMES stores the exact frame count for re-tiled sheets (grids contain
# padding cells that must not be part of the animation cycle).

const FRAME_SIZES = [102, 85, 80, 71]
const TRUE_FRAMES = {
	"002": 161,
	"002s": 161,
	"004": 192,
	"004s": 192,
	"006": 168,
	"006s": 168,
	"028": 87,
	"028f": 87,
	"028fs": 87,
	"028s": 87,
	"032": 108,
	"032s": 108,
	"072": 168,
	"072f": 168,
	"072fs": 168,
	"072s": 168,
	"076": 131,
	"076s": 131,
	"091": 119,
	"091s": 119,
	"109": 104,
	"109s": 104,
	"190": 192,
	"190s": 192,
}

static func setup(sprite: Sprite2D) -> int:
	var tex = sprite.texture
	if tex == null:
		return 1
	var w = tex.get_width()
	var h = tex.get_height()
	if w == h:
		return 1
	if h <= 128:
		# Single row of square frames
		sprite.hframes = maxi(int(w / h), 1)
		sprite.vframes = 1
		return sprite.hframes
	# Re-tiled grid: find the square frame size dividing both dimensions
	for fs in FRAME_SIZES:
		if w % fs == 0 and h % fs == 0:
			sprite.hframes = int(w / fs)
			sprite.vframes = int(h / fs)
			var stem = tex.resource_path.get_file().get_basename()
			return TRUE_FRAMES.get(stem, sprite.hframes * sprite.vframes)
	return 1
