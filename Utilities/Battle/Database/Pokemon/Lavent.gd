extends Object

# The name of the pokemon
var name = "Lavent"

# Pokedex ID#
var ID = 159

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.DRAGON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 80
var defense = 70
var sp_attack = 105
var sp_defense = 70
var speed = 80

# The pokemon's public and hidden abilities
var ability = "Magma Armor"
var ability_2 = "Adaptability"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 179

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 120.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Ember"),
	MoveSet.new(1, "Withdraw"),
	MoveSet.new(8, "Wrap"),
	MoveSet.new(14, "Bite"),
	MoveSet.new(19, "Twister"),
	MoveSet.new(23, "Flame Burst"),
	MoveSet.new(28, "Dragon Rage"),
	MoveSet.new(34, "Scald"),
	MoveSet.new(38, "Lava Plume"),
	MoveSet.new(44, "Crunch"),
	MoveSet.new(48, "Dragon Rush"),
	MoveSet.new(55, "Overheat"),
	MoveSet.new(64, "Outrage"),
	MoveSet.new(69, "Magma Storm"),
	MoveSet.new(73, "Eruption")
]
