extends Object

# The name of the pokemon
var name = "Volchik"

# Pokedex ID#
var ID = 184

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 40
var defense = 50
var sp_attack = 65
var sp_defense = 40
var speed = 55

# The pokemon's public and hidden abilities
var ability = "Volt Absorb"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 61

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 42

# The pokemon's evolution ID
var evolution_ID = 185

# The pokemon's catch rate
var catch_rate = 135

# Weight in kg
var weight = 9.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(5, "Leer"),
	MoveSet.new(9, "Charge"),
	MoveSet.new(13, "Thunder_Shock"),
	MoveSet.new(17, "Spark"),
	MoveSet.new(21, "Roar"),
	MoveSet.new(25, "Wing Attack"),
	MoveSet.new(29, "Dragon Rage"),
	MoveSet.new(33, "Spark"),
	MoveSet.new(37, "Shock Wave"),
	MoveSet.new(41, "Air_Cutter"),
	MoveSet.new(48, "Feather_Dance"),
	MoveSet.new(51, "Roost"),
	MoveSet.new(54, "Discharge"),
	MoveSet.new(55, "Dragon Dance"),
	MoveSet.new(58, "Nasty Plot"),
	MoveSet.new(61, "Brave Bird"),
	MoveSet.new(63, "Thunder"),
	MoveSet.new(68, "Hurricane"),
	MoveSet.new(71, "Thunderstorm")
]
