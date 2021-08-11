extends Object

# The name of the pokemon
var name = "Flaaffy"

# Pokedex ID#
var ID = 58

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 55
var defense = 55
var sp_attack = 80
var sp_defense = 60
var speed = 45

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 128

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 30

# The pokemon's evolution ID
var evolution_ID = 59

# The pokemon's catch rate
var catch_rate = 120

# Weight in kg
var weight = 13.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Thunder Wave"),
	MoveSet.new(1, "Thunder Shock"),
	MoveSet.new(4, "Thunder Wave"),
	MoveSet.new(8, "Thunder Shock"),
	MoveSet.new(11, "Cotton Spore"),
	MoveSet.new(15, "Charge"),
	MoveSet.new(18, "Take Down"),
	MoveSet.new(22, "Electro Ball"),
	MoveSet.new(25, "Confuse Ray"),
	MoveSet.new(29, "Power Gem"),
	MoveSet.new(32, "Discharge"),
	MoveSet.new(36, "Cotton Guard"),
	MoveSet.new(39, "Signal Beam"),
	MoveSet.new(43, "Light Screen"),
	MoveSet.new(46, "Thunder")
]
