extends Object

# The name of the pokemon
var name = "Chicoatl"

# Pokedex ID#
var ID = 109

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 65
var attack = 45
var defense = 50
var sp_attack = 70
var sp_defense = 50
var speed = 80

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
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 22

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 25

# The pokemon's evolution ID
var evolution_ID = 110

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 3.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(6, "Razor Leaf"),
	MoveSet.new(10, "Quick Attack"),
	MoveSet.new(13, "Grass Whistle"),
	MoveSet.new(16, "Leech Seed"),
	MoveSet.new(19, "Pursuit"),
	MoveSet.new(22, "Bullet Seed"),
	MoveSet.new(26, "Acrobatics"),
	MoveSet.new(31, "Feather_Dance"),
	MoveSet.new(36, "Giga Drain"),
	MoveSet.new(41, "Nasty Plot"),
	MoveSet.new(46, "Natural Gift"),
	MoveSet.new(51, "Energy Ball"),
	MoveSet.new(56, "Solar Beam")
]
