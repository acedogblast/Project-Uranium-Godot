extends Object

# The name of the pokemon
var name = "Cubblfly"

# Pokedex ID#
var ID = 13

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 63
var defense = 90
var sp_attack = 50
var sp_defense = 80
var speed = 42

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 133

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 24

# The pokemon's evolution ID
var evolution_ID = 14

# The pokemon's catch rate
var catch_rate = 120

# Weight in kg
var weight = 4.8

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
	MoveSet.new(26, "Helping Hand"),
	MoveSet.new(29, "Confuse Ray"),
	MoveSet.new(31, "Acrobatics"),
	MoveSet.new(35, "X-Scissor"),
	MoveSet.new(39, "Moonlight"),
	MoveSet.new(43, "U-turn"),
	MoveSet.new(47, "Powder"),
	MoveSet.new(52, "Moonblast")
]
