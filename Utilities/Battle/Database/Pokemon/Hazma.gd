extends Object

# The name of the pokemon
var name = "Hazma"

# Pokedex ID#
var ID = 171

# The pokemon's type. If only one type use type1
var type1 = Type.NUCLEAR
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 106
var attack = 54
var defense = 88
var sp_attack = 66
var sp_defense = 92
var speed = 44

# The pokemon's public and hidden abilities
var ability = "Lead Skin"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 147

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 25.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Defog"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(5, "Harden"),
	MoveSet.new(9, "Defog"),
	MoveSet.new(12, "Me First"),
	MoveSet.new(17, "Haze"),
	MoveSet.new(21, "Gamma Ray"),
	MoveSet.new(25, "Half-life"),
	MoveSet.new(29, "Light Screen"),
	MoveSet.new(33, "Reflect"),
	MoveSet.new(37, "Recover"),
	MoveSet.new(41, "Acid Armor"),
	MoveSet.new(50, "Expunge")
]
