extends Object

# The name of the pokemon
var name = "Terrabit"

# Pokedex ID#
var ID = 182

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 76
var attack = 84
var defense = 70
var sp_attack = 60
var sp_defense = 66
var speed = 64

# The pokemon's public and hidden abilities
var ability = "Intimidate"
var ability_2 = "Moxie"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 147

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 66

# The pokemon's evolution ID
var evolution_ID = 183

# The pokemon's catch rate
var catch_rate = 90

# Weight in kg
var weight = 33.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Rage"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(4, "Bite"),
	MoveSet.new(7, "Sand Attack"),
	MoveSet.new(10, "Magnitude"),
	MoveSet.new(13, "Horn Attack"),
	MoveSet.new(16, "Mud Bomb"),
	MoveSet.new(19, "Spikes"),
	MoveSet.new(22, "Rock Tomb"),
	MoveSet.new(25, "Hone_Claws"),
	MoveSet.new(31, "Bulldoze"),
	MoveSet.new(42, "Dragon Tail"),
	MoveSet.new(48, "Sandstorm"),
	MoveSet.new(54, "Earthquake"),
	MoveSet.new(60, "Outrage"),
	MoveSet.new(70, "Megahorn"),
	MoveSet.new(74, "Subduction")
]
