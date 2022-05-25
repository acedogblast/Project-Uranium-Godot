extends Object

# The name of the pokemon
var name = "Electruxo"

# Pokedex ID#
var ID = 6

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 95
var attack = 80
var defense = 95
var sp_attack = 90
var sp_defense = 105
var speed = 85

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 3
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 248

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
var catch_rate = 45

# Weight in kg
var weight = 85.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail Whip"),
	MoveSet.new(1, "Water Gun"),
	MoveSet.new(1, "Withdraw"),
	MoveSet.new(4, "Tail Whip"),
	MoveSet.new(7, "Water Gun"),
	MoveSet.new(10, "Withdraw"),
	MoveSet.new(17, "Aqua jet"),
	MoveSet.new(19, "Stomp"),
	MoveSet.new(23, "Spark"),
	MoveSet.new(25, "Magnet Rise"),
	MoveSet.new(28, "Protect"),
	MoveSet.new(33, "Scald"),
	MoveSet.new(37, "Thunderbolt"),
	MoveSet.new(43, "Rain Dance"),
	MoveSet.new(47, "Thunder"),
	MoveSet.new(54, "Hydro Pump")
]
