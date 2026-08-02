extends Object

# The name of the pokemon
var name = "Luchabra"

# Pokedex ID#
var ID = 146

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 110
var attack = 120
var defense = 85
var sp_attack = 60
var sp_defense = 85
var speed = 75

# The pokemon's public and hidden abilities
var ability = "Poison Point"
var ability_2 = "Poison Touch"
var hidden_ability = "Hustle"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 193

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
var catch_rate = 110

# Weight in kg
var weight = 98.7

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Low Sweep"),
	MoveSet.new(1, "Mat Block"),
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Scary Face"),
	MoveSet.new(6, "Poison_Sting"),
	MoveSet.new(11, "Screech"),
	MoveSet.new(17, "Pursuit"),
	MoveSet.new(21, "Feint"),
	MoveSet.new(24, "Poison_Fang"),
	MoveSet.new(29, "Knock Off"),
	MoveSet.new(33, "Bulk Up"),
	MoveSet.new(37, "Poison Jab"),
	MoveSet.new(38, "Seismic Toss"),
	MoveSet.new(41, "Toxic"),
	MoveSet.new(46, "Close Combat"),
	MoveSet.new(50, "Beat Up"),
	MoveSet.new(54, "Cross Poison"),
	MoveSet.new(59, "Dynamic Punch")
]
