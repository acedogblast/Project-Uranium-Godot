extends Object

# The name of the pokemon
var name = "Jerbolta"

# Pokedex ID#
var ID = 53

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2 = Type.GROUND

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 65
var defense = 45
var sp_attack = 110
var sp_defense = 85
var speed = 65

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 142

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
var catch_rate = 200

# Weight in kg
var weight = 2.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Defense Curl"),
	MoveSet.new(5, "Quick Attack"),
	MoveSet.new(9, "Charm"),
	MoveSet.new(13, "Spark"),
	MoveSet.new(17, "Endure"),
	MoveSet.new(21, "Mud Shot"),
	MoveSet.new(25, "Electroball"),
	MoveSet.new(29, "Magnitude"),
	MoveSet.new(33, "Rollout"),
	MoveSet.new(37, "Hyper Fang"),
	MoveSet.new(41, "Discharge"),
	MoveSet.new(45, "Earth Power"),
	MoveSet.new(49, "Super Fang")
]
