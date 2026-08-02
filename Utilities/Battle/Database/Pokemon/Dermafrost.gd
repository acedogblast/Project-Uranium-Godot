extends Object

# The name of the pokemon
var name = "Dermafrost"

# Pokedex ID#
var ID = 114

# The pokemon's type. If only one type use type1
var type1 = Type.ICE
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 95
var attack = 115
var defense = 120
var sp_attack = 60
var sp_defense = 70
var speed = 80

# The pokemon's public and hidden abilities
var ability = "Solid Rock"
var ability_2 = "Snow Cloak"
var hidden_ability = "Sturdy"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 2
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 189

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 50

# Weight in kg
var weight = 890.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Blizzard"),
	MoveSet.new(1, "Hammer Arm"),
	MoveSet.new(1, "Rollout"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(6, "Odor Sleuth"),
	MoveSet.new(10, "Ice Shard"),
	MoveSet.new(15, "Defense Curl"),
	MoveSet.new(19, "Stomp"),
	MoveSet.new(24, "Icicle Spear"),
	MoveSet.new(28, "Chip Away"),
	MoveSet.new(33, "Ancient Power"),
	MoveSet.new(37, "Hail"),
	MoveSet.new(40, "Ice Punch"),
	MoveSet.new(44, "Hammer Arm"),
	MoveSet.new(49, "Avalanche"),
	MoveSet.new(51, "Stone Edge"),
	MoveSet.new(54, "Sheer Cold")
]
