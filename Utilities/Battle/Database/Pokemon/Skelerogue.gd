extends Object

# The name of the pokemon
var name = "Skelerogue"

# Pokedex ID#
var ID = 161

# The pokemon's type. If only one type use type1
var type1 = Type.GHOST
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 105
var defense = 65
var sp_attack = 60
var sp_defense = 65
var speed = 70

# The pokemon's public and hidden abilities
var ability = "Scrappy"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 120

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 55

# The pokemon's evolution ID
var evolution_ID = 162

# The pokemon's catch rate
var catch_rate = 75

# Weight in kg
var weight = 60.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Astonish"),
	MoveSet.new(1, "Thief"),
	MoveSet.new(7, "Astonish"),
	MoveSet.new(9, "Thief"),
	MoveSet.new(13, "Curse"),
	MoveSet.new(18, "Arm Thrust"),
	MoveSet.new(20, "Destiny Bond"),
	MoveSet.new(25, "Mach Punch"),
	MoveSet.new(29, "Embargo"),
	MoveSet.new(33, "Brine"),
	MoveSet.new(37, "Reversal"),
	MoveSet.new(41, "Shadow Claw"),
	MoveSet.new(45, "Shadow_Ball"),
	MoveSet.new(48, "Hammer Arm"),
	MoveSet.new(52, "Superpower")
]
