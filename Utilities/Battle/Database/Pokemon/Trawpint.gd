extends Object

# The name of the pokemon
var name = "Trawpint"

# Pokedex ID#
var ID = 66

# The pokemon's type. If only one type use type1
var type1 = Type.POISON
var type2 = Type.PSYCHIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 50
var defense = 85
var sp_attack = 85
var sp_defense = 95
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Shed Skin"
var ability_2 = "Infiltrator"
var hidden_ability = "Telepathy"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 172

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
var catch_rate = 90

# Weight in kg
var weight = 65.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Wrap"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(8, "Leech Life"),
	MoveSet.new(13, "Confusion"),
	MoveSet.new(16, "Acid"),
	MoveSet.new(20, "Mega Drain"),
	MoveSet.new(24, "Confuse Ray"),
	MoveSet.new(27, "Sludge"),
	MoveSet.new(34, "Stockpile"),
	MoveSet.new(37, "Spit Up"),
	MoveSet.new(37, "Swallow"),
	MoveSet.new(44, "Sludge Bomb"),
	MoveSet.new(45, "Toxic"),
	MoveSet.new(49, "Psychic")
]
