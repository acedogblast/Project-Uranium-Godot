extends Object

# The name of the pokemon
var name = "dearewl"

# Pokedex ID#
var ID = 16

# The pokemon's type. If only one type use type1
var type1 = Type.STEEL
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 65
var attack = 75
var defense = 120
var sp_attack = 50
var sp_defense = 65
var speed = 45

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
var exp_yield : int = 133

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 32

# The pokemon's evolution ID
var evolution_ID = 17

# The pokemon's catch rate
var catch_rate = 180

# Weight in kg
var weight = 120.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(4, "Harden"),
	MoveSet.new(7, "Mudslap"),
	MoveSet.new(10, "Headbutt"),
	MoveSet.new(13, "Metal Claw"),
	MoveSet.new(17, "Rock Polish"),
	MoveSet.new(21, "Rollout"),
	MoveSet.new(25, "Protect"),
	MoveSet.new(29, "Metal Whip"),
	MoveSet.new(33, "Metal Sound"),
	MoveSet.new(37, "Body Slam"),
	MoveSet.new(40, "Rapid Spin"),
	MoveSet.new(44, "Earthquake")
]
