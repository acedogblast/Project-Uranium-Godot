extends Object

# The name of the pokemon
var name = "Nucleon"

# Pokedex ID#
var ID = 138

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 55
var defense = 85
var sp_attack = 115
var sp_defense = 115
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Atomizate"
var hidden_ability = "Geiger Sense"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 184

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 21.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Helping Hand"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Gamma Ray"),
	MoveSet.new(12, "Quick Attack"),
	MoveSet.new(17, "Swift"),
	MoveSet.new(21, "Headbutt"),
	MoveSet.new(25, "Half-life"),
	MoveSet.new(29, "Flash"),
	MoveSet.new(33, "Mirror Coat"),
	MoveSet.new(37, "Conversion 2"),
	MoveSet.new(41, "Last Resort"),
	MoveSet.new(45, "Hyper_Voice")
]
