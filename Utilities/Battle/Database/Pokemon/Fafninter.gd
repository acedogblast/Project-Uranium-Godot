extends Object

# The name of the pokemon
var name = "Fafninter"

# Pokedex ID#
var ID = 156

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.DRAGON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 120
var attack = 110
var defense = 77
var sp_attack = 95
var sp_defense = 98
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Thick Fat"
var ability_2 = "Fur Coat"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 266

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 35

# Weight in kg
var weight = 187.7

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
	MoveSet.new(19, "Camouflage"),
	MoveSet.new(23, "Glaciate"),
	MoveSet.new(25, "Body_Slam"),
	MoveSet.new(28, "Ice Shard"),
	MoveSet.new(32, "Rock Slide"),
	MoveSet.new(35, "Avalanche"),
	MoveSet.new(38, "Ice_Beam"),
	MoveSet.new(42, "Dragon Tail"),
	MoveSet.new(53, "Dragon_Pulse"),
	MoveSet.new(59, "Dragon Dance"),
	MoveSet.new(67, "Blizzard"),
	MoveSet.new(74, "Outrage")
]
