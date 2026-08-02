extends Object

# The name of the pokemon
var name = "Paraudio"

# Pokedex ID#
var ID = 99

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2 = Type.PSYCHIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 40
var defense = 55
var sp_attack = 60
var sp_defense = 50
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Soundproof"
var ability_2 = "Sound Boost"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 66

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 38

# The pokemon's evolution ID
var evolution_ID = 100

# The pokemon's catch rate
var catch_rate = 225

# Weight in kg
var weight = 47.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Leer"),
	MoveSet.new(8, "Roar"),
	MoveSet.new(13, "Confusion"),
	MoveSet.new(16, "Snarl"),
	MoveSet.new(20, "Psybeam"),
	MoveSet.new(24, "Supersonic"),
	MoveSet.new(28, "Round"),
	MoveSet.new(32, "Uproar"),
	MoveSet.new(34, "Screech"),
	MoveSet.new(34, "Psyshock"),
	MoveSet.new(38, "Zen Headbutt"),
	MoveSet.new(41, "Nasty Plot"),
	MoveSet.new(44, "Psychic"),
	MoveSet.new(50, "Hyper_Voice"),
	MoveSet.new(60, "Boomburst")
]
