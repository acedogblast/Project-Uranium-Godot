extends Object

# The name of the pokemon
var name = "Barand"

# Pokedex ID#
var ID = 94

# The pokemon's type. If only one type use type1
var type1 = Type.DRAGON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 45
var attack = 115
var defense = 45
var sp_attack = 40
var sp_defense = 30
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Rivalry"
var ability_2 = "Shed Skin"
var hidden_ability = "Tough Claws"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 126

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
var catch_rate = 45

# Weight in kg
var weight = 90.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(6, "Sand Attack"),
	MoveSet.new(11, "Leer"),
	MoveSet.new(16, "Bite"),
	MoveSet.new(21, "Dragon_Claw"),
	MoveSet.new(26, "Force Palm"),
	MoveSet.new(31, "Dragon Dance"),
	MoveSet.new(36, "Slash"),
	MoveSet.new(41, "Crush Claw"),
	MoveSet.new(46, "Dragon Rush"),
	MoveSet.new(51, "Take Down")
]
