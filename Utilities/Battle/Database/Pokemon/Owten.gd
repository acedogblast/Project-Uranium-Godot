extends Object

# The name of the pokemon
var name = "Owten"

# Pokedex ID#
var ID = 35

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 60
var defense = 30
var sp_attack = 40
var sp_defense = 45
var speed = 75

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 61

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 20

# The pokemon's evolution ID
var evolution_ID = 36

# The pokemon's catch rate
var catch_rate = 200

# Weight in kg
var weight = 2.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(1, "Charm"),
	MoveSet.new(4, "Foresight"),
	MoveSet.new(6, "Quick Attack"),
	MoveSet.new(13, "Wing Attack"),
	MoveSet.new(19, "Sing"),
	MoveSet.new(23, "Confusion"),
	MoveSet.new(26, "Double Team"),
	MoveSet.new(30, "Air Slash"),
	MoveSet.new(34, "Psych Up"),
	MoveSet.new(38, "Ominous Wind"),
	MoveSet.new(40, "Zen Headbutt"),
	MoveSet.new(44, "Sky Attack")
]
