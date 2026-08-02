extends Object

# The name of the pokemon
var name = "Floatzel"

# Pokedex ID#
var ID = 72

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 105
var defense = 55
var sp_attack = 85
var sp_defense = 50
var speed = 115

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var hidden_ability = "Water Veil"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 173

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
var weight = 33.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Ice Fang"),
	MoveSet.new(1, "Crunch"),
	MoveSet.new(1, "Sonic Boom"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Water Sport"),
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(4, "Growl"),
	MoveSet.new(7, "Water Sport"),
	MoveSet.new(11, "Quick Attack"),
	MoveSet.new(15, "Water Gun"),
	MoveSet.new(18, "Pursuit"),
	MoveSet.new(21, "Swift"),
	MoveSet.new(24, "Aqua_Jet"),
	MoveSet.new(29, "Double Hit"),
	MoveSet.new(35, "Whirlpool"),
	MoveSet.new(41, "Razor Wind"),
	MoveSet.new(46, "Aqua Tail"),
	MoveSet.new(51, "Agility"),
	MoveSet.new(57, "Hydro Pump")
]
