extends Object

# The name of the pokemon
var name = "Actan"

# Pokedex ID#
var ID = 196

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 96
var attack = 144
var defense = 96
var sp_attack = 73
var sp_defense = 94
var speed = 97

# The pokemon's public and hidden abilities
var ability = "Intimidate"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 3
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 270

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 3

# Weight in kg
var weight = 1270.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Ancient Power"),
	MoveSet.new(9, "Leer"),
	MoveSet.new(17, "Feint Attack"),
	MoveSet.new(25, "Metal Sound"),
	MoveSet.new(33, "Crunch"),
	MoveSet.new(41, "Scary Face"),
	MoveSet.new(49, "Shadow_Ball"),
	MoveSet.new(57, "Flash Cannon"),
	MoveSet.new(65, "Iron Head"),
	MoveSet.new(73, "Earthquake"),
	MoveSet.new(80, "Metal Cruncher"),
	MoveSet.new(86, "Stone Edge"),
	MoveSet.new(90, "Sudden Strike")
]
