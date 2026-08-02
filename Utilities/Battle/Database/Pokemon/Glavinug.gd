extends Object

# The name of the pokemon
var name = "Glavinug"

# Pokedex ID#
var ID = 96

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 95
var attack = 75
var defense = 80
var sp_attack = 115
var sp_defense = 115
var speed = 70

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var ability_2 = "Natural Cure"
var hidden_ability = "Snow Warning"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 193

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
var weight = 44.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Recover"),
	MoveSet.new(1, "Bubble Beam"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Protect"),
	MoveSet.new(1, "Defense Curl"),
	MoveSet.new(1, "Ice_Beam")
]
