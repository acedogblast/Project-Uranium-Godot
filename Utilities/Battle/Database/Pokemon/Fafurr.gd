extends Object

# The name of the pokemon
var name = "Fafurr"

# Pokedex ID#
var ID = 155

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.DRAGON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 90
var attack = 75
var defense = 45
var sp_attack = 60
var sp_defense = 70
var speed = 60

# The pokemon's public and hidden abilities
var ability = "Thick Fat"
var ability_2 = "Fur Coat"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 80

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 55

# The pokemon's evolution ID
var evolution_ID = 156

# The pokemon's catch rate
var catch_rate = 145

# Weight in kg
var weight = 64.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Dragon Tail"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Dragon Breath"),
	MoveSet.new(5, "Powder Snow"),
	MoveSet.new(9, "Tail_Whip"),
	MoveSet.new(12, "Hail"),
	MoveSet.new(15, "Ice Fang"),
	MoveSet.new(17, "Camouflage"),
	MoveSet.new(21, "Glaciate"),
	MoveSet.new(22, "Body_Slam"),
	MoveSet.new(25, "Ice Shard"),
	MoveSet.new(28, "Rock Slide"),
	MoveSet.new(31, "Avalanche"),
	MoveSet.new(33, "Ice_Beam"),
	MoveSet.new(40, "Dragon Tail"),
	MoveSet.new(48, "Dragon_Pulse"),
	MoveSet.new(56, "Dragon Dance"),
	MoveSet.new(58, "Icicle Spear"),
	MoveSet.new(62, "Blizzard"),
	MoveSet.new(65, "Outrage")
]
