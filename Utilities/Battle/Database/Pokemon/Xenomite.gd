extends Object

# The name of the pokemon
var name = "Xenomite"

# Pokedex ID#
var ID = 168

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 66
var attack = 44
var defense = 56
var sp_attack = 76
var sp_defense = 74
var speed = 64

# The pokemon's public and hidden abilities
var ability = "Damp"
var ability_2 = "Aftermath"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 58

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 25

# The pokemon's evolution level
var evolution_level = 55

# The pokemon's evolution ID
var evolution_ID = 169

# The pokemon's catch rate
var catch_rate = 150

# Weight in kg
var weight = 35.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Bite"),
	MoveSet.new(9, "Growl"),
	MoveSet.new(19, "Glare"),
	MoveSet.new(27, "Gamma Ray"),
	MoveSet.new(31, "Screech"),
	MoveSet.new(35, "Sludge"),
	MoveSet.new(42, "Half-life"),
	MoveSet.new(46, "Nuclear Waste"),
	MoveSet.new(51, "Radioacid"),
	MoveSet.new(56, "Fallout"),
	MoveSet.new(59, "Explosion"),
	MoveSet.new(62, "Proton Beam"),
	MoveSet.new(75, "Fission Burst")
]
