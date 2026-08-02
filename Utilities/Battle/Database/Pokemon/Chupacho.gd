extends Object

# The name of the pokemon
var name = "Chupacho"

# Pokedex ID#
var ID = 145

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 68
var attack = 77
var defense = 55
var sp_attack = 30
var sp_defense = 35
var speed = 75

# The pokemon's public and hidden abilities
var ability = "Poison Point"
var ability_2 = "Poison Touch"
var hidden_ability = "Hustle"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 78

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 38

# The pokemon's evolution ID
var evolution_ID = 146

# The pokemon's catch rate
var catch_rate = 175

# Weight in kg
var weight = 25.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Scary Face"),
	MoveSet.new(6, "Poison_Sting"),
	MoveSet.new(11, "Screech"),
	MoveSet.new(17, "Pursuit"),
	MoveSet.new(21, "Feint"),
	MoveSet.new(24, "Poison_Fang"),
	MoveSet.new(29, "Knock Off"),
	MoveSet.new(33, "Agility"),
	MoveSet.new(37, "Poison Jab"),
	MoveSet.new(41, "Toxic"),
	MoveSet.new(46, "Twineedle"),
	MoveSet.new(50, "Toxic Spikes"),
	MoveSet.new(54, "Cross Poison")
]
