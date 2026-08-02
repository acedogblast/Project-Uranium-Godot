extends Object

# The name of the pokemon
var name = "Hagoop"

# Pokedex ID#
var ID = 166

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 45
var defense = 45
var sp_attack = 85
var sp_defense = 105
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Gooey"
var ability_2 = "Liquid Ooze"
var hidden_ability = "Regenerator"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 2
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 192

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 45

# The pokemon's evolution ID
var evolution_ID = 167

# The pokemon's catch rate
var catch_rate = 50

# Weight in kg
var weight = 39.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Mud Sport"),
	MoveSet.new(1, "Astonish"),
	MoveSet.new(1, "Mud Shot"),
	MoveSet.new(7, "Parabolic Charge"),
	MoveSet.new(10, "Mud-Slap"),
	MoveSet.new(14, "Sludge"),
	MoveSet.new(22, "Camouflage"),
	MoveSet.new(26, "Body_Slam"),
	MoveSet.new(30, "Sludge"),
	MoveSet.new(37, "Sticky Terrain"),
	MoveSet.new(41, "Recover"),
	MoveSet.new(44, "Thunderbolt"),
	MoveSet.new(48, "Sludge Wave"),
	MoveSet.new(50, "Sucker Punch"),
	MoveSet.new(56, "Thunder")
]
