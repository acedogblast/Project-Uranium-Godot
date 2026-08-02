extends Object

# The name of the pokemon
var name = "Geigeroach"

# Pokedex ID#
var ID = 172

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.NUCLEAR

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 66
var attack = 54
var defense = 104
var sp_attack = 92
var sp_defense = 66
var speed = 88

# The pokemon's public and hidden abilities
var ability = "Lead Skin"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 147

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
var catch_rate = 45

# Weight in kg
var weight = 39.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Toxic"),
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(5, "Harden"),
	MoveSet.new(9, "Reflect"),
	MoveSet.new(12, "Bug Bite"),
	MoveSet.new(17, "Light Screen"),
	MoveSet.new(21, "Gamma Ray"),
	MoveSet.new(25, "Half-life"),
	MoveSet.new(29, "Nuclear Waste"),
	MoveSet.new(33, "Infestation"),
	MoveSet.new(37, "X-Scissor"),
	MoveSet.new(41, "Acid Armor"),
	MoveSet.new(50, "Nuclear Slash"),
	MoveSet.new(65, "Proton Beam")
]
