extends Object

class_name Pokemon # This is used for pokemon that is "active/saved". Not for recording base stats.

# The name of the pokemon. Can be used for nicknames.
var name

# Pokedex ID#
var ID

# The pokemon's type. If only one type use type1
var type1
var type2

var current_hp : int

# The pokemon's stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp : int
var attack : int
var defense : int
var sp_attack : int
var sp_defense : int
var speed : int

# The pokemon's level
var level : int

# The pokemon's total experience
var experience : int

# The pokemon's nature
var nature

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Individual Values
var iv_hp : int
var iv_attack : int
var iv_defense : int
var iv_sp_attack : int
var iv_sp_defense : int
var iv_speed : int

# The pokemon's Effort Values
var ev_hp = 0
var ev_attack = 0
var ev_defense = 0
var ev_sp_attack = 0
var ev_sp_defense = 0
var ev_speed = 0

# The pokemon's held Item
var item

# The pokemon's Move set
var move_1 : Move
var move_2 : Move
var move_3 : Move
var move_4 : Move

# The pokemon's gender
var gender
enum {MALE, FEMALE}

# Is the pokemon a shiny
var is_shiny = false

func generate_IV():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	iv_hp = rng.randi_range(0,31)
	iv_attack = rng.randi_range(0,31)
	iv_defense = rng.randi_range(0,31)
	iv_sp_attack = rng.randi_range(0,31)
	iv_sp_defense = rng.randi_range(0,31)
	iv_speed = rng.randi_range(0,31)
	pass
func exp_erratic(level : int) -> int:
	var xp : int = 0
	if level <= 50:
		xp = int( pow(level, 3) * (100 - level) / 50)
	elif 50 < level && level <= 68:
		xp = int( pow(level, 3) * (150 - level) / 100 )
	elif 68 < level && level <= 98:
		xp = int( pow(level, 3) * ( (1911 - 10 * level) / 3) / 500)
	elif 98 < level && level <= 100:
		xp = int( pow(level, 3) * (160 - level) / 100)
	return xp
func exp_fast(level : int) -> int:
	var xp : int = 0
	xp = int ( 4 * pow(level, 3) / 5 )
	return xp
func exp_medium_fast(level : int) -> int:
	var xp : int = 0
	xp = int( pow(level, 3 ) )
	return xp
func exp_medium_slow(level : int) -> int: # may need to use loop up table
	var xp : int = 0
	xp = int( (6/5) * pow(level, 3) - (15 - pow(level, 2)) + (100 * level) - 140 )
	return xp
func exp_slow(level : int) -> int:
	var xp : int = 0
	xp = int( 5 * pow(level, 3) / 4 )
	return xp
func exp_fluctuating(level : int) -> int:
	var xp : int = 0
	if level <= 15:
		xp = int( pow(level, 3) * ( (((level + 1) / 3) + 24) / 50  ) )
	elif 15 < level && level <= 36:
		xp = int( pow(level, 3) * ( (level + 14) / 50))
	elif 36 < level && level <= 100:
		xp = int( pow(level, 3) * ( ((level / 2) + 32) / 50 ) )
	return xp
func generate_nature():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	nature = rng.randi_range(0,24)
func generate_gender(male_ratio : float):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randf_range(0.0, 100.0) <= male_ratio:
		gender = MALE
	else:
		gender = FEMALE

func update_stats(data):
	attack = int( int ((2 * data.attack + iv_attack + ev_attack) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.ATTACK))
	defense = int( int ((2 * data.defense + iv_defense + ev_defense) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.DEFENSE))
	sp_attack = int( int ((2 * data.sp_attack + iv_sp_attack + ev_sp_attack) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SP_ATTACK))
	sp_defense = int( int ((2 * data.sp_defense + iv_sp_defense + ev_sp_defense) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SP_DEFENSE))
	speed = int( int ((2 * data.speed + iv_speed + ev_speed) * level / 100 + 5 ) * Nature.get_stat_multiplier(nature, Nature.stat_types.SPEED))
	hp = int ( (2 * data.hp + iv_hp + ev_hp) * level / 100 + level + 10 )

func set_basic_pokemon_by_level(id : int, lv : int): # Sets a level 1 version of the pokemon by its ID and sets. Its IV values will be generated here.
	var data = registry.new().get_pokemon_class(id)
	ID = id
	name = data.name
	type1 = data.type1
	type2 = data.type2
	level = lv
	generate_IV()
	generate_nature() # For now random but should be determined by something else
	generate_gender(data.male_ratio)
	
	# Set experience points
	match data.leveling_rate:
		data.SLOW:
			experience = exp_slow(lv)
		data.MEDIUM_SLOW:
			experience = exp_medium_slow(lv)
		data.MEDIUM_FAST:
			experience = exp_medium_fast(lv)
		data.FAST:
			experience = exp_fast(lv)
		data.ERRATIC:
			experience = exp_erratic(lv)
		data.FLUCTUATING:
			experience = exp_fluctuating(lv)
	
	# Set stats
	update_stats(data)
	current_hp = hp
	# Set move set
	var moveset = []
	for move in data.moveset:
		if move.level <= level:
			moveset.push_back(move.move)
	var count = moveset.size()
	if count > 4:
		count = 4
	for i in range(count):
		match i:
			0: 
				move_1 = MoveDataBase.get_move_by_name(moveset.pop_back())
			1: 
				move_2 = MoveDataBase.get_move_by_name(moveset.pop_back())
			2: 
				move_3 = MoveDataBase.get_move_by_name(moveset.pop_back())
			3: 
				move_4 = MoveDataBase.get_move_by_name(moveset.pop_back())
func get_cry():
	return "res://Audio/SE/" + str("%03d" % ID) + "Cry.wav"
func get_battle_foe_sprite() -> Sprite:
	var sprite = Sprite.new()
	var tex : Texture
	if is_shiny:
		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "s.png") as Texture
	else:
		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + ".png") as Texture
	sprite.texture = tex
	if sprite.texture.get_width() != 80:
		var frames = sprite.texture.get_width() / 80
		sprite.hframes = frames
		
		# To do: Add animation to battler

	return sprite
func get_battle_player_sprite() -> Sprite:
	var sprite = Sprite.new()
	var tex : Texture
	if is_shiny:
		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "bs.png") as Texture
	else:
		tex = load("res://Graphics/Battlers/" + str("%03d" % ID) + "b.png") as Texture
	sprite.texture = tex
	return sprite