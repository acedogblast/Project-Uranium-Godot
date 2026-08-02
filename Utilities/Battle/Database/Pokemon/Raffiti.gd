extends Object

# The name of the pokemon
var name = "Raffiti"

# Pokedex ID#
var ID = 140

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 80
var defense = 70
var sp_attack = 80
var sp_defense = 70
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Insomnia"
var ability_2 = "Quick Feet"
var hidden_ability = "Pickup"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 163

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 81.1

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Thief"),
	MoveSet.new(11, "Taunt"),
	MoveSet.new(21, "Sketch"),
	MoveSet.new(31, "Knock Off"),
	MoveSet.new(41, "Crunch"),
	MoveSet.new(51, "Sketch"),
	MoveSet.new(55, "Sucker Punch"),
	MoveSet.new(61, "Hyper Fang"),
	MoveSet.new(71, "Shadow Sneak"),
	MoveSet.new(81, "Sketch")
]
