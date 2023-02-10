extends Object

# The name of the pokemon
var name = "Smore"

# Pokedex ID#
var ID = 40

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 30
var defense = 40
var sp_attack = 70
var sp_defense = 40
var speed = 45

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 53

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 16

# The pokemon's evolution ID
var evolution_ID = 41 # TODO Seikamater evo logic

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 1.2

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "String Shot"),
	MoveSet.new(6, "Leech Life"),
	MoveSet.new(11, "Ember"),
	MoveSet.new(16, "Incinerate"),
	MoveSet.new(17, "Night Shade"),
	MoveSet.new(23, "Scary Face"),
	MoveSet.new(30, "Bug Bite"),
	MoveSet.new(37, "Spider Web"),
	MoveSet.new(45, "Heat Wave"),
	MoveSet.new(53, "X-Scissor")
]
