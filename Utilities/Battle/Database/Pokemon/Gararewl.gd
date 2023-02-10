extends Object

# The name of the pokemon
var name = "Gararewl"

# Pokedex ID#
var ID = 17

# The pokemon's type. If only one type use type1
var type1 = Type.STEEL
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 100
var defense = 140
var sp_attack = 65
var sp_defense = 85
var speed = 55

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 3
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 201

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
var catch_rate = 90

# Weight in kg
var weight = 190.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(1, "Stomp"),
	MoveSet.new(1, "Headbutt"),
	MoveSet.new(4, "Harden"),
	MoveSet.new(7, "Mudslap"),
	MoveSet.new(10, "Headbutt"),
	MoveSet.new(13, "Metal Claw"),
	MoveSet.new(17, "Iron Defense"),
	MoveSet.new(21, "Rollout"),
	MoveSet.new(25, "Take Down"),
	MoveSet.new(31, "Metal Whip"),
	MoveSet.new(37, "Metal Sound"),
	MoveSet.new(44, "Iron Head"),
	MoveSet.new(49, "Head Smash")
]
