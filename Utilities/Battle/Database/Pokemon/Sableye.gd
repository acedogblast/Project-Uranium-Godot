extends Object

# The name of the pokemon
var name = "Sableye"

# Pokedex ID#
var ID = 77

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.GHOST

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 75
var defense = 75
var sp_attack = 65
var sp_defense = 65
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Keen Eye"
var ability_2 = "Stall"
var hidden_ability = "Prankster"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 133

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 11.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Scratch"),
	MoveSet.new(4, "Foresight"),
	MoveSet.new(6, "Night Shade"),
	MoveSet.new(9, "Astonish"),
	MoveSet.new(11, "Fury Swipes"),
	MoveSet.new(14, "Detect"),
	MoveSet.new(16, "Shadow Sneak"),
	MoveSet.new(19, "Feint Attack"),
	MoveSet.new(21, "Fake Out"),
	MoveSet.new(24, "Punishment"),
	MoveSet.new(26, "Knock Off"),
	MoveSet.new(29, "Shadow Claw"),
	MoveSet.new(31, "Confuse Ray"),
	MoveSet.new(34, "Zen Headbutt"),
	MoveSet.new(36, "Power Gem"),
	MoveSet.new(39, "Shadow_Ball"),
	MoveSet.new(41, "Foul Play"),
	MoveSet.new(46, "Mean Look")
]
