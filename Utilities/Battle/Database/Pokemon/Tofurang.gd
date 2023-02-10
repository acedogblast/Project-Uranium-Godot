extends Object

# The name of the pokemon
var name = "Tofurang"

# Pokedex ID#
var ID = 21

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 100
var attack = 60
var defense = 85
var sp_attack = 40
var sp_defense = 85
var speed = 60

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 2
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 151

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 60

# Weight in kg
var weight = 99.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Gas"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(9, "Smog"),
	MoveSet.new(16, "Lick"),
	MoveSet.new(21, "Poison Fang"),
	MoveSet.new(33, "Haze"),
	MoveSet.new(41, "Stockpile"),
	MoveSet.new(41, "Spit Up"),
	MoveSet.new(41, "Swallow"),
	MoveSet.new(45, "Toxic"),
	MoveSet.new(49, "Gunk Shot")
]
