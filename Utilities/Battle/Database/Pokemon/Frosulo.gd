extends Object

# The name of the pokemon
var name = "Frosulo"

# Pokedex ID#
var ID = 153

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 45
var defense = 85
var sp_attack = 90
var sp_defense = 35
var speed = 67

# The pokemon's public and hidden abilities
var ability = "Ice Body"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 133

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 53

# The pokemon's evolution ID
var evolution_ID = 154

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 28.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "String_Shot"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(1, "Reflect"),
	MoveSet.new(1, "Light Screen"),
	MoveSet.new(9, "Harden"),
	MoveSet.new(14, "Astonish"),
	MoveSet.new(19, "Bug Bite"),
	MoveSet.new(24, "Take Down"),
	MoveSet.new(29, "Ice Ball"),
	MoveSet.new(35, "Hail"),
	MoveSet.new(41, "Light Screen"),
	MoveSet.new(41, "Reflect"),
	MoveSet.new(44, "Acid Armor"),
	MoveSet.new(49, "Haze"),
	MoveSet.new(54, "Mirror Coat")
]
