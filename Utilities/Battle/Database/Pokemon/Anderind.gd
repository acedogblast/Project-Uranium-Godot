extends Object

# The name of the pokemon
var name = "Anderind"

# Pokedex ID#
var ID = 151

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.GROUND

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 127
var defense = 100
var sp_attack = 60
var sp_defense = 75
var speed = 78

# The pokemon's public and hidden abilities
var ability = "Snow Warning"
var ability_2 = "Rivalry"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 186

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
var weight = 55.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Bulldoze"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Mud-Slap"),
	MoveSet.new(9, "Charm"),
	MoveSet.new(13, "Icy Wind"),
	MoveSet.new(17, "Take Down"),
	MoveSet.new(21, "Wideguard"),
	MoveSet.new(25, "Magnitude"),
	MoveSet.new(29, "Counter"),
	MoveSet.new(33, "Chip Away"),
	MoveSet.new(36, "Icicle Crash"),
	MoveSet.new(41, "Agility"),
	MoveSet.new(45, "Thrash"),
	MoveSet.new(49, "Earthquake"),
	MoveSet.new(54, "Play Rough"),
	MoveSet.new(59, "Avalanche"),
	MoveSet.new(63, "Fissure")
]
