extends Object

# The name of the pokemon
var name = "Terlard"

# Pokedex ID#
var ID = 19

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.DRAGON
# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 80
var defense = 65
var sp_attack = 85
var sp_defense = 70
var speed = 95

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 159

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 50

# Weight in kg
var weight = 86.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tri Attack"),
	MoveSet.new(1, "Double Hit"),
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Growl"),
	MoveSet.new(9, "Magnitude"),
	MoveSet.new(14, "Slash"),
	MoveSet.new(17, "Endure"),
	MoveSet.new(25, "Dual Chop"),
	MoveSet.new(31, "Dig"),
	MoveSet.new(38, "Spike"),
	MoveSet.new(44, "Earthquake"),
	MoveSet.new(50, "Dragon Rush"),
	MoveSet.new(56, "Fissure"),
]
