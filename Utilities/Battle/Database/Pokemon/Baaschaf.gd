extends Object

# The name of the pokemon
var name = "Baaschaf"

# Pokedex ID#
var ID = 61

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 90
var defense = 70
var sp_attack = 45
var sp_defense = 65
var speed = 55

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
var exp_yield : int = 144

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 75

# The pokemon's evolution level
var evolution_level = 44

# The pokemon's evolution ID
var evolution_ID = 62

# The pokemon's catch rate
var catch_rate = 90

# Weight in kg
var weight = 26.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Low Kick"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Focus Energy"),
	MoveSet.new(7, "Focus Energy"),
	MoveSet.new(13, "Stomp"),
	MoveSet.new(15, "Beat Up"),
	MoveSet.new(19, "Scary Face"),
	MoveSet.new(22, "Seismic Toss"),
	MoveSet.new(25, "Revenge"),
	MoveSet.new(33, "Feint Attack"),
	MoveSet.new(41, "Shadow Ball"),
	MoveSet.new(46, "Cross Chop"),
	MoveSet.new(51, "Foul Play"),
	MoveSet.new(59, "High Jump Kick")
]
 
