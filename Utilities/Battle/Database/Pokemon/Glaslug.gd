extends Object

# The name of the pokemon
var name = "Glaslug"

# Pokedex ID#
var ID = 95

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 25
var defense = 35
var sp_attack = 70
var sp_defense = 70
var speed = 35

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var ability_2 = "Natural Cure"
var hidden_ability = "Snow Warning"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 61

# The pokemon's leveling rate
var leveling_rate = SLOW
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
var weight = 18.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Protect"),
	MoveSet.new(6, "Defense Curl"),
	MoveSet.new(10, "Icy Wind"),
	MoveSet.new(15, "Take Down"),
	MoveSet.new(19, "Taunt"),
	MoveSet.new(24, "Bubble Beam"),
	MoveSet.new(28, "Glaciate"),
	MoveSet.new(33, "Recover"),
	MoveSet.new(37, "Ice_Beam"),
	MoveSet.new(42, "Icicle Crash"),
	MoveSet.new(46, "Hydro Pump"),
	MoveSet.new(50, "Sheer Cold")
]
