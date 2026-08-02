extends Object

# The name of the pokemon
var name = "Tracton"

# Pokedex ID#
var ID = 112

# The pokemon's type. If only one type use type1
var type1 = Type.DRAGON
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 110
var defense = 70
var sp_attack = 50
var sp_defense = 80
var speed = 100

# The pokemon's public and hidden abilities
var ability = "Speed Boost"
var ability_2 = "Motor Drive"
var hidden_ability = "Analytic"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 2
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 173

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
var catch_rate = 90

# Weight in kg
var weight = 120.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Vice Grip"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(8, "Mud-Slap"),
	MoveSet.new(13, "Iron_Defense"),
	MoveSet.new(18, "Dragon_Claw"),
	MoveSet.new(23, "Metal Sound"),
	MoveSet.new(28, "Slam"),
	MoveSet.new(33, "Shift Gear"),
	MoveSet.new(38, "Iron Head"),
	MoveSet.new(43, "Lock-On"),
	MoveSet.new(48, "Discharge"),
	MoveSet.new(53, "Dragon Rush")
]
