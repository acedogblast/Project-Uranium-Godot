extends Object

# The name of the pokemon
var name = "Ampharos"

# Pokedex ID#
var ID = 59

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 75
var defense = 85
var sp_attack = 115
var sp_defense = 90
var speed = 50

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 3
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 227

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 65.1

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Thunder Wave"),
	MoveSet.new(1, "Thunder Shock"),
	MoveSet.new(4, "Thunder Wave"),
	MoveSet.new(8, "Thunder Shock"),
	MoveSet.new(11, "Cotton Spore"),
	MoveSet.new(16, "Charge"),
	MoveSet.new(20, "Take Down"),
	MoveSet.new(25, "Electro Ball"),
	MoveSet.new(29, "Confuse Ray"),
	MoveSet.new(30, "Thunder Punch"),
	MoveSet.new(35, "Power Gem"),
	MoveSet.new(40, "Discharge"),
	MoveSet.new(46, "Cotton Guard"),
	MoveSet.new(51, "Signal Beam"),
	MoveSet.new(57, "Light Screen"),
	MoveSet.new(62, "Thunder"),
	MoveSet.new(66, "Dragon Pulse")
]
