extends Object

# The name of the pokemon
var name = "Brailip"

# Pokedex ID#
var ID = 42

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.PSYCHIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 35
var defense = 65
var sp_attack = 75
var sp_defense = 80
var speed = 45

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 89

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 34

# The pokemon's evolution ID
var evolution_ID = 43

# The pokemon's catch rate
var catch_rate = 125

# Weight in kg
var weight = 22.4

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Confusion"),
	MoveSet.new(6, "Water Gun"),
	MoveSet.new(10, "Harden"),
	MoveSet.new(14, "Yawn"),
	MoveSet.new(18, "Amnesia"),
	MoveSet.new(22, "Water Pulse"),
	MoveSet.new(26, "Psybeam"),
	MoveSet.new(31, "Rest"),
	MoveSet.new(31, "Snore"),
	MoveSet.new(35, "Aqua Tail"),
	MoveSet.new(39, "Psychic"),
	MoveSet.new(43, "Ancient Power"),
	MoveSet.new(47, "Hydro Pump")
]
