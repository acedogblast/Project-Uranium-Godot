extends Object

# The name of the pokemon
var name = "Feleng"

# Pokedex ID#
var ID = 29

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 95
var defense = 70
var sp_attack = 45
var sp_defense = 37
var speed = 95

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 57

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 19

# The pokemon's evolution ID
var evolution_ID = 30

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 17.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Yawn"),
	MoveSet.new(7, "Encore"),
	MoveSet.new(11, "Fury Swipes"),
	MoveSet.new(15, "Charm"),
	MoveSet.new(18, "Feint Attack"),
	MoveSet.new(23, "Assist"),
	MoveSet.new(28, "Covet"),
	MoveSet.new(33, "Slack Off"),
	MoveSet.new(37, "Slash"),
	MoveSet.new(41, "Attract"),
	MoveSet.new(44, "Hone Claws")
]
