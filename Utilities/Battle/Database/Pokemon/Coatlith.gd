extends Object

# The name of the pokemon
var name = "Coatlith"

# Pokedex ID#
var ID = 111

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.DRAGON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 110
var attack = 50
var defense = 70
var sp_attack = 100
var sp_defense = 70
var speed = 100

# The pokemon's public and hidden abilities
var ability = "Levitate"
var hidden_ability = "Chlorophyll"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 225

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 148.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Dragon Rage"),
	MoveSet.new(1, "Twister"),
	MoveSet.new(1, "Peck"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(1, "Razor Leaf"),
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(6, "Razor Leaf"),
	MoveSet.new(10, "Quick Attack"),
	MoveSet.new(13, "Grass Whistle"),
	MoveSet.new(16, "Leech Seed"),
	MoveSet.new(19, "Pursuit"),
	MoveSet.new(22, "Bullet Seed"),
	MoveSet.new(28, "Acrobatics"),
	MoveSet.new(34, "Feather_Dance"),
	MoveSet.new(39, "Giga Drain"),
	MoveSet.new(41, "Dragon_Claw"),
	MoveSet.new(48, "Nasty Plot"),
	MoveSet.new(54, "Dragon_Pulse"),
	MoveSet.new(60, "Energy Ball"),
	MoveSet.new(66, "Solar Beam")
]
