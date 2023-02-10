extends Object

# The name of the pokemon
var name = "Sponaree"

# Pokedex ID#
var ID = 49

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.WATER

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 88
var attack = 35
var defense = 68
var sp_attack = 82
var sp_defense = 90
var speed = 70

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 152

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 90

# Weight in kg
var weight = 20.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(1, "Scary Face"),
	MoveSet.new(1, "Water Gun"),
	MoveSet.new(6, "Struggle Bug"),
	MoveSet.new(11, "Water Gun"),
	MoveSet.new(17, "Rain Dance"),
	MoveSet.new(25, "Bug Bite"),
	MoveSet.new(34, "Bubble Beam"),
	MoveSet.new(39, "Spider Web"),
	MoveSet.new(44, "Brine"),
	MoveSet.new(49, "Bug Buzz"),
	MoveSet.new(58, "Hydro Pump")
]
