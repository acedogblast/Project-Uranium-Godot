extends Object

# The name of the pokemon
var name = "Astronite"

# Pokedex ID#
var ID = 56

# The pokemon's type. If only one type use type1
var type1 = Type.ROCK
var type2 = Type.PSYCHIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 85
var defense = 85
var sp_attack = 115
var sp_defense = 75
var speed = 105

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 245

# The pokemon's leveling rate
var leveling_rate = ERRATIC
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 242.7

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Harden"),
	MoveSet.new(7, "Rock Throw"),
	MoveSet.new(13, "Confusion"),
	MoveSet.new(19, "Wideguard"),
	MoveSet.new(25, "Psybeam"),
	MoveSet.new(28, "Gravity"),
	MoveSet.new(28, "Magnet Rise"),
	MoveSet.new(33, "Ancient Power"),
	MoveSet.new(37, "Psycho Shift"),
	MoveSet.new(39, "Extrasensory"),
	MoveSet.new(42, "Power Gem"),
	MoveSet.new(45, "Cosmic Power"),
	MoveSet.new(48, "Psyshock"),
	MoveSet.new(50, "Recover"),
	MoveSet.new(53, "Stone Edge"),
	MoveSet.new(56, "Moonblast"),
	MoveSet.new(60, "Synchronoise")
]
 
