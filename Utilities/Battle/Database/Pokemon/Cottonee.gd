extends Object

# The name of the pokemon
var name = "Cottonee"

# Pokedex ID#
var ID = 90

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 30
var defense = 60
var sp_attack = 35
var sp_defense = 50
var speed = 65

# The pokemon's public and hidden abilities
var ability = "Prankster"
var ability_2 = "Infiltrator"
var hidden_ability = "Chlorophyll"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 56

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
var catch_rate = 190

# Weight in kg
var weight = 0.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Absorb"),
	MoveSet.new(1, "Fairy Wind"),
	MoveSet.new(4, "Growth"),
	MoveSet.new(8, "Leech Seed"),
	MoveSet.new(10, "Stun Spore"),
	MoveSet.new(13, "Mega Drain"),
	MoveSet.new(17, "Cotton Spore"),
	MoveSet.new(19, "Razor Leaf"),
	MoveSet.new(22, "Poison Powder"),
	MoveSet.new(26, "Giga Drain"),
	MoveSet.new(28, "Charm"),
	MoveSet.new(31, "Helping Hand"),
	MoveSet.new(35, "Energy Ball"),
	MoveSet.new(37, "Cotton Guard"),
	MoveSet.new(40, "Sunny Day"),
	MoveSet.new(44, "Endeavor"),
	MoveSet.new(46, "Solar Beam"),
	MoveSet.new(50, "Petal Dance")
]
