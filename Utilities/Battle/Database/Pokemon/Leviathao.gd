extends Object

# The name of the pokemon
var name = "Leviathao"

# Pokedex ID#
var ID = 193

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 125
var attack = 100
var defense = 115
var sp_attack = 85
var sp_defense = 100
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Pressure"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 1
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
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
var weight = 150.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Crunch"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Water Gun"),
	MoveSet.new(1, "Encore"),
	MoveSet.new(7, "Encore"),
	MoveSet.new(13, "Ice Ball"),
	MoveSet.new(19, "Body_Slam"),
	MoveSet.new(25, "Aurora Beam"),
	MoveSet.new(31, "Hail"),
	MoveSet.new(32, "Swagger"),
	MoveSet.new(39, "Rest"),
	MoveSet.new(39, "Snore"),
	MoveSet.new(44, "Ice Fang"),
	MoveSet.new(52, "Blizzard"),
	MoveSet.new(65, "Sheer Cold")
]
