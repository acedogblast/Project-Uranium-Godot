extends Object

# The name of the pokemon
var name = "Archilles"

# Pokedex ID#
var ID = 4

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.GROUND

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 90
var defense = 80
var sp_attack = 90
var sp_defense = 80
var speed = 125

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 3

# The pokemon's base experience yield when defeated
var exp_yield : int = 243

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 85.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Ember"),
	MoveSet.new(1, "Mud-Slap"),
	MoveSet.new(7, "Ember"),
	MoveSet.new(13, "Mud-Slap"),
	MoveSet.new(20, "Flame Wheel"),
	MoveSet.new(27, "Magnitude"),
	MoveSet.new(31, "Slash"),
	MoveSet.new(36, "Flamethrower"),
	MoveSet.new(41, "Extreme Speed"),
	MoveSet.new(46, "Flame Impact"),
	MoveSet.new(51, "Earthquake"),
	MoveSet.new(56, "Flare Blitz")
]
