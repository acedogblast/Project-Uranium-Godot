extends Object

# The name of the pokemon
var name = "Lotad"

# Pokedex ID#
var ID = 37

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.GRASS

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 30
var defense = 30
var sp_attack = 40
var sp_defense = 50
var speed = 30

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 44

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 14

# The pokemon's evolution ID
var evolution_ID = 38

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 2.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Astonish"),
	MoveSet.new(3, "Growl"),
	MoveSet.new(6, "Absorb"),
	MoveSet.new(9, "Bubble"),
	MoveSet.new(12, "Natural Gift"),
	MoveSet.new(15, "Mist"),
	MoveSet.new(18, "Mega Drain"),
	MoveSet.new(21, "Bubble Beam"),
	MoveSet.new(24, "Nature Power"),
	MoveSet.new(27, "Rain Dance"),
	MoveSet.new(30, "Giga Grain"),
	MoveSet.new(33, "Zen Headbutt"),
	MoveSet.new(36, "Energy Ball")
]
