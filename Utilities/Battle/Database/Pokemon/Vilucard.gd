extends Object

# The name of the pokemon
var name = "Vilucard"

# Pokedex ID#
var ID = 70

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 108
var defense = 60
var sp_attack = 102
var sp_defense = 58
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Blood Lust"
var hidden_ability = "Poison Touch"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 172

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
var weight = 64.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Astonish"),
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Poison_Sting"),
	MoveSet.new(1, "Drain Life"),
	MoveSet.new(25, "Drain Life"),
	MoveSet.new(40, "Giga Drain")
]
