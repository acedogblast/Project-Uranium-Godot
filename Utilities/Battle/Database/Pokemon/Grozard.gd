extends Object

# The name of the pokemon
var name = "Grozard"

# Pokedex ID#
var ID = 18

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 25
var attack = 45
var defense = 25
var sp_attack = 55
var sp_defense = 45
var speed = 85

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 56

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 22

# The pokemon's evolution ID
var evolution_ID = 19

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 14.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(5, "Growl"),
	MoveSet.new(9, "Bulldoze"),
	MoveSet.new(17, "Endure"),
	MoveSet.new(23, "Slash"),
	MoveSet.new(28, "Dig"),
	MoveSet.new(34, "Spike"),
	MoveSet.new(40, "Earthquake"),
	MoveSet.new(47, "Drill Run"),
	MoveSet.new(54, "Fissure"),
]
