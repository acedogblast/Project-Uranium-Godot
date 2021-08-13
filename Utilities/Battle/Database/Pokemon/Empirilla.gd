extends Object

# The name of the pokemon
var name = "Empirilla"

# Pokedex ID#
var ID = 34

# The pokemon's type. If only one type use type1
var type1 = Type.FIGHTING
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 115
var defense = 70
var sp_attack = 80
var sp_defense = 80
var speed = 95

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 3
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 159

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
var catch_rate = 35

# Weight in kg
var weight = 88.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Bulk Up"),
	MoveSet.new(1, "Drain Punch"),
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Low Kick"),
	MoveSet.new(1, "Rage"),
	MoveSet.new(9, "Furry Swipes"),
	MoveSet.new(13, "Karate Chop"),
	MoveSet.new(21, "Screech"),
	MoveSet.new(25, "Assurance"),
	MoveSet.new(28, "Rage"),
	MoveSet.new(35, "Swagger"),
	MoveSet.new(41, "Cross Chop"),
	MoveSet.new(47, "Thrash"),
	MoveSet.new(53, "Drain Punch"),
	MoveSet.new(59, "Close Combat"),
	MoveSet.new(63, "Head Charge")
]
