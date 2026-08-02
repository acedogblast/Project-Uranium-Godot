extends Object

# The name of the pokemon
var name = "Unymph"

# Pokedex ID#
var ID = 107

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 45
var attack = 65
var defense = 75
var sp_attack = 25
var sp_defense = 35
var speed = 20

# The pokemon's public and hidden abilities
var ability = "Shield Dust"
var ability_2 = "Compound eyes"
var hidden_ability = "Suction Cups"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 90

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 28

# The pokemon's evolution ID
var evolution_ID = 108

# The pokemon's catch rate
var catch_rate = 190

# Weight in kg
var weight = 21.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Water Sport"),
	MoveSet.new(1, "Mud Sport"),
	MoveSet.new(7, "Tackle"),
	MoveSet.new(14, "Mud-Slap"),
	MoveSet.new(21, "Bug Bite"),
	MoveSet.new(28, "Screech"),
	MoveSet.new(35, "Struggle_Bug"),
	MoveSet.new(41, "Silver Wind")
]
