extends Object

# The name of the pokemon
var name = "Ludicolo"

# Pokedex ID#
var ID = 39

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.GRASS

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 70
var defense = 70
var sp_attack = 90
var sp_defense = 100
var speed = 70

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
var exp_yield : int = 216

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 55.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Astonish"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Mega Drain"),
	MoveSet.new(1, "Nature Power")
]
