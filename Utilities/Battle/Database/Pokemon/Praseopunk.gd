extends Object

# The name of the pokemon
var name = "Praseopunk"

# Pokedex ID#
var ID = 179

# The pokemon's type. If only one type use type1
var type1 = Type.PSYCHIC
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 80
var defense = 85
var sp_attack = 100
var sp_defense = 70
var speed = 80

# The pokemon's public and hidden abilities
var ability = "Plus"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 175

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 90

# Weight in kg
var weight = 43.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Charge"),
	MoveSet.new(1, "Spark"),
	MoveSet.new(1, "Thunder Punch"),
	MoveSet.new(1, "Psywave"),
	MoveSet.new(1, "Confusion"),
	MoveSet.new(1, "Detect"),
	MoveSet.new(1, "Teleport"),
	MoveSet.new(4, "Confusion"),
	MoveSet.new(9, "Thunder Wave"),
	MoveSet.new(12, "Shock Wave"),
	MoveSet.new(20, "Charge Beam"),
	MoveSet.new(23, "Psywave"),
	MoveSet.new(28, "Cosmic Power"),
	MoveSet.new(31, "Get Lucky"),
	MoveSet.new(37, "Discharge"),
	MoveSet.new(44, "Psychic"),
	MoveSet.new(49, "Volt Switch"),
	MoveSet.new(55, "Instant Crush"),
	MoveSet.new(62, "Psycho Cut")
]
