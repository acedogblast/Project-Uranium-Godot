extends Object

# The name of the pokemon
var name = "Gyarados"

# Pokedex ID#
var ID = 28

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 95
var attack = 125
var defense = 79
var sp_attack = 60
var sp_defense = 100
var speed = 81

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 189

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
var catch_rate = 45

# Weight in kg
var weight = 235.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Thrash"),
	MoveSet.new(20, "Bite"),
	MoveSet.new(23, "Dragon Rage"),
	MoveSet.new(26, "Leer"),
	MoveSet.new(29, "Twister"),
	MoveSet.new(32, "Ice Fang"),
	MoveSet.new(35, "Aqua Tail"),
	MoveSet.new(38, "Rain Dance"),
	MoveSet.new(41, "Hydro Pump"),
	MoveSet.new(44, "Dragon Dance"),
	MoveSet.new(47, "Hyper Beam")
]
