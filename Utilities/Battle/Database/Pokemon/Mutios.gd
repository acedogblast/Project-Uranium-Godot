extends Object

# The name of the pokemon
var name = "Mutios"

# Pokedex ID#
var ID = 199

# The pokemon's type. If only one type use type1
var type1 = Type.GHOST
var type2 = Type.WATER

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 110
var attack = 100
var defense = 120
var sp_attack = 110
var sp_defense = 160
var speed = 100

# The pokemon's public and hidden abilities
var ability = "Pressure"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 2
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 360

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 2

# Weight in kg
var weight = 360.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Atomic Punch"),
	MoveSet.new(10, "Nuclear Waste"),
	MoveSet.new(30, "Half-life")
]
