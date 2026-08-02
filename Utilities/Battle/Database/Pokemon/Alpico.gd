extends Object

# The name of the pokemon
var name = "Alpico"

# Pokedex ID#
var ID = 150

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 60
var defense = 70
var sp_attack = 110
var sp_defense = 78
var speed = 132

# The pokemon's public and hidden abilities
var ability = "Competitive"
var ability_2 = "Technician"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 184

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 45.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Ice Shard"),
	MoveSet.new(1, "Powder Snow"),
	MoveSet.new(1, "Charm"),
	MoveSet.new(5, "Fairy Wind"),
	MoveSet.new(9, "Charm"),
	MoveSet.new(13, "Icy Wind"),
	MoveSet.new(17, "Quick Attack"),
	MoveSet.new(21, "Endure"),
	MoveSet.new(25, "Disarming Voice"),
	MoveSet.new(29, "Double Kick"),
	MoveSet.new(33, "Reversal"),
	MoveSet.new(36, "Ice_Beam"),
	MoveSet.new(41, "Fake Out"),
	MoveSet.new(45, "Dazzling Gleam"),
	MoveSet.new(53, "Blizzard"),
	MoveSet.new(59, "Moonblast"),
	MoveSet.new(63, "Sheer Cold")
]
