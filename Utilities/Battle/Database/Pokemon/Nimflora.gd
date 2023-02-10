extends Object

# The name of the pokemon
var name = "Nimflora"

# Pokedex ID#
var ID = 14

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 103
var defense = 80
var sp_attack = 70
var sp_defense = 70
var speed = 92

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 3
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 221

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 21.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Charm"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(1, "Bug Bite"),
	MoveSet.new(1, "Fairy Wind"),
	MoveSet.new(8, "Bug Bite"),
	MoveSet.new(15, "Stun Spore"),
	MoveSet.new(15, "Sleep Powder"),
	MoveSet.new(22, "Struggle Bug"),
	MoveSet.new(25, "Draining Kiss"),
	MoveSet.new(29, "Helping Hand"),
	MoveSet.new(32, "Confuse Ray"),
	MoveSet.new(34, "Acrobatics"),
	MoveSet.new(38, "X-Scissor"),
	MoveSet.new(42, "Moonlight"),
	MoveSet.new(46, "U-turn"),
	MoveSet.new(50, "Play Rough"),
	MoveSet.new(55, "Quiver Dance")
]
