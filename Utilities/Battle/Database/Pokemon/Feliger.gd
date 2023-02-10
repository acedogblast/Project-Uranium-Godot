extends Object

# The name of the pokemon
var name = "Feliger"

# Pokedex ID#
var ID = 31

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 120
var attack = 155
var defense = 105
var sp_attack = 35
var sp_defense = 95
var speed = 65

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 245

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
var weight = 130.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Yawn"),
	MoveSet.new(7, "Encore"),
	MoveSet.new(13, "Fury Swipes"),
	MoveSet.new(17, "Charm"),
	MoveSet.new(19, "Low Kick"),
	MoveSet.new(23, "Feint Attack"),
	MoveSet.new(28, "Assist"),
	MoveSet.new(34, "Body Slam"),
	MoveSet.new(42, "Slack Off"),
	MoveSet.new(43, "Slash"),
	MoveSet.new(47, "Snore"),
	MoveSet.new(53, "Hone Claws"),
	MoveSet.new(57, "Crush Claw")
]
