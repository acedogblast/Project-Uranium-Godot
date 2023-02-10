extends Object

# The name of the pokemon
var name = "Chyinmunk"

# Pokedex ID#
var ID = 7

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 35
var attack = 40
var defense = 50
var sp_attack = 55
var sp_defense = 50
var speed = 55

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 57

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 14

# The pokemon's evolution ID
var evolution_ID = 8

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 6.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(6, "Charge"),
	MoveSet.new(13, "Thunder Shock"),
	MoveSet.new(15, "Quick Attack"),
	MoveSet.new(20, "Double Team"),
	MoveSet.new(24, "Spark"),
	MoveSet.new(29, "Hyper Fang"),
	MoveSet.new(32, "Endeavor"),
	MoveSet.new(39, "Super Fang"),
	MoveSet.new(44, "Agility")
]
