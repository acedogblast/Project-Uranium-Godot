extends Object

# The name of the pokemon
var name = "Tanscure"

# Pokedex ID#
var ID = 47

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.NORMAL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 85
var defense = 60
var sp_attack = 55
var sp_defense = 80
var speed = 95

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
var exp_yield : int = 159

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
var catch_rate = 205

# Weight in kg
var weight = 38.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Howl"),
	MoveSet.new(1, "Sand Attack"),
	MoveSet.new(1, "Bite"),
	MoveSet.new(5, "Howl"),
	MoveSet.new(9, "Sand Attack"),
	MoveSet.new(13, "Bite"),
	MoveSet.new(17, "Odor Sleuth"),
	MoveSet.new(22, "Roar"),
	MoveSet.new(27, "Swagger"),
	MoveSet.new(32, "Scary Face"),
	MoveSet.new(37, "Take Down"),
	MoveSet.new(42, "Taunt"),
	MoveSet.new(47, "Crunch"),
	MoveSet.new(52, "Sudden Strike")
]
