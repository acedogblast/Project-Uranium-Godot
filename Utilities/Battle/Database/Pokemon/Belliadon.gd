extends Object

# The name of the pokemon
var name = "Belliadon"

# Pokedex ID#
var ID = 189

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 115
var attack = 145
var defense = 100
var sp_attack = 80
var sp_defense = 90
var speed = 70

# The pokemon's public and hidden abilities
var ability = "Defiant"
var ability_2 = "Intimidate"
var hidden_ability = "Disenchant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 3
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 270

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
var catch_rate = 3

# Weight in kg
var weight = 178.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Inferno"),
	MoveSet.new(1, "Nasty Plot"),
	MoveSet.new(1, "Ember"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(14, "Bite"),
	MoveSet.new(20, "Flame Wheel"),
	MoveSet.new(26, "Nasty Plot"),
	MoveSet.new(30, "Beat Up"),
	MoveSet.new(36, "Fire Fang"),
	MoveSet.new(42, "Feint Attack"),
	MoveSet.new(46, "Torment"),
	MoveSet.new(50, "Foul Play"),
	MoveSet.new(56, "Shadow_Ball"),
	MoveSet.new(64, "Flamethrower"),
	MoveSet.new(69, "Inferno"),
	MoveSet.new(78, "Crunch"),
	MoveSet.new(82, "Flare Blitz"),
	MoveSet.new(87, "Infernal Blade")
]
