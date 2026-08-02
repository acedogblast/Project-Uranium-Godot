extends Object

# The name of the pokemon
var name = "Gargryph"

# Pokedex ID#
var ID = 141

# The pokemon's type. If only one type use type1
var type1 = Type.ROCK
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 80
var defense = 150
var sp_attack = 85
var sp_defense = 75
var speed = 70

# The pokemon's public and hidden abilities
var ability = "Rebuild"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 3
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 189

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
var catch_rate = 30

# Weight in kg
var weight = 230.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Harden"),
	MoveSet.new(1, "Glare"),
	MoveSet.new(1, "Headbutt"),
	MoveSet.new(9, "Rock Throw"),
	MoveSet.new(17, "Torment"),
	MoveSet.new(25, "Stealth Rock"),
	MoveSet.new(33, "Ancient Power"),
	MoveSet.new(41, "Iron_Defense"),
	MoveSet.new(49, "Shadow_Ball"),
	MoveSet.new(57, "Explosion"),
	MoveSet.new(65, "Power Gem"),
	MoveSet.new(73, "Stone Edge"),
	MoveSet.new(81, "Cosmic Power"),
	MoveSet.new(89, "Stored Power")
]
