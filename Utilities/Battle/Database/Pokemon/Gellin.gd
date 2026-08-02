extends Object

# The name of the pokemon
var name = "Gellin"

# Pokedex ID#
var ID = 89

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 35
var defense = 75
var sp_attack = 120
var sp_defense = 100
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Chlorophyll"
var hidden_ability = "Solar Power"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 177

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 38.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Acupressure"),
	MoveSet.new(1, "Magnet Rise"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Absorb"),
	MoveSet.new(1, "Growth"),
	MoveSet.new(1, "Shock Wave"),
	MoveSet.new(7, "Growth"),
	MoveSet.new(11, "Shock Wave"),
	MoveSet.new(17, "Mega Drain"),
	MoveSet.new(21, "Synthesis"),
	MoveSet.new(27, "Sunny Day"),
	MoveSet.new(31, "Giga Drain"),
	MoveSet.new(38, "Thunderbolt"),
	MoveSet.new(43, "Recover"),
	MoveSet.new(50, "Energy Ball"),
	MoveSet.new(55, "Acid Armor"),
	MoveSet.new(62, "Solar Beam")
]
