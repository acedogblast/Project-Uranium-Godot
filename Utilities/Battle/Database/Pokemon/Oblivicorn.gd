extends Object

# The name of the pokemon
var name = "Oblivicorn"

# Pokedex ID#
var ID = 175

# The pokemon's type. If only one type use type1
var type1 = Type.FAIRY
var type2 = Type.DARK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 123
var defense = 67
var sp_attack = 67
var sp_defense = 65
var speed = 113

# The pokemon's public and hidden abilities
var ability = "Mold Breaker"
var ability_2 = "Quick Feet"
var hidden_ability = "Defiant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 174

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 25

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 75

# Weight in kg
var weight = 560.7

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Me First"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(8, "Torment"),
	MoveSet.new(12, "Quick Attack"),
	MoveSet.new(16, "Horn Attack"),
	MoveSet.new(20, "Feint Attack"),
	MoveSet.new(24, "Take Down"),
	MoveSet.new(29, "Taunt"),
	MoveSet.new(33, "Pursuit"),
	MoveSet.new(36, "Dark Pulse"),
	MoveSet.new(40, "Moonlight"),
	MoveSet.new(44, "Head Charge"),
	MoveSet.new(50, "Night Slash"),
	MoveSet.new(55, "Play Rough"),
	MoveSet.new(58, "Sudden Strike")
]
