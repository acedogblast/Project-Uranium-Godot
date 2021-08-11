extends Object

# The name of the pokemon
var name = "Baashaun"

# Pokedex ID#
var ID = 60

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 75
var defense = 50
var sp_attack = 35
var sp_defense = 40
var speed = 40

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 62

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 75

# The pokemon's evolution level
var evolution_level = 22

# The pokemon's evolution ID
var evolution_ID = 61

# The pokemon's catch rate
var catch_rate = 180

# Weight in kg
var weight = 10.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Low Kick"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(7, "Focus Energy"),
	MoveSet.new(13, "Stomp"),
	MoveSet.new(15, "Beat Up"),
	MoveSet.new(19, "Scary Face"),
	MoveSet.new(25, "Revenge"),
	MoveSet.new(31, "Feint Attack"),
	MoveSet.new(37, "Submission"),
	MoveSet.new(40, "Cross Chop"),
	MoveSet.new(43, "Foul Play"),
	MoveSet.new(49, "Hi Jump Kick")
]
 
