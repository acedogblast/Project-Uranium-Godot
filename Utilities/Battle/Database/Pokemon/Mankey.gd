extends Object

# The name of the pokemon
var name = "Mankey"

# Pokedex ID#
var ID = 32

# The pokemon's type. If only one type use type1
var type1 = Type.FIGHTING
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 80
var defense = 35
var sp_attack = 35
var sp_defense = 45
var speed = 70

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 61

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 28

# The pokemon's evolution ID
var evolution_ID = 33

# The pokemon's catch rate
var catch_rate = 190

# Weight in kg
var weight = 28.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Covet"),
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Low Kick"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Focus Energy"),
	MoveSet.new(9, "Furry Swipes"),
	MoveSet.new(13, "Karate Chop"),
	MoveSet.new(17, "Seismic Toss"),
	MoveSet.new(21, "Screech"),
	MoveSet.new(25, "Assurance"),
	MoveSet.new(33, "Swagger"),
	MoveSet.new(37, "Cross Chop"),
	MoveSet.new(41, "Thrash"),
	MoveSet.new(45, "Punishment"),
	MoveSet.new(49, "Close Combat"),
	MoveSet.new(53, "Final Gambit")
]
