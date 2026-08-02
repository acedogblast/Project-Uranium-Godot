extends Object

# The name of the pokemon
var name = "Daikatuna"

# Pokedex ID#
var ID = 120

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 118
var defense = 75
var sp_attack = 53
var sp_defense = 50
var speed = 110

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var ability_2 = "Inner Focus"
var hidden_ability = "Sheer Force"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 225

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 15

# Weight in kg
var weight = 58.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Aqua_Jet"),
	MoveSet.new(1, "Iron Head"),
	MoveSet.new(1, "Swords Dance"),
	MoveSet.new(1, "Slash"),
	MoveSet.new(1, "Night Slash")
]
