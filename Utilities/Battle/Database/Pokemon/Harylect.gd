extends Object

# The name of the pokemon
var name = "Harylect"

# Pokedex ID#
var ID = 64

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 100
var defense = 55
var sp_attack = 50
var sp_defense = 60
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Volt Absorb"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 147

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
var catch_rate = 90

# Weight in kg
var weight = 2.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Thunder Shock"),
	MoveSet.new(6, "Leech Life"),
	MoveSet.new(11, "Thunder Shock"),
	MoveSet.new(17, "Thunder Wave"),
	MoveSet.new(20, "Wild Charge"),
	MoveSet.new(27, "Thunder Fang"),
	MoveSet.new(30, "Shock Wave"),
	MoveSet.new(37, "Tail Glow"),
	MoveSet.new(41, "Spark"),
	MoveSet.new(45, "Discharge"),
	MoveSet.new(53, "Signal Beam")
]
