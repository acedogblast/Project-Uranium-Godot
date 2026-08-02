extends Object

# The name of the pokemon
var name = "Colarva"

# Pokedex ID#
var ID = 152

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 45
var attack = 43
var defense = 55
var sp_attack = 60
var sp_defense = 41
var speed = 45

# The pokemon's public and hidden abilities
var ability = "Ice Body"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 69

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 41

# The pokemon's evolution ID
var evolution_ID = 153

# The pokemon's catch rate
var catch_rate = 85

# Weight in kg
var weight = 28.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "String_Shot"),
	MoveSet.new(5, "Tackle"),
	MoveSet.new(9, "Harden"),
	MoveSet.new(14, "Astonish"),
	MoveSet.new(19, "Bug Bite"),
	MoveSet.new(24, "Take Down"),
	MoveSet.new(29, "Ice Ball"),
	MoveSet.new(35, "Hail"),
	MoveSet.new(42, "Avalanche"),
	MoveSet.new(48, "Double-Edge")
]
