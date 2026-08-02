extends Object

# The name of the pokemon
var name = "Titanice"

# Pokedex ID#
var ID = 117

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 90
var defense = 75
var sp_attack = 65
var sp_defense = 55
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Forewarn"
var ability_2 = "Ice Body"
var hidden_ability = "Snow Warning"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 209

# The pokemon's leveling rate
var leveling_rate = SLOW
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
var weight = 1050.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Aqua Ring"),
	MoveSet.new(1, "Iron Head"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Bide"),
	MoveSet.new(1, "Icy Wind"),
	MoveSet.new(5, "Growl"),
	MoveSet.new(9, "Bide"),
	MoveSet.new(13, "Icy Wind"),
	MoveSet.new(17, "Mist"),
	MoveSet.new(21, "Brine"),
	MoveSet.new(25, "Endure"),
	MoveSet.new(29, "Swagger"),
	MoveSet.new(33, "Take Down"),
	MoveSet.new(36, "Avalanche"),
	MoveSet.new(37, "Icicle Crash"),
	MoveSet.new(41, "Rest"),
	MoveSet.new(45, "Blizzard"),
	MoveSet.new(53, "Hail"),
	MoveSet.new(59, "Giga Impact"),
	MoveSet.new(66, "Sheer Cold")
]
