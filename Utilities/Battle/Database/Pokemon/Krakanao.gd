extends Object

# The name of the pokemon
var name = "Krakanao"

# Pokedex ID#
var ID = 194

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 145
var defense = 90
var sp_attack = 70
var sp_defense = 120
var speed = 95

# The pokemon's public and hidden abilities
var ability = "Pressure"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 3
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 275

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
var catch_rate = 3

# Weight in kg
var weight = 88.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Feint"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Rage"),
	MoveSet.new(1, "Focus_Energy"),
	MoveSet.new(6, "Rage"),
	MoveSet.new(8, "Focus_Energy"),
	MoveSet.new(11, "Scary Face"),
	MoveSet.new(16, "Ice Fang"),
	MoveSet.new(18, "Screech"),
	MoveSet.new(21, "Swagger"),
	MoveSet.new(26, "Assurance"),
	MoveSet.new(28, "Crunch"),
	MoveSet.new(30, "Slash"),
	MoveSet.new(34, "Aqua_Jet"),
	MoveSet.new(40, "Taunt"),
	MoveSet.new(45, "Agility"),
	MoveSet.new(50, "Skull Bash"),
	MoveSet.new(56, "Night Slash")
]
