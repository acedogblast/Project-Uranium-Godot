extends Object

# The name of the pokemon
var name = "Espeon"

# Pokedex ID#
var ID = 133

# The pokemon's type. If only one type use type1
var type1 = Type.PSYCHIC
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 65
var attack = 65
var defense = 60
var sp_attack = 130
var sp_defense = 95
var speed = 110

# The pokemon's public and hidden abilities
var ability = "Synchronize"
var hidden_ability = "Magic Bounce"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 184

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 26.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Helping Hand"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Confusion"),
	MoveSet.new(13, "Quick Attack"),
	MoveSet.new(17, "Swift"),
	MoveSet.new(21, "Psybeam"),
	MoveSet.new(25, "Future Sight"),
	MoveSet.new(29, "Psych Up"),
	MoveSet.new(33, "Morning Sun"),
	MoveSet.new(37, "Psychic"),
	MoveSet.new(41, "Last Resort"),
	MoveSet.new(45, "Power Swap")
]
