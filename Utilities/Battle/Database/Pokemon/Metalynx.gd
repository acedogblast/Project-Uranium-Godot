extends Object

# The name of the pokemon
var name = "Metalynx"

# Pokedex ID#
var ID = 2

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 95
var defense = 115
var sp_attack = 70
var sp_defense = 100
var speed = 65

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 1
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 239

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 125.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Leech Seed"),
	MoveSet.new(1, "Vine Whip"),
	MoveSet.new(4, "Growl"),
	MoveSet.new(7, "Leech Seed"),
	MoveSet.new(13, "Metal Claw"),
	MoveSet.new(18, "Hone Claws"),
	MoveSet.new(20, "Razor Leaf"),
	MoveSet.new(25, "Iron Defense"),
	MoveSet.new(28, "Slash"),
	MoveSet.new(31, "Leaf Blade"),
	MoveSet.new(34, "Iron Tail"),
	MoveSet.new(38, "Night Slash"),
	MoveSet.new(41, "Swords Dance"),
	MoveSet.new(46, "Energy Ball"),
	MoveSet.new(51, "Meteor Mash")
]
