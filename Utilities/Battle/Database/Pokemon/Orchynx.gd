extends Object

# The name of the pokemon
var name = "Orchynx"

# Pokedex ID#
var ID = 1

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 55
var defense = 55
var sp_attack = 70
var sp_defense = 70
var speed = 50

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 70

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 28

# The pokemon's evolution ID
var evolution_ID = 2

# The pokemon's catch rate
var catch_rate = 42

# Weight in kg
var weight = 15.2

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Leech Seed"),
	MoveSet.new(9, "Vine Whip"),
	MoveSet.new(13, "Metal Claw"),
	MoveSet.new(18, "Hone Claws"),
	MoveSet.new(20, "Mega Drain"),
	MoveSet.new(25, "Iron Defense"),
	MoveSet.new(29, "Leaf Blade"),
	MoveSet.new(33, "Iron Tail"),
	MoveSet.new(37, "Synthesis"),
	MoveSet.new(41, "Energy Ball"),
	MoveSet.new(45, "Meteor Mash")
]
