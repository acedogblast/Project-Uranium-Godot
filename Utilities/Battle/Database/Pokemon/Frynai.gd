extends Object

# The name of the pokemon
var name = "Frynai"

# Pokedex ID#
var ID = 118

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 55
var attack = 68
var defense = 32
var sp_attack = 40
var sp_defense = 37
var speed = 79

# The pokemon's public and hidden abilities
var ability = "Swift Swim"
var ability_2 = "Inner Focus"
var hidden_ability = "Sheer Force"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 78

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 36

# The pokemon's evolution ID
var evolution_ID = 119

# The pokemon's catch rate
var catch_rate = 185

# Weight in kg
var weight = 3.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(4, "Quick Attack"),
	MoveSet.new(8, "Water Gun"),
	MoveSet.new(11, "Swords Dance"),
	MoveSet.new(15, "Slash"),
	MoveSet.new(16, "Metal Claw"),
	MoveSet.new(19, "Aqua_Jet"),
	MoveSet.new(24, "Swagger"),
	MoveSet.new(28, "Fury Swipes"),
	MoveSet.new(33, "Aqua Tail"),
	MoveSet.new(36, "Feint Attack"),
	MoveSet.new(37, "Iron Tail"),
	MoveSet.new(41, "X-Scissor"),
	MoveSet.new(44, "Iron Head"),
	MoveSet.new(49, "Agility"),
	MoveSet.new(53, "Night Slash"),
	MoveSet.new(58, "Hydro Pump")
]
