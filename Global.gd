extends Node
var TrainerName : String = "TrainerName"
var TrainerGender = 0 # 0 is boy, 1 is neutral, 2 is girl
var badges = 0
var time : int = 0 # number of minutes spend in-game
var location : String = ""
var money : int = 0
var language = "en"  # "en", "fr", or "auto" (system language)

# User settings (persisted in user://settings.cfg)
var music_volume := 100
var se_volume := 100
var fps_cap := 60
var text_speed := 1  # 0 = slow, 1 = mid, 2 = fast

func load_settings():
	var cfg = ConfigFile.new()
	if cfg.load("user://settings.cfg") == OK:
		music_volume = cfg.get_value("audio", "music", 100)
		if music_volume <= 10: music_volume *= 10 # legacy 0-10 scale
		se_volume = cfg.get_value("audio", "se", 100)
		if se_volume <= 10: se_volume *= 10 # legacy 0-10 scale
		fps_cap = cfg.get_value("video", "fps", 60)
		text_speed = cfg.get_value("game", "text_speed", 1)
		language = cfg.get_value("game", "language", language)
	apply_settings()

func save_settings():
	var cfg = ConfigFile.new()
	cfg.set_value("audio", "music", music_volume)
	cfg.set_value("audio", "se", se_volume)
	cfg.set_value("video", "fps", fps_cap)
	cfg.set_value("game", "text_speed", text_speed)
	cfg.set_value("game", "language", language)
	cfg.save("user://settings.cfg")

func apply_settings():
	Engine.max_fps = fps_cap
	if language in ["en", "fr", "de", "es", "pt", "nl", "zh", "ko", "tlh"]:
		TranslationServer.set_locale(language)
	apply_audio()

func apply_audio():
	if game == null:
		return
	var m = game.get_node_or_null("Background_music")
	if m:
		m.volume_db = linear_to_db(music_volume / 100.0) if music_volume > 0 else -80.0
	var e = game.get_node_or_null("Effect_music")
	if e:
		e.volume_db = linear_to_db(se_volume / 100.0) if se_volume > 0 else -80.0
var pokedex_seen = [] # list of id numbers
var pokedex_caught = [] # list of id numbers

var onStairsUp = false
var onStairsDown = false
var wasOnStairs = false

var debug = false

var onGrass = false
var lookingOnGrass = false
var grass_positions = []
var grassPos = ""
var exitGrassPos = ""
var grassSprite = "res://Graphics/Autotiles/Tall_Grass2.png"

var printFPS = false
#var size
var sprint = false
var game : Node

var inventory

var can_run = false

var pokemon_group = [] # Cannot be more that 6 Pokemon objects

var past_events = [] # All events that had occured

var isMobile = false

var load_game_from_id # Used on loading a save

var player_starter # 0 = Raptorch, 1 = Orchynx, 2 = Electux

var block_wild = false

var rng

var registry

#signal setup_items
signal loaded


# Migrates scene paths from before the naming convention (spaces/parens -> _, RouteN files -> Route_N)
static func migrate_scene_path(path: String) -> String:
	if ResourceLoader.exists(path):
		return path
	var dir = path.get_base_dir()
	var file = path.get_file()
	var stem = file.get_basename()
	var ext = "." + file.get_extension()
	# fichiers : espaces/parenthèses -> underscores
	var s = stem.replace("(", " ").replace(")", " ").strip_edges()
	var parts = s.split(" ", false)
	s = "_".join(parts)
	# RouteN collé -> Route_N
	var rx = RegEx.new()
	rx.compile("^Route(\\d+)")
	s = rx.sub(s, "Route_$1")
	# dossiers : Route_N -> RouteN, underscores -> CamelCase
	var dparts = dir.split("/")
	for i in range(dparts.size()):
		var seg = dparts[i]
		if "_" in seg and not seg.begins_with("res:"):
			var camel = ""
			for w in seg.split("_", false):
				camel += w.substr(0, 1).to_upper() + w.substr(1)
			dparts[i] = camel
	var candidate = "/".join(dparts) + "/" + s + ext
	if ResourceLoader.exists(candidate):
		return candidate
	# Relocated route sub-locations: Maps/Route07RestCenter -> Maps/Routes/Route7
	var rr = RegEx.new()
	rr.compile("^res://Maps/Route0*(\\d+)[^/]*/Route_?0*(\\d+)_?(.*)\\.tscn$")
	var mm = rr.search(path)
	if mm != null:
		var n2 = mm.get_string(1)
		var rest = mm.get_string(3)
		var camel_rx = RegEx.new()
		camel_rx.compile("([a-z0-9])([A-Z])")
		rest = camel_rx.sub(rest, "$1_$2", true)
		var cand2 = "res://Maps/Routes/Route" + n2 + "/Route_" + n2 + (("_" + rest) if rest != "" else "") + ".tscn"
		if ResourceLoader.exists(cand2):
			return cand2
	return path


# Hold-to-repeat matching the original Input.repeatex? cadence:
# fires on first press, then after 0.5s repeats every 0.05s (20/s at the original 40fps).
var _repeat_state := {}

func repeat_pressed(action: String, delta: float) -> bool:
	if not Input.is_action_pressed(action):
		_repeat_state.erase(action)
		return false
	if not _repeat_state.has(action):
		_repeat_state[action] = {"t": 0.0, "acc": 0.0}
		return true
	var st = _repeat_state[action]
	st.t += delta
	if st.t < 0.5:
		return false
	st.acc += delta
	if st.acc >= 0.05:
		st.acc = fmod(st.acc, 0.05)
		return true
	return false

func _ready():
	# CJK fallbacks: the pixel fonts lack Chinese/Korean glyphs; chain the bundled fonts
	var _cjk = [load("res://Fonts/PokemonUraniumKR.ttf"), load("res://Fonts/NotoSansCJKsc-Medium.otf")]
	for fpath in ["res://Fonts/pkmnem.ttf", "res://Fonts/pkmndpb.ttf", "res://Fonts/pkmndp.ttf"]:
		var fres = load(fpath)
		if fres != null and fres.fallbacks.is_empty():
			fres.fallbacks = _cjk

	# Generated map dialogues (GenMaps.po): boot skips them, register at runtime
	var gen_dir = DirAccess.open("res://Dialogue/Generated")
	if gen_dir != null:
		for locale_dir in gen_dir.get_directories():
			var sub = DirAccess.open("res://Dialogue/Generated/" + locale_dir)
			if sub == null:
				continue
			for f in sub.get_files():
				if f.ends_with(".po"):
					var tra = load("res://Dialogue/Generated/" + locale_dir + "/" + f)
					if tra != null:
						TranslationServer.add_translation(tra)

	# Load settings first (language matters for the locale below)
	load_settings()
	# Load both language sets; each .po carries its locale, switching is just set_locale
	var translation_files = []
	for lang_dir in ["en", "fr"]:
		for domain in ["UI", "Cutscenes", "NPC", "Events", "Battle", "Objects", "Maps"]:
			translation_files.append("res://Dialogue/Generated/%s/%s.po" % [lang_dir, domain])
	for file in translation_files:
		var translation = load(file)
		if translation:
			TranslationServer.add_translation(translation)
			print("Loaded translation: ", file)
		else:
			print("FAILED to load: ", file)
	var lang = language
	if lang == "auto":
		lang = OS.get_locale_language()
	if not lang in ["en", "fr"]:
		lang = "en"
	TranslationServer.set_locale(lang)
	print("Test translation: ", tr("UI_SAVEMENU_NEWGAME"))
	
	rng = RandomNumberGenerator.new()
	rng.randomize()
	add_to_group("save")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	registry = load("res://Utilities/Battle/Database/Pokemon/registry.gd").new()
	
	

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED
	if Input.is_action_just_pressed("toggle_fps"):
		printFPS = true
	if printFPS == true:
		print(Engine.get_frames_per_second())
	pass


func poke_to_dict(poke) -> Dictionary:
	var moves = []
	for m in [poke.move_1, poke.move_2, poke.move_3, poke.move_4]:
		if m == null:
			moves.append(null)
		else:
			moves.append({"name": m.name, "remaining_pp": m.remaining_pp})
	return {
		"ID": poke.ID, "name": poke.name, "level": poke.level,
		"experience": poke.experience, "current_hp": poke.current_hp,
		"nature": poke.nature, "gender": poke.gender, "is_shiny": poke.is_shiny,
		"major_ailment": poke.major_ailment, "item": poke.item,
		"iv": [poke.iv_hp, poke.iv_attack, poke.iv_defense, poke.iv_sp_attack, poke.iv_sp_defense, poke.iv_speed],
		"ev": [poke.ev_hp, poke.ev_attack, poke.ev_defense, poke.ev_sp_attack, poke.ev_sp_defense, poke.ev_speed],
		"moves": moves,
	}

func dict_to_poke(d: Dictionary):
	var poke = load("res://Utilities/Battle/Classes/Pokemon.gd").new()
	poke.set_basic_pokemon_by_level(int(d["ID"]), int(d["level"]))
	poke.name = d["name"]
	poke.nature = d["nature"]
	poke.gender = d["gender"]
	poke.is_shiny = d["is_shiny"]
	poke.major_ailment = d["major_ailment"]
	poke.item = d["item"]
	var iv = d["iv"]
	poke.iv_hp = int(iv[0]); poke.iv_attack = int(iv[1]); poke.iv_defense = int(iv[2])
	poke.iv_sp_attack = int(iv[3]); poke.iv_sp_defense = int(iv[4]); poke.iv_speed = int(iv[5])
	var ev = d["ev"]
	poke.ev_hp = int(ev[0]); poke.ev_attack = int(ev[1]); poke.ev_defense = int(ev[2])
	poke.ev_sp_attack = int(ev[3]); poke.ev_sp_defense = int(ev[4]); poke.ev_speed = int(ev[5])
	poke.update_stats()
	poke.experience = int(d["experience"])
	poke.current_hp = mini(int(d["current_hp"]), poke.hp)
	var slots = ["move_1", "move_2", "move_3", "move_4"]
	for i in 4:
		var md = d["moves"][i]
		if md == null:
			poke.set(slots[i], null)
		else:
			var mv = MoveDataBase.get_move_by_name(md["name"])
			if mv != null:
				mv.remaining_pp = int(md["remaining_pp"])
			poke.set(slots[i], mv)
	return poke

func save_state():
	load_game_from_id = null
	var state = {
		"TrainerName": TrainerName,
		"TrainerGender": TrainerGender,
		"badges": badges,
		"money": money,
		"time": time,
		"can_run": can_run,
		"pokemon_group": pokemon_group.map(poke_to_dict),
		"past_events": past_events,
		"inventory": inventory.get_save_state(),
		"pokedex_seen": pokedex_seen,
		"pokedex_caught" : pokedex_caught
	}
	SaveSystem.set_state(scene_file_path, state)
func load_state():
	if SaveSystem.has_state(scene_file_path):
		var state = SaveSystem.get_state(scene_file_path)
		TrainerName = state["TrainerName"]
		TrainerGender = state["TrainerGender"]
		badges = state["badges"]
		if state.has("money"):
			money = int(state["money"])

		if typeof(state["time"]) == TYPE_STRING:
			time = 0
		if typeof(state["time"]) == TYPE_INT:
			time = state["time"]
			
		can_run = state["can_run"]
		pokemon_group = []
		for entry in state["pokemon_group"]:
			if typeof(entry) == TYPE_DICTIONARY:
				pokemon_group.append(dict_to_poke(entry))
		past_events = state["past_events"]
		pokedex_seen = state["pokedex_seen"]

		if state.has("pokedex_caught"):
			pokedex_caught = state["pokedex_caught"]
		elif state.has("pokedex_owned"):
			pokedex_caught = state["pokedex_owned"]

		inventory = load("res://Utilities/Items/Inventory.gd").new()
		inventory.set_save_state(state["inventory"])
		
		badges = state["badges"]

		emit_signal("loaded")
func heal_party(): # Heals all of the player's pokemon party.
	for poke in pokemon_group:
		poke.heal()
func add_poke_to_party(poke : Pokemon):
	# Add to owned dex list
	if !pokedex_caught.has(poke.ID):
		pokedex_caught.append(poke.ID)
	if !pokedex_seen.has(poke.ID):
		pokedex_seen.append(poke.ID)
		
	if pokemon_group.size() >= 6:
		print("party already full")
		# party already full
		# TODO: Send to pc
	else:
		pokemon_group.append(poke)
	pass
func remove_money(amount : int):
	if money - amount < 0:
		money = 0
	else:
		money = money - amount


# Swap static textures for their localized variants (Graphics/Translations sheets).
# The project.godot translation_remaps table is our data source; Godot's native
# remapping only applies to exported builds, so we do it ourselves at scene _ready.
func localize_textures(root: Node):
	var rm = ProjectSettings.get_setting("internationalization/locale/translation_remaps")
	if rm == null:
		return
	var loc = TranslationServer.get_locale().substr(0, 2)
	if loc == "en":
		return
	var stack = [root]
	while stack.size() > 0:
		var n = stack.pop_back()
		for c in n.get_children():
			stack.push_back(c)
		if not ("texture" in n) or n.texture == null:
			continue
		var tex = n.texture
		var base = ""
		if tex is AtlasTexture and tex.atlas != null:
			base = tex.atlas.resource_path
		else:
			base = tex.resource_path
		if not rm.has(base):
			continue
		for v in rm[base]:
			if v.ends_with(":" + loc):
				var res = load(v.substr(0, v.rfind(":")))
				if res == null:
					break
				if tex is AtlasTexture:
					var dup = tex.duplicate()
					dup.atlas = res
					n.texture = dup
				else:
					n.texture = res
				break
