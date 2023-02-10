extends Object

# The name of the pokemon
var name = "Arbok"

# Pokedex ID#
var ID = 45

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 85
var defense = 70
var sp_attack = 65
var sp_defense = 80
var speed = 80

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
var exp_yield : int = 154

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 90

# Weight in kg
var weight = 65.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Ice Fang"),
	MoveSet.new(1, "Thunder Fang"),
	MoveSet.new(1, "Fire Fang"),
	MoveSet.new(1, "Wrap"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Poison Sting"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(4, "Poison Sting"),
	MoveSet.new(9, "Bite"),
	MoveSet.new(12, "Glare"),
	MoveSet.new(17, "Screech"),
	MoveSet.new(20, "Acid"),
	MoveSet.new(27, "Stockpile"),
	MoveSet.new(27, "Swallow"),
	MoveSet.new(27, "Spit Up"),
	MoveSet.new(32, "Acid Spray"),
	MoveSet.new(39, "Mud Bomb"),
	MoveSet.new(44, "Gastro Acid"),
	MoveSet.new(51, "Haze"),
	MoveSet.new(56, "Coil"),
	MoveSet.new(63, "Gunk Shot")
]
