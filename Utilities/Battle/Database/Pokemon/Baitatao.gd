extends Object

# The name of the pokemon
var name = "Baitatao"

# Pokedex ID#
var ID = 192

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.FIRE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 70
var defense = 110
var sp_attack = 135
var sp_defense = 100
var speed = 105

# The pokemon's public and hidden abilities
var ability = "Pressure"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

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
var weight = 255.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Bite"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(8, "Ember"),
	MoveSet.new(15, "Roar"),
	MoveSet.new(22, "Fire Spin"),
	MoveSet.new(29, "Stomp"),
	MoveSet.new(36, "Flamethrower"),
	MoveSet.new(43, "Swagger"),
	MoveSet.new(50, "Fire Fang"),
	MoveSet.new(57, "Lava Plume"),
	MoveSet.new(64, "Extrasensory"),
	MoveSet.new(71, "Fire Blast"),
	MoveSet.new(78, "Calm Mind"),
	MoveSet.new(85, "Eruption")
]
