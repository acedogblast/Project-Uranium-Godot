extends Object

# The name of the pokemon
var name = "Kinetmunk"

# Pokedex ID#
var ID = 8

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 65
var attack = 45
var defense = 70
var sp_attack = 75
var sp_defense = 70
var speed = 90

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 145

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
var catch_rate = 255

# Weight in kg
var weight = 20.1

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(6, "Charge"),
	MoveSet.new(13, "Thunder Shock"),
	MoveSet.new(18, "Quick Attack"),
	MoveSet.new(22, "Spark"),
	MoveSet.new(24, "Double Team"),
	MoveSet.new(28, "Bite"),
	MoveSet.new(34, "Hyper Fang"),
	MoveSet.new(40, "Discharge"),
	MoveSet.new(46, "Super Fang"),
	MoveSet.new(52, "Agility")
]
