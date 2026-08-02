extends Object

# The name of the pokemon
var name = "Pufluff"

# Pokedex ID#
var ID = 149

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 45
var defense = 45
var sp_attack = 60
var sp_defense = 50
var speed = 52

# The pokemon's public and hidden abilities
var ability = "Snow Cloak"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 74

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 120

# Weight in kg
var weight = 8.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Fairy Wind"),
	MoveSet.new(9, "Charm"),
	MoveSet.new(13, "Icy Wind"),
	MoveSet.new(17, "Fury Swipes"),
	MoveSet.new(21, "Cotton Guard"),
	MoveSet.new(25, "Disarming Voice"),
	MoveSet.new(29, "Baton Pass"),
	MoveSet.new(33, "Flail"),
	MoveSet.new(36, "Aurora Beam"),
	MoveSet.new(41, "Rest"),
	MoveSet.new(45, "Blizzard"),
	MoveSet.new(49, "Hail"),
	MoveSet.new(53, "Play Rough")
]
