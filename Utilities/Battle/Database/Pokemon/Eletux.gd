extends Object

# The name of the pokemon
var name = "Eletux"

# Pokedex ID#
var ID = 5

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 50
var defense = 65
var sp_attack = 50
var sp_defense = 65
var speed = 45

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 67

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 27

# The pokemon's evolution ID
var evolution_ID = 6

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 18.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(3, "Tail Whip"),
	MoveSet.new(5, "Water Gun"),
	MoveSet.new(10, "Defense Curl"),
	MoveSet.new(13, "Thunder Shock"),
	MoveSet.new(17, "Aqua Jet"),
	MoveSet.new(21, "Stomp"),
	MoveSet.new(23, "Spark"),
	MoveSet.new(25, "Magnet Rise"),
	MoveSet.new(28, "Protect"),
	MoveSet.new(32, "Scald"),
	MoveSet.new(36, "Thunderbolt"),
	MoveSet.new(40, "Rain Dance"),
	MoveSet.new(44, "Thunder"),
	MoveSet.new(50, "Hydro Pump")
]
