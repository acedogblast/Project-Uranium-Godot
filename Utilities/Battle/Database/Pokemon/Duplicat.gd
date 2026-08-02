extends Object

# The name of the pokemon
var name = "Duplicat"

# Pokedex ID#
var ID = 128

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 58
var attack = 58
var defense = 58
var sp_attack = 58
var sp_defense = 58
var speed = 58

# The pokemon's public and hidden abilities
var ability = "Prankster"
var ability_2 = "Trace"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 137

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 75

# Weight in kg
var weight = 7.2

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Glare"),
	MoveSet.new(1, "Copycat"),
	MoveSet.new(1, "Double Team"),
	MoveSet.new(11, "Confuse Ray"),
	MoveSet.new(22, "Substitute"),
	MoveSet.new(33, "Transform"),
	MoveSet.new(38, "Mirror Coat")
]
