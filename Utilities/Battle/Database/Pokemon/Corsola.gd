extends Object

# The name of the pokemon
var name = "Corsola"

# Pokedex ID#
var ID = 81

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 55
var defense = 85
var sp_attack = 65
var sp_defense = 85
var speed = 35

# The pokemon's public and hidden abilities
var ability = "Hustle"
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
var exp_yield : int = 76

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
var weight = 5.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(4, "Bubble"),
	MoveSet.new(8, "Recover"),
	MoveSet.new(13, "Refresh"),
	MoveSet.new(17, "Ancient Power"),
	MoveSet.new(20, "Spike Cannon"),
	MoveSet.new(23, "Lucky Chant"),
	MoveSet.new(25, "Bubble Beam"),
	MoveSet.new(27, "Brine"),
	MoveSet.new(29, "Iron_Defense"),
	MoveSet.new(31, "Rock Blast"),
	MoveSet.new(35, "Endure"),
	MoveSet.new(38, "Aqua Ring"),
	MoveSet.new(41, "Power Gem"),
	MoveSet.new(45, "Mirror Coat"),
	MoveSet.new(47, "Earth Power"),
	MoveSet.new(50, "Flail")
]
