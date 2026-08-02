extends Node2D

# Options screen controller. Rows are prebuilt in OptionsMenu.tscn;
# this script adds navigation, value rendering, live apply, persistence,
# full language selection and a translated help box (official strings).

signal closed

const ROWS = ["MusicVolume", "SEVolume", "FPS", "TextSpeed", "FontStyle"]
const FPS_VALUES = [30, 60, 120]
const SPEED_KEYS = ["Slow", "Mid", "Fast"]
const LANG_NAMES = ["English", "Français", "Deutsch", "Español", "Português", "Nederlands", "中文", "한국어", "1337"]
const LANG_CODES = ["en", "fr", "de", "es", "pt", "nl", "zh", "ko", "tlh"]
const HELP_KEYS = {
	"MusicVolume": "You can set the game's music volume.",
	"SEVolume": "You can set the game's SFX volume.",
	"FPS": "You can set the game's frames per second.",
	"TextSpeed": "You can set the game's text speed.",
	"FontStyle": "You can set the game's language.",
}
const BAR_W = 504
const BAR_H = 44

var idx := 0
var active := false
var _bg_bars := {}
var _help: RichTextLabel
var _help_shadow: RichTextLabel

func _ready():
	visible = false
	# Add background (empty) bars behind the volume bars
	for row in ["MusicVolume", "SEVolume"]:
		var fg: Sprite2D = get_node(row + "/bars")
		var bg := Sprite2D.new()
		bg.texture = fg.texture
		bg.centered = false
		bg.position = fg.position
		bg.region_enabled = true
		bg.region_rect = Rect2(0, 0, BAR_W, BAR_H)
		fg.get_parent().add_child(bg)
		fg.get_parent().move_child(bg, fg.get_index())
		fg.region_enabled = true
		_bg_bars[row] = bg
	# FPS row: numeric display only
	if has_node("FPS/bars"):
		get_node("FPS/bars").visible = false
	# Original slider geometry (203_BW_Options): track 4px from optionwidth to value text, handle 8x16
	for row in ["MusicVolume", "SEVolume", "FPS"]:
		var rn = get_node(row)
		var track := ColorRect.new()
		track.name = "track"
		track.size = Vector2(186, 4)
		track.position = Vector2(240, 72)
		rn.add_child(track)
		var handle := ColorRect.new()
		handle.name = "handle"
		handle.size = Vector2(8, 16)
		handle.position = Vector2(240, 66)
		rn.add_child(handle)
	# The old block bars are replaced by the sliders
	for row in ["MusicVolume", "SEVolume"]:
		get_node(row + "/bars").visible = false
		if _bg_bars.has(row):
			_bg_bars[row].visible = false
	# FontStyle gets a right-side value label; TextSpeed gets 3 inline choices + selarrows dots
	var int_model: RichTextLabel = get_node("MusicVolume/int")
	var v = int_model.duplicate()
	v.name = "int"
	v.position = Vector2(190, int_model.position.y)
	v.size = Vector2(276, v.size.y)
	get_node("FontStyle").add_child(v)
	var dots_tex = load("res://Graphics/Pictures/Options/selarrows.png")
	for si in range(3):
		var item = int_model.duplicate()
		item.name = "choice%d" % si
		item.text = ""
		item.position = Vector2(252 + si * 92, int_model.position.y)
		item.size = Vector2(88, item.size.y)
		get_node("TextSpeed").add_child(item)
		var dot := Sprite2D.new()
		dot.name = "dot%d" % si
		dot.texture = dots_tex
		dot.vframes = 3
		dot.centered = false
		dot.position = Vector2(240 + si * 92, int_model.position.y + 8)
		get_node("TextSpeed").add_child(dot)
	# Labels never wrap (single line like the original plates)
	for row in ROWS:
		for sub in ["name", "shadow"]:
			if has_node(row + "/" + sub):
				var l = get_node(row + "/" + sub)
				l.autowrap_mode = TextServer.AUTOWRAP_OFF
				l.size.x = maxf(l.size.x, 460.0)
	# Help box in the empty bottom frame (mirrors the original game's design)
	var model: RichTextLabel = get_node("FontStyle/name")
	var row_pitch = get_node("FontStyle").position.y - get_node("TextSpeed").position.y
	_help_shadow = model.duplicate()
	_help = model.duplicate()
	for lbl in [_help_shadow, _help]:
		lbl.name = "help_shadow" if lbl == _help_shadow else "help"
		lbl.size = Vector2(940, 90)
		lbl.text = ""
		add_child(lbl)
		lbl.position = get_node("FontStyle").position + model.position + Vector2(0, row_pitch)
	_help_shadow.position += Vector2(2, 2)
	if get_node_or_null("FontStyle/shadow") != null:
		_help_shadow.add_theme_color_override("default_color", get_node("FontStyle/shadow").get_theme_color("default_color"))

func _set_row_label(row: String, text: String):
	if has_node(row + "/name"):
		get_node(row + "/name").text = text
	if has_node(row + "/shadow"):
		get_node(row + "/shadow").text = text

func _set_value(row: String, text: String):
	if has_node(row + "/int"):
		get_node(row + "/int").text = "[right]" + text
	if has_node(row + "/shadow_int"):
		get_node(row + "/shadow_int").text = "[right]" + text

func open():
	visible = true
	active = true
	idx = 0
	refresh()

func close():
	active = false
	visible = false
	Global.save_settings()
	emit_signal("closed")

func _input(event):
	if not active:
		return
	if event.is_action_pressed("ui_down"):
		idx = (idx + 1) % ROWS.size()
		refresh()
	elif event.is_action_pressed("ui_up"):
		idx = (idx - 1 + ROWS.size()) % ROWS.size()
		refresh()
	elif event.is_action_pressed("ui_left"):
		adjust(-1)
	elif event.is_action_pressed("ui_right"):
		adjust(1)
	elif event.is_action_pressed("ui_cancel") or event.is_action_pressed("x"):
		close()
	else:
		return
	if get_viewport() != null:
			get_viewport().set_input_as_handled()

func adjust(dir: int):
	match ROWS[idx]:
		"MusicVolume":
			Global.music_volume = clampi(Global.music_volume + dir * 5, 0, 100)
		"SEVolume":
			Global.se_volume = clampi(Global.se_volume + dir * 5, 0, 100)
		"FPS":
			Global.fps_cap = clampi(Global.fps_cap + dir * 2, 40, 60)
		"TextSpeed":
			Global.text_speed = clampi(Global.text_speed + dir, 0, 2)
		"FontStyle":
			var i = LANG_CODES.find(Global.language)
			if i < 0: i = 0
			Global.language = LANG_CODES[(i + dir + LANG_CODES.size()) % LANG_CODES.size()]
	Global.apply_settings()
	refresh()

func refresh():
	# --- Original 203_BW_Options.rb rendering rules ---
	var C_SELW := Color(1, 1, 1)                    # selected row text/handle
	var C_CYAN := Color(66/255.0, 222/255.0, 231/255.0)  # unselected row text/handle
	var C_VAL_SEL := Color(123/255.0, 156/255.0, 156/255.0)  # non-chosen value, selected row
	var C_VAL_UNS := Color(107/255.0, 115/255.0, 107/255.0)  # non-chosen value, unselected row
	for r in range(ROWS.size()):
		var row = ROWS[r]
		var rn = get_node(row)
		var is_sel = (r == idx)
		# Row plate: bars.png frame 0 normal / 1 selected
		if rn.has_node("bars"):
			var plate: Sprite2D = rn.get_node("bars")
			plate.visible = true
			plate.region_enabled = false
			plate.vframes = 2
			plate.frame = 1 if is_sel else 0
		# Row label color: white when selected, cyan otherwise
		var row_col: Color = C_SELW if is_sel else C_CYAN
		for sub in ["name"]:
			if rn.has_node(sub):
				rn.get_node(sub).add_theme_color_override("default_color", row_col)
		# Sliders
		if row in ["MusicVolume", "SEVolume", "FPS"]:
			var v := 0
			var lo := 0
			var hi := 100
			if row == "FPS":
				v = Global.fps_cap; lo = 40; hi = 60
			else:
				v = Global.music_volume if row == "MusicVolume" else Global.se_volume
			var frac := float(v - lo) / float(hi - lo)
			if rn.has_node("handle"):
				var track: ColorRect = rn.get_node("track")
				var handle: ColorRect = rn.get_node("handle")
				track.color = C_SELW
				handle.color = row_col
				handle.position.x = track.position.x + frac * (track.size.x - handle.size.x)
			_set_value(row, str(v))
			if rn.has_node("int"):
				rn.get_node("int").add_theme_color_override("default_color", row_col)
	# Text speed: three inline choices with selarrows dots (official states)
	_set_row_label("TextSpeed", tr("Text Speed"))
	var ts = get_node("TextSpeed")
	var ts_sel = (ROWS[idx] == "TextSpeed")
	ts.get_node("name").add_theme_color_override("default_color", C_SELW if ts_sel else C_CYAN)
	for si in range(3):
		var item = ts.get_node_or_null("choice%d" % si)
		var dot = ts.get_node_or_null("dot%d" % si)
		if item == null: continue
		var chosen := (si == Global.text_speed)
		item.text = tr(SPEED_KEYS[si])
		if chosen:
			item.add_theme_color_override("default_color", C_SELW if ts_sel else C_CYAN)
			dot.frame = 2 if ts_sel else 1
		else:
			item.add_theme_color_override("default_color", C_VAL_SEL if ts_sel else C_VAL_UNS)
			dot.frame = 0
	# Language: right-side value with state colors
	_set_row_label("FontStyle", tr("Language"))
	var fs = get_node("FontStyle")
	var fs_sel = (ROWS[idx] == "FontStyle")
	fs.get_node("name").add_theme_color_override("default_color", C_SELW if fs_sel else C_CYAN)
	var li = LANG_CODES.find(Global.language)
	if li < 0: li = 0
	_set_value("FontStyle", LANG_NAMES[li])
	if fs.has_node("int"):
		fs.get_node("int").add_theme_color_override("default_color", C_SELW if fs_sel else C_CYAN)
	# Selection outline + labels + help
	var row_node: Node2D = get_node(ROWS[idx])
	var bars_y := 50.0
	if row_node.has_node("bars"):
		bars_y = row_node.get_node("bars").position.y
	$fakebox.position.y = row_node.position.y + bars_y - 28
	_set_row_label("MusicVolume", tr("Music Volume"))
	_set_row_label("SEVolume", tr("SE Volume"))
	_set_row_label("FPS", "FPS")
	if _help != null:
		var h = tr(HELP_KEYS[ROWS[idx]])
		_help.text = h
		_help_shadow.text = h
