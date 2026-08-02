extends Object

# The name of the pokemon
var name = "Devimp"

# Pokedex ID#
var ID = 187

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 65
var attack = 65
var defense = 55
var sp_attack = 30
var sp_defense = 45
var speed = 40

# The pokemon's public and hidden abilities
var ability = "Defiant"
var ability_2 = "Intimidate"
var hidden_ability = "Disenchant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 61

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 48

# The pokemon's evolution ID
var evolution_ID = 188

# The pokemon's catch rate
var catch_rate = 135

# Weight in kg
var weight = 28.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Inferno"),
	MoveSet.new(1, "Nasty Plot"),
	MoveSet.new(1, "Ember"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(8, "Bite"),
	MoveSet.new(14, "Flame Wheel"),
	MoveSet.new(20, "Nasty Plot"),
	MoveSet.new(25, "Beat Up"),
	MoveSet.new(31, "Fire Fang"),
	MoveSet.new(35, "Feint Attack"),
	MoveSet.new(42, "Torment"),
	MoveSet.new(46, "Foul Play"),
	MoveSet.new(50, "Shadow_Ball"),
	MoveSet.new(58, "Flamethrower"),
	MoveSet.new(60, "Inferno"),
	MoveSet.new(66, "Crunch"),
	MoveSet.new(72, "Flare Blitz"),
	MoveSet.new(76, "Infernal Blade")
]
