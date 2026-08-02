extends Object

# The name of the pokemon
var name = "Modrille"

# Pokedex ID#
var ID = 73

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 70
var defense = 60
var sp_attack = 40
var sp_defense = 45
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Lightning rod"
var ability_2 = "Sand Rush"
var hidden_ability = "Mold Breaker"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 63

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 34

# The pokemon's evolution ID
var evolution_ID = 74

# The pokemon's catch rate
var catch_rate = 120

# Weight in kg
var weight = 44.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Horn Attack"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(5, "Mud-Slap"),
	MoveSet.new(8, "Pursuit"),
	MoveSet.new(12, "Fury Attack"),
	MoveSet.new(15, "Metal Claw"),
	MoveSet.new(19, "Dig"),
	MoveSet.new(22, "Hone_Claws"),
	MoveSet.new(25, "Drill Peck"),
	MoveSet.new(27, "Rapid_Spin"),
	MoveSet.new(30, "Rock Slide"),
	MoveSet.new(33, "Earthquake"),
	MoveSet.new(36, "Swords Dance"),
	MoveSet.new(40, "Sandstorm"),
	MoveSet.new(43, "Drill Run"),
	MoveSet.new(47, "Horn Drill"),
	MoveSet.new(53, "Megahorn")
]
