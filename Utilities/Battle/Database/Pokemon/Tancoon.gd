extends Object

# The name of the pokemon
var name = "Tancoon"

# Pokedex ID#
var ID = 46

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.NORMAL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 55
var defense = 40
var sp_attack = 45
var sp_defense = 55
var speed = 60

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
var exp_yield : int = 62

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 18

# The pokemon's evolution ID
var evolution_ID = 47

# The pokemon's catch rate
var catch_rate = 235

# Weight in kg
var weight = 6.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(5, "Howl"),
	MoveSet.new(9, "Sand Attack"),
	MoveSet.new(13, "Bite"),
	MoveSet.new(17, "Odor Sleuth"),
	MoveSet.new(21, "Roar"),
	MoveSet.new(25, "Swagger"),
	MoveSet.new(29, "Scary Face"),
	MoveSet.new(33, "Take Down"),
	MoveSet.new(37, "Taunt"),
	MoveSet.new(41, "Crunch"),
	MoveSet.new(45, "Sudden Strike")
]
