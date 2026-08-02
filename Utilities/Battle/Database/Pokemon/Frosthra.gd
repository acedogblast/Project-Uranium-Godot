extends Object

# The name of the pokemon
var name = "Frosthra"

# Pokedex ID#
var ID = 154

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 55
var defense = 60
var sp_attack = 140
var sp_defense = 95
var speed = 115

# The pokemon's public and hidden abilities
var ability = "Deep Freeze"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 248

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 15

# Weight in kg
var weight = 46.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Frost Breath"),
	MoveSet.new(1, "Silver Wind"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "String_Shot"),
	MoveSet.new(5, "Tackle"),
	MoveSet.new(9, "Harden"),
	MoveSet.new(14, "Astonish"),
	MoveSet.new(19, "Bug Bite"),
	MoveSet.new(24, "Mirror Coat"),
	MoveSet.new(29, "Ice Ball"),
	MoveSet.new(35, "Hail"),
	MoveSet.new(42, "Aurora Beam"),
	MoveSet.new(48, "Haze"),
	MoveSet.new(53, "Freeze-Dry"),
	MoveSet.new(57, "Quiver Dance"),
	MoveSet.new(61, "Signal Beam"),
	MoveSet.new(65, "Defog"),
	MoveSet.new(69, "Blizzard"),
	MoveSet.new(73, "Bug Buzz"),
	MoveSet.new(80, "Hurricane")
]
