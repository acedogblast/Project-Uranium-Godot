extends Object

# The name of the pokemon
var name = "Stenowatt"

# Pokedex ID#
var ID = 163

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 85
var defense = 60
var sp_attack = 75
var sp_defense = 80
var speed = 110

# The pokemon's public and hidden abilities
var ability = "Motor Drive"
var ability_2 = "Speed Boost"
var hidden_ability = "Acceleration"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 150

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 82

# Weight in kg
var weight = 67.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(7, "Quick Attack"),
	MoveSet.new(9, "Charge Beam"),
	MoveSet.new(13, "Flash"),
	MoveSet.new(18, "Double Team"),
	MoveSet.new(20, "Spark"),
	MoveSet.new(25, "Charge"),
	MoveSet.new(29, "Baton Pass"),
	MoveSet.new(33, "Wild Charge"),
	MoveSet.new(37, "Discharge"),
	MoveSet.new(41, "Extreme_Speed"),
	MoveSet.new(45, "Thunderbolt"),
	MoveSet.new(50, "Electro Ball"),
	MoveSet.new(60, "Tail_Glow")
]
