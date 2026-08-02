extends Object

# The name of the pokemon
var name = "Cocaran"

# Pokedex ID#
var ID = 78

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.GROUND

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 70
var defense = 75
var sp_attack = 35
var sp_defense = 70
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Sand Veil"
var ability_2 = "Chlorophyll"
var hidden_ability = "Harvest"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 72

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 24

# The pokemon's evolution ID
var evolution_ID = 79

# The pokemon's catch rate
var catch_rate = 145

# Weight in kg
var weight = 14.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Withdraw"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Absorb"),
	MoveSet.new(13, "Water Gun"),
	MoveSet.new(17, "Sand Tomb"),
	MoveSet.new(20, "Curse"),
	MoveSet.new(22, "Crabhammer"),
	MoveSet.new(27, "Mega Drain"),
	MoveSet.new(32, "Dig"),
	MoveSet.new(37, "Synthesis"),
	MoveSet.new(42, "Leaf_Blade"),
	MoveSet.new(47, "Shell Smash"),
	MoveSet.new(52, "Guillotine"),
	MoveSet.new(57, "Solar Beam")
]
