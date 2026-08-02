extends Object

# The name of the pokemon
var name = "Herolune"

# Pokedex ID#
var ID = 68

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 95
var attack = 124
var defense = 83
var sp_attack = 63
var sp_defense = 68
var speed = 60

# The pokemon's public and hidden abilities
var ability = "Mold Breaker"
var ability_2 = "Guts"
var hidden_ability = "Defiant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

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
var catch_rate = 128

# Weight in kg
var weight = 88.2

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Entrainment"),
	MoveSet.new(1, "Hammer Arm"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(15, "Drain Punch"),
	MoveSet.new(25, "Bone Rush"),
	MoveSet.new(40, "Moonlight")
]
