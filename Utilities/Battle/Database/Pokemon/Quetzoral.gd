extends Object

# The name of the pokemon
var name = "Quetzoral"

# Pokedex ID#
var ID = 110

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 45
var defense = 65
var sp_attack = 85
var sp_defense = 65
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Sap Sipper"
var ability_2 = "Leaf Guard"
var hidden_ability = "Chlorophyll"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 151

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 41

# The pokemon's evolution ID
var evolution_ID = 111

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 14.3

# Moveset by leveling
var moveset = [
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
	MoveSet.new(45, "Nasty Plot"),
	MoveSet.new(50, "Natural Gift"),
	MoveSet.new(56, "Energy Ball"),
	MoveSet.new(58, "Defog"),
	MoveSet.new(61, "Solar Beam")
]
