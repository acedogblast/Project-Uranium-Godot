extends Object

# The name of the pokemon
var name = "Xenoqueen"

# Pokedex ID#
var ID = 170

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 96
var attack = 44
var defense = 96
var sp_attack = 116
var sp_defense = 114
var speed = 84

# The pokemon's public and hidden abilities
var ability = "Damp"
var ability_2 = "Aftermath"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 218

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
var catch_rate = 45

# Weight in kg
var weight = 470.9

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
	MoveSet.new(59, "Radioacid"),
	MoveSet.new(65, "Fallout"),
	MoveSet.new(71, "Explosion"),
	MoveSet.new(75, "Proton Beam"),
	MoveSet.new(85, "Fission Burst")
]
