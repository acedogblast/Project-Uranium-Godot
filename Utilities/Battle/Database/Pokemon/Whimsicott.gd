extends Object

# The name of the pokemon
var name = "Whimsicott"

# Pokedex ID#
var ID = 91

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 65
var defense = 85
var sp_attack = 80
var sp_defense = 75
var speed = 115

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
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 168

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
var catch_rate = 75

# Weight in kg
var weight = 6.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growth"),
	MoveSet.new(1, "Leech Seed"),
	MoveSet.new(1, "Cotton Spore"),
	MoveSet.new(1, "Mega Drain"),
	MoveSet.new(10, "Gust"),
	MoveSet.new(28, "Tailwind"),
	MoveSet.new(46, "Hurricane"),
	MoveSet.new(50, "Moonblast")
]
