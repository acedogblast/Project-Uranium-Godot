extends Object

# The name of the pokemon
var name = "Cocancer"

# Pokedex ID#
var ID = 80

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.GROUND

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 95
var defense = 120
var sp_attack = 35
var sp_defense = 115
var speed = 60

# The pokemon's public and hidden abilities
var ability = "Sand Veil"
var ability_2 = "Chlorophyll"
var hidden_ability = "Harvest"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 232

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 240.7

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Sandstorm"),
	MoveSet.new(1, "Sunny Day"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Withdraw"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(1, "Absorb"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Absorb"),
	MoveSet.new(13, "Water Gun"),
	MoveSet.new(17, "Sand Tomb"),
	MoveSet.new(20, "Curse"),
	MoveSet.new(22, "Crabhammer"),
	MoveSet.new(29, "Mega Drain"),
	MoveSet.new(35, "Dig"),
	MoveSet.new(41, "Synthesis"),
	MoveSet.new(46, "Wood Hammer"),
	MoveSet.new(52, "Shell Smash"),
	MoveSet.new(57, "Guillotine"),
	MoveSet.new(61, "Solar Beam")
]
