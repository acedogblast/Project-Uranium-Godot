extends Object

# The name of the pokemon
var name = "Garlikid"

# Pokedex ID#
var ID = 191

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 115
var defense = 85
var sp_attack = 105
var sp_defense = 90
var speed = 115

# The pokemon's public and hidden abilities
var ability = "Justified"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 270

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
var catch_rate = 10

# Weight in kg
var weight = 33.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Absorb"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Stun Spore"),
	MoveSet.new(1, "Leech Seed"),
	MoveSet.new(4, "Tackle"),
	MoveSet.new(7, "Stun Spore"),
	MoveSet.new(10, "Low Kick"),
	MoveSet.new(16, "Mega Drain"),
	MoveSet.new(22, "Headbutt"),
	MoveSet.new(23, "Mach Punch"),
	MoveSet.new(28, "Counter"),
	MoveSet.new(36, "Sky Uppercut"),
	MoveSet.new(45, "Mind Reader"),
	MoveSet.new(54, "Dynamic Punch")
]
