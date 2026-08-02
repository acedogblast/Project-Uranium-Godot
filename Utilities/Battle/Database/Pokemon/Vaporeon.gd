extends Object

# The name of the pokemon
var name = "Vaporeon"

# Pokedex ID#
var ID = 130

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 130
var attack = 65
var defense = 60
var sp_attack = 110
var sp_defense = 95
var speed = 65

# The pokemon's public and hidden abilities
var ability = "Water Absorb"
var hidden_ability = "Hydration"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
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
var weight = 29.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Helping Hand"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Water Gun"),
	MoveSet.new(13, "Quick Attack"),
	MoveSet.new(17, "Water Pulse"),
	MoveSet.new(21, "Aurora Beam"),
	MoveSet.new(25, "Aqua Ring"),
	MoveSet.new(29, "Acid Armor"),
	MoveSet.new(33, "Haze"),
	MoveSet.new(37, "Muddy Water"),
	MoveSet.new(41, "Last Resort"),
	MoveSet.new(45, "Hydro Pump")
]
