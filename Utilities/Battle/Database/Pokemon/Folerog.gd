extends Object

# The name of the pokemon
var name = "Folerog"

# Pokedex ID#
var ID = 25

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 60
var defense = 60
var sp_attack = 75
var sp_defense = 90
var speed = 50

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 2
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 145

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 36

# The pokemon's evolution ID
var evolution_ID = 26

# The pokemon's catch rate
var catch_rate = 175

# Weight in kg
var weight = 85.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "Supersonic"),
	MoveSet.new(6, "Supersonic"),
	MoveSet.new(12, "Pound"),
	MoveSet.new(21, "Smog"),
	MoveSet.new(24, "Sludge"),
	MoveSet.new(29, "Aqua Ring"),
	MoveSet.new(34, "Acid Armor"),
	MoveSet.new(39, "Muddy Water"),
	MoveSet.new(44, "Sludge Wave"),
	MoveSet.new(49, "Hydro Pump")
]
