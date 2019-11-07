extends Object

class_name Pokemon

# The name of the pokemon
var name

# Pokedex ID#
var ID

# The pokemon's type. If only one type use type1
var type1
var type2

# The pokemon's stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp
var attack
var defense
var sp_attack
var sp_defense
var speed

# The pokemon's level
var level

# The pokemon's total experience
var experience

# The pokemon's nature
var nature

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Individual Values
var iv_hp
var iv_attack
var iv_defense
var iv_sp_attack
var iv_sp_defense
var iv_speed

# The pokemon's Effort Values
var ev_hp
var ev_attack
var ev_defense
var ev_sp_attack
var ev_sp_defense
var ev_speed

# The pokemon's held Item
var item

# The pokemon's Move set
var move_1
var move_2
var move_3
var move_4

# The pokemon's gender
var gender
enum {MALE, FEMALE}

var leveling_rate
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC}

func set_stats_by_level(): 
	
	pass
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
