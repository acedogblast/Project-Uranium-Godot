extends Object

# The name of the pokemon
var name = "Cubbug"

# Pokedex ID#
var ID = 12

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 45
var attack = 53
var defense = 70
var sp_attack = 40
var sp_defense = 60
var speed = 42

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 62

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 10

# The pokemon's evolution ID
var evolution_ID = 13

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 0.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Charm"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(6, "Struggle Bug"),
	MoveSet.new(8, "Fairy Wind"),
	MoveSet.new(14, "Bug Bite"),
	MoveSet.new(22, "Helping Hand"),
	MoveSet.new(25, "Moonlight"),
	MoveSet.new(30, "Scary Face")
]
