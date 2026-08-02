extends Object

# The name of the pokemon
var name = "Harptera"

# Pokedex ID#
var ID = 108

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 130
var defense = 75
var sp_attack = 90
var sp_defense = 75
var speed = 125

# The pokemon's public and hidden abilities
var ability = "Moxie"
var ability_2 = "Gale Wings"
var hidden_ability = "Unburden"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 2
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 188

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
var catch_rate = 75

# Weight in kg
var weight = 41.1

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Fury Cutter"),
	MoveSet.new(1, "Air_Cutter"),
	MoveSet.new(7, "Double Team"),
	MoveSet.new(12, "Wing Attack"),
	MoveSet.new(15, "Sonic Boom"),
	MoveSet.new(18, "Quick Attack"),
	MoveSet.new(21, "Supersonic"),
	MoveSet.new(25, "Detect"),
	MoveSet.new(28, "Air_Slash"),
	MoveSet.new(31, "Pursuit"),
	MoveSet.new(34, "Slash"),
	MoveSet.new(37, "Tailwind"),
	MoveSet.new(40, "U-turn"),
	MoveSet.new(43, "Acrobatics"),
	MoveSet.new(47, "Bug Buzz"),
	MoveSet.new(51, "Night Slash")
]
