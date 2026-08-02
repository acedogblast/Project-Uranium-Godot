extends Object

# The name of the pokemon
var name = "Tubjaw"

# Pokedex ID#
var ID = 83

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 70
var defense = 90
var sp_attack = 45
var sp_defense = 65
var speed = 65

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var ability_2 = "Strong Jaw"
var hidden_ability = "Intimidate"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 81

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 34

# The pokemon's evolution ID
var evolution_ID = 84

# The pokemon's catch rate
var catch_rate = 125

# Weight in kg
var weight = 55.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(6, "Water Gun"),
	MoveSet.new(10, "Bite"),
	MoveSet.new(14, "Scary Face"),
	MoveSet.new(18, "Aqua_Jet"),
	MoveSet.new(22, "Ice Fang"),
	MoveSet.new(26, "Swagger"),
	MoveSet.new(31, "Assurance"),
	MoveSet.new(35, "Aqua Tail"),
	MoveSet.new(39, "Crunch"),
	MoveSet.new(43, "Thrash"),
	MoveSet.new(47, "Torment")
]
