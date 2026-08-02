extends Object

# The name of the pokemon
var name = "Xenogen"

# Pokedex ID#
var ID = 169

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 76
var attack = 44
var defense = 76
var sp_attack = 91
var sp_defense = 89
var speed = 74

# The pokemon's public and hidden abilities
var ability = "Damp"
var ability_2 = "Aftermath"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 142

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 25

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 85

# Weight in kg
var weight = 98.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(13, "Growl"),
	MoveSet.new(24, "Glare"),
	MoveSet.new(30, "Gamma Ray"),
	MoveSet.new(35, "Screech"),
	MoveSet.new(39, "Sludge"),
	MoveSet.new(47, "Half-life"),
	MoveSet.new(52, "Nuclear Waste"),
	MoveSet.new(54, "Radioacid"),
	MoveSet.new(61, "Fallout"),
	MoveSet.new(65, "Explosion"),
	MoveSet.new(68, "Proton Beam"),
	MoveSet.new(80, "Fission Burst")
]
