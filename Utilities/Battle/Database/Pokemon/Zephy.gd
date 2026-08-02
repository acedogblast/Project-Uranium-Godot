extends Object

# The name of the pokemon
var name = "Zephy"

# Pokedex ID#
var ID = 200

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2 = Type.ICE

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 100
var attack = 100
var defense = 100
var sp_attack = 100
var sp_defense = 100
var speed = 100

# The pokemon's public and hidden abilities
var ability = "Levitate"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 270

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 0

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 5

# Weight in kg
var weight = 28.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Hidden Power"),
	MoveSet.new(1, "Charm"),
	MoveSet.new(1, "Ice Shard"),
	MoveSet.new(10, "Thunder_Shock"),
	MoveSet.new(20, "Nuzzle"),
	MoveSet.new(30, "Dazzling Gleam"),
	MoveSet.new(40, "Feather_Dance"),
	MoveSet.new(50, "Air_Slash"),
	MoveSet.new(60, "Thunderbolt"),
	MoveSet.new(70, "Icicle Crash"),
	MoveSet.new(80, "Hurricane"),
	MoveSet.new(90, "Electric Terrain"),
	MoveSet.new(100, "Freeze Shock")
]
