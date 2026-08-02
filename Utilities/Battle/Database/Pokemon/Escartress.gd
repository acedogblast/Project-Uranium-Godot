extends Object

# The name of the pokemon
var name = "Escartress"

# Pokedex ID#
var ID = 87

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.WATER

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 120
var attack = 60
var defense = 90
var sp_attack = 110
var sp_defense = 70
var speed = 65

# The pokemon's public and hidden abilities
var ability = "Shell Armor"
var ability_2 = "Sand Veil"
var hidden_ability = "Sand Stream"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 232

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
var catch_rate = 25

# Weight in kg
var weight = 229.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Mud-Slap"),
	MoveSet.new(2, "Mud Sport"),
	MoveSet.new(4, "Harden"),
	MoveSet.new(7, "Water Gun"),
	MoveSet.new(11, "Mud Bomb"),
	MoveSet.new(16, "Bubble Beam"),
	MoveSet.new(22, "Rain Dance"),
	MoveSet.new(29, "Magnitude"),
	MoveSet.new(37, "Muddy Water"),
	MoveSet.new(46, "Recover"),
	MoveSet.new(50, "Hydro Pump"),
	MoveSet.new(55, "Earthquake"),
	MoveSet.new(59, "Earth Power")
]
