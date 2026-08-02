extends Object

# The name of the pokemon
var name = "Selkid"

# Pokedex ID#
var ID = 121

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 58
var attack = 32
var defense = 51
var sp_attack = 66
var sp_defense = 73
var speed = 61

# The pokemon's public and hidden abilities
var ability = "Cute Charm"
var ability_2 = "Swift Swim"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 74

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 0

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 105

# Weight in kg
var weight = 15.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Sing"),
	MoveSet.new(1, "Bubble"),
	MoveSet.new(3, "Charm"),
	MoveSet.new(7, "Water Sport"),
	MoveSet.new(12, "Round"),
	MoveSet.new(18, "Draining Kiss"),
	MoveSet.new(23, "Water Pulse"),
	MoveSet.new(27, "Lucky Chant"),
	MoveSet.new(32, "Whirlpool"),
	MoveSet.new(36, "Aqua Ring"),
	MoveSet.new(42, "Hyper_Voice"),
	MoveSet.new(49, "Perish Song")
]
