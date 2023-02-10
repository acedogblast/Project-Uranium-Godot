extends Object

# The name of the pokemon
var name = "Tonemy"

# Pokedex ID#
var ID = 20

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 45
var defense = 45
var sp_attack = 40
var sp_defense = 45
var speed = 95

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 66

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 20

# The pokemon's evolution ID
var evolution_ID = 20

# The pokemon's catch rate
var catch_rate = 190

# Weight in kg
var weight = 1.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Gas"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(9, "Smog"),
	MoveSet.new(16, "Lick"),
	MoveSet.new(21, "Poison Fang"),
	MoveSet.new(33, "Haze"),
	MoveSet.new(37, "Stockpile"),
	MoveSet.new(37, "Spit Up"),
	MoveSet.new(37, "Swallow"),
	MoveSet.new(40, "Toxic"),
	MoveSet.new(45, "Gunk Shot")
]
