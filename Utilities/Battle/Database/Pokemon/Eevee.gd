extends Object

# The name of the pokemon
var name = "Eevee"

# Pokedex ID#
var ID = 129

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 55
var defense = 50
var sp_attack = 45
var sp_defense = 65
var speed = 55

# The pokemon's public and hidden abilities
var ability = "Run Away"
var ability_2 = "Adaptability"
var hidden_ability = "Anticipation"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 65

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
var weight = 6.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Helping Hand"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Tail_Whip"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Sand Attack"),
	MoveSet.new(9, "Baby-Doll Eyes"),
	MoveSet.new(10, "Swift"),
	MoveSet.new(13, "Quick Attack"),
	MoveSet.new(17, "Bite"),
	MoveSet.new(20, "Refresh"),
	MoveSet.new(23, "Covet"),
	MoveSet.new(25, "Take Down"),
	MoveSet.new(29, "Charm"),
	MoveSet.new(33, "Baton Pass"),
	MoveSet.new(37, "Double-Edge"),
	MoveSet.new(41, "Last Resort"),
	MoveSet.new(45, "Trump Card")
]
