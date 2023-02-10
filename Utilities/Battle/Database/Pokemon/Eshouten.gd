extends Object

# The name of the pokemon
var name = "Eshouten"

# Pokedex ID#
var ID = 36

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 85
var defense = 55
var sp_attack = 65
var sp_defense = 60
var speed = 110

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 2

# The pokemon's base experience yield when defeated
var exp_yield : int = 158

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 12.2

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(1, "Charm"),
	MoveSet.new(1, "Foresight"),
	MoveSet.new(1, "Confusion"),
	MoveSet.new(4, "Foresight"),
	MoveSet.new(8, "Quick Attack"),
	MoveSet.new(13, "Wing Attack"),
	MoveSet.new(19, "Sing"),
	MoveSet.new(25, "Confusion"),
	MoveSet.new(28, "Double Team"),
	MoveSet.new(32, "Air Slash"),
	MoveSet.new(37, "Psych Up"),
	MoveSet.new(42, "Ominous Wind"),
	MoveSet.new(47, "Zen Headbutt"),
	MoveSet.new(52, "Sky Attack")
]
