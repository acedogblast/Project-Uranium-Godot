extends Object

# The name of the pokemon
var name = "Blubelrog"

# Pokedex ID#
var ID = 26

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 105
var attack = 70
var defense = 75
var sp_attack = 105
var sp_defense = 115
var speed = 65

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 3
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 241

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 110

# Weight in kg
var weight = 98.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Icy Wing"),
	MoveSet.new(1, "Bubble Beam"),
	MoveSet.new(1, "Supersonic"),
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(7, "Pound"),
	MoveSet.new(10, "Acid"),
	MoveSet.new(15, "Bubble Beam"),
	MoveSet.new(30, "Sludge"),
	MoveSet.new(34, "Acid Armor"),
	MoveSet.new(39, "Ice Beam"),
	MoveSet.new(43, "Muddy Water"),
	MoveSet.new(47, "Sludge Wave"),
	MoveSet.new(54, "Focus Punch"),
	MoveSet.new(58, "Hydro Pump")
]
