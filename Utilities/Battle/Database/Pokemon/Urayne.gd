extends Object

# The name of the pokemon
var name = "Urayne"

# Pokedex ID#
var ID = 197

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 82
var attack = 120
var defense = 86
var sp_attack = 134
var sp_defense = 84
var speed = 102

# The pokemon's public and hidden abilities
var ability = "Geiger Sense"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 338

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 15

# Weight in kg
var weight = 240.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Mega Punch"),
	MoveSet.new(1, "Nuclear Slash"),
	MoveSet.new(24, "Gamma Ray"),
	MoveSet.new(30, "Nuclear Slash"),
	MoveSet.new(35, "Radioacid"),
	MoveSet.new(39, "Protect"),
	MoveSet.new(47, "Half-life"),
	MoveSet.new(52, "Nuclear Waste"),
	MoveSet.new(59, "Explosion"),
	MoveSet.new(65, "Fallout"),
	MoveSet.new(71, "Proton Beam"),
	MoveSet.new(75, "Quantum Leap"),
	MoveSet.new(80, "Atomic Punch"),
	MoveSet.new(85, "Fission Burst")
]
