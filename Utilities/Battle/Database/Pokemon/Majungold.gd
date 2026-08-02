extends Object

# The name of the pokemon
var name = "Majungold"

# Pokedex ID#
var ID = 165

# The pokemon's type. If only one type use type1
var type1 = Type.FIGHTING
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 125
var attack = 135
var defense = 75
var sp_attack = 70
var sp_defense = 75
var speed = 60

# The pokemon's public and hidden abilities
var ability = "Battle Armor"
var ability_2 = "Clear Body"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 189

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 50

# Weight in kg
var weight = 156.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Defense Curl"),
	MoveSet.new(6, "Scary Face"),
	MoveSet.new(10, "Rock Throw"),
	MoveSet.new(12, "Bite"),
	MoveSet.new(15, "Bide"),
	MoveSet.new(17, "Brick Break"),
	MoveSet.new(20, "Iron_Defense"),
	MoveSet.new(26, "Rock Slide"),
	MoveSet.new(30, "Iron Head"),
	MoveSet.new(34, "Reversal"),
	MoveSet.new(37, "Crunch"),
	MoveSet.new(40, "Thrash"),
	MoveSet.new(44, "Golden Fist"),
	MoveSet.new(49, "Earthquake"),
	MoveSet.new(53, "Rock Wrecker"),
	MoveSet.new(58, "Skull Bash"),
	MoveSet.new(68, "Hammer Arm"),
	MoveSet.new(75, "Giga Impact")
]
