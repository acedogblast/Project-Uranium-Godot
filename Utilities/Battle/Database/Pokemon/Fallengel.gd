extends Object

# The name of the pokemon
var name = "Fallengel"

# Pokedex ID#
var ID = 188

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 105
var defense = 75
var sp_attack = 35
var sp_defense = 55
var speed = 55

# The pokemon's public and hidden abilities
var ability = "Defiant"
var ability_2 = "Intimidate"
var hidden_ability = "Disenchant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 147

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 72

# The pokemon's evolution ID
var evolution_ID = 189

# The pokemon's catch rate
var catch_rate = 70

# Weight in kg
var weight = 58.6

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
	MoveSet.new(72, "Crunch"),
	MoveSet.new(76, "Flare Blitz"),
	MoveSet.new(81, "Infernal Blade")
]
