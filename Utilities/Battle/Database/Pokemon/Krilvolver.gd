extends Object

# The name of the pokemon
var name = "Krilvolver"

# Pokedex ID#
var ID = 158

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.FIRE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 73
var attack = 90
var defense = 85
var sp_attack = 120
var sp_defense = 45
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Sniper"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 3
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 174

# The pokemon's leveling rate
var leveling_rate = FLUCTUATING
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 32.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Bullet Punch"),
	MoveSet.new(1, "Scald"),
	MoveSet.new(1, "Bubble"),
	MoveSet.new(1, "Water Sport"),
	MoveSet.new(3, "Focus_Energy"),
	MoveSet.new(7, "Smoke Screen"),
	MoveSet.new(13, "Flame Burst"),
	MoveSet.new(19, "Lock-On"),
	MoveSet.new(24, "Octazooka"),
	MoveSet.new(30, "Lava Plume"),
	MoveSet.new(36, "Scald"),
	MoveSet.new(44, "Flamethrower"),
	MoveSet.new(52, "Flash Cannon"),
	MoveSet.new(57, "Hydro Pump")
]
