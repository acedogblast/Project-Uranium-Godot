extends Object

# The name of the pokemon
var name = "Baariette"

# Pokedex ID#
var ID = 62

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 100
var attack = 125
var defense = 85
var sp_attack = 75
var sp_defense = 85
var speed = 75

# The pokemon's public and hidden abilities
var ability = "Guts"
var ability_2 = "Moxie"
var hidden_ability = "Intimidate"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 245

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 75

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 72.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Beat Up"),
	MoveSet.new(1, "Low Kick"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Focus Energy"),
	MoveSet.new(7, "Focus Energy"),
	MoveSet.new(19, "Seismic Toss"),
	MoveSet.new(22, "Taunt"),
	MoveSet.new(25, "Counter"),
	MoveSet.new(28, "Revenge"),
	MoveSet.new(33, "Vital Throw"),
	MoveSet.new(41, "Shadow Ball"),
	MoveSet.new(46, "Cross Chop"),
	MoveSet.new(51, "Foul Play"),
	MoveSet.new(59, "Dynamic Punch")
]
 
