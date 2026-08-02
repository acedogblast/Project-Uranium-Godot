extends Object

# The name of the pokemon
var name = "Gengar"

# Pokedex ID#
var ID = 203

# The pokemon's type. If only one type use type1
var type1 = Type.GHOST
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 65
var defense = 60
var sp_attack = 130
var sp_defense = 75
var speed = 110

# The pokemon's public and hidden abilities
var ability = "Levitate"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 3
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 225

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50.0

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 40.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Lick"),
	MoveSet.new(1, "Hypnosis"),
	MoveSet.new(12, "Night Shade"),
	MoveSet.new(19, "Curse"),
	MoveSet.new(28, "Shadow Punch"),
	MoveSet.new(39, "Shadow Ball"),
	MoveSet.new(48, "Dream Eater")
]
