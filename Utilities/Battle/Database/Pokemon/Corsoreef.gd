extends Object

# The name of the pokemon
var name = "Corsoreef"

# Pokedex ID#
var ID = 82

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 55
var defense = 105
var sp_attack = 60
var sp_defense = 105
var speed = 25

# The pokemon's public and hidden abilities
var ability = "Sharp Coral"
var ability_2 = "Natural Cure"
var hidden_ability = "Regenerator"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 198

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 25

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 60

# Weight in kg
var weight = 84.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(4, "Harden"),
	MoveSet.new(8, "Bubble"),
	MoveSet.new(13, "Recover"),
	MoveSet.new(16, "Refresh"),
	MoveSet.new(20, "Rock Blast"),
	MoveSet.new(25, "Bubble Beam"),
	MoveSet.new(28, "Lucky Chant"),
	MoveSet.new(32, "Ancient Power"),
	MoveSet.new(37, "Aqua Ring"),
	MoveSet.new(40, "Spike Cannon"),
	MoveSet.new(44, "Power Gem"),
	MoveSet.new(48, "Mirror Coat"),
	MoveSet.new(53, "Toxic"),
	MoveSet.new(57, "Earth Power")
]
