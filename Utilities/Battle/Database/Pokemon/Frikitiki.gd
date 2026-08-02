extends Object

# The name of the pokemon
var name = "Frikitiki"

# Pokedex ID#
var ID = 106

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.FIRE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 125
var defense = 70
var sp_attack = 90
var sp_defense = 65
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Vital Spirit"
var ability_2 = "Iron Fist"
var hidden_ability = "Technician"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 184

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
var catch_rate = 65

# Weight in kg
var weight = 55.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Flame Wheel"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(7, "Razor Leaf"),
	MoveSet.new(9, "Quick Attack"),
	MoveSet.new(13, "Grass Whistle"),
	MoveSet.new(18, "Bulk Up"),
	MoveSet.new(20, "Mega Drain"),
	MoveSet.new(22, "Flame Wheel"),
	MoveSet.new(25, "Magical Leaf"),
	MoveSet.new(29, "Glare"),
	MoveSet.new(33, "Fire Punch"),
	MoveSet.new(37, "Bullet Seed"),
	MoveSet.new(41, "Seed Bomb"),
	MoveSet.new(45, "Flame Charge"),
	MoveSet.new(45, "Blaze Kick"),
	MoveSet.new(48, "Flamethrower"),
	MoveSet.new(52, "Solar Beam"),
	MoveSet.new(53, "Lava Plume"),
	MoveSet.new(55, "Power Whip"),
	MoveSet.new(60, "Flare Blitz")
]
