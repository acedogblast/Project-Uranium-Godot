extends Object

# The name of the pokemon
var name = "Lombre"

# Pokedex ID#
var ID = 38

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.GRASS

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 50
var defense = 50
var sp_attack = 60
var sp_defense = 70
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
var exp_yield : int = 119

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID = 39

# The pokemon's catch rate
var catch_rate = 120

# Weight in kg
var weight = 32.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Astonish"),
	MoveSet.new(3, "Growl"),
	MoveSet.new(6, "Absorb"),
	MoveSet.new(9, "Bubble"),
	MoveSet.new(12, "Fury Swipes"),
	MoveSet.new(16, "Fake Out"),
	MoveSet.new(20, "Water Sport"),
	MoveSet.new(24, "Bubble Beam"),
	MoveSet.new(28, "Nature Power"),
	MoveSet.new(32, "Uproar"),
	MoveSet.new(36, "Knock Off"),
	MoveSet.new(40, "Zen Headbutt"),
	MoveSet.new(44, "Hydro Pump")
]
