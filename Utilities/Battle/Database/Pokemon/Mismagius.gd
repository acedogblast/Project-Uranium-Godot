extends Object

# The name of the pokemon
var name = "Mismagius"

# Pokedex ID#
var ID = 93

# The pokemon's type. If only one type use type1
var type1 = Type.GHOST
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 60
var defense = 60
var sp_attack = 105
var sp_defense = 105
var speed = 105

# The pokemon's public and hidden abilities
var ability = "Levitate"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 173

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 4.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Psywave"),
	MoveSet.new(1, "Mystical Fire"),
	MoveSet.new(1, "Power Gem"),
	MoveSet.new(1, "Phantom Force"),
	MoveSet.new(1, "Lucky Chant"),
	MoveSet.new(1, "Magical Leaf"),
	MoveSet.new(1, "Spite"),
	MoveSet.new(1, "Astonish")
]
