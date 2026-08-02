extends Object

# The name of the pokemon
var name = "Gliscor"

# Pokedex ID#
var ID = 76

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 95
var defense = 125
var sp_attack = 45
var sp_defense = 75
var speed = 95

# The pokemon's public and hidden abilities
var ability = "Hyper Cutter"
var ability_2 = "Sand Veil"
var hidden_ability = "Poison Heal"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 2
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 216

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 30

# Weight in kg
var weight = 42.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Thunder Fang"),
	MoveSet.new(1, "Ice Fang"),
	MoveSet.new(1, "Fire Fang"),
	MoveSet.new(1, "Poison Jab"),
	MoveSet.new(1, "Knock Off"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(4, "Sand Attack"),
	MoveSet.new(7, "Harden"),
	MoveSet.new(10, "Knock Off"),
	MoveSet.new(13, "Quick Attack"),
	MoveSet.new(16, "Fury Cutter"),
	MoveSet.new(19, "Feint Attack"),
	MoveSet.new(22, "Acrobatics"),
	MoveSet.new(27, "Night Slash"),
	MoveSet.new(30, "U-turn"),
	MoveSet.new(35, "Screech"),
	MoveSet.new(40, "X-Scissor"),
	MoveSet.new(45, "Sky Uppercut"),
	MoveSet.new(50, "Swords Dance"),
	MoveSet.new(55, "Guillotine")
]
