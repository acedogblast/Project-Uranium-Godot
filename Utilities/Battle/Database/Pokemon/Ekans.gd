extends Object

# The name of the pokemon
var name = "Ekans"

# Pokedex ID#
var ID = 44

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 35
var attack = 60
var defense = 45
var sp_attack = 40
var sp_defense = 55
var speed = 55

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
var exp_yield : int = 58

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 22

# The pokemon's evolution ID
var evolution_ID = 45

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 6.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Wrap"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(4, "Poison Sting"),
	MoveSet.new(9, "Bite"),
	MoveSet.new(12, "Glare"),
	MoveSet.new(17, "Screech"),
	MoveSet.new(20, "Acid"),
	MoveSet.new(25, "Stockpile"),
	MoveSet.new(25, "Swallow"),
	MoveSet.new(25, "Spit Up"),
	MoveSet.new(28, "Acid Spray"),
	MoveSet.new(33, "Mud Bomb"),
	MoveSet.new(36, "Gastro Acid"),
	MoveSet.new(41, "Haze"),
	MoveSet.new(44, "Coil"),
	MoveSet.new(49, "Gunk Shot")
]
