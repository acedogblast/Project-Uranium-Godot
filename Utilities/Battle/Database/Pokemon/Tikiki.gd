extends Object

# The name of the pokemon
var name = "Tikiki"

# Pokedex ID#
var ID = 105

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 75
var defense = 55
var sp_attack = 50
var sp_defense = 50
var speed = 70

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
var exp_yield : int = 62

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 32

# The pokemon's evolution ID
var evolution_ID = 106

# The pokemon's catch rate
var catch_rate = 205

# Weight in kg
var weight = 26.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(7, "Razor Leaf"),
	MoveSet.new(9, "Quick Attack"),
	MoveSet.new(13, "Grass Whistle"),
	MoveSet.new(18, "Bulk Up"),
	MoveSet.new(20, "Mega Drain"),
	MoveSet.new(25, "Magical Leaf"),
	MoveSet.new(29, "Glare"),
	MoveSet.new(33, "Iron Tail"),
	MoveSet.new(37, "Bullet Seed"),
	MoveSet.new(41, "Seed Bomb"),
	MoveSet.new(45, "Energy Ball"),
	MoveSet.new(52, "Solar Beam"),
	MoveSet.new(55, "Power Whip")
]
