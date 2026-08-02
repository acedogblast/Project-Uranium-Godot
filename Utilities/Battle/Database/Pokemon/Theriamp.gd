extends Object

# The name of the pokemon
var name = "Theriamp"

# Pokedex ID#
var ID = 116

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 75
var attack = 125
var defense = 60
var sp_attack = 60
var sp_defense = 80
var speed = 100

# The pokemon's public and hidden abilities
var ability = "Energizate"
var ability_2 = "Motor Drive"
var hidden_ability = "Rock Head"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 2
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 175

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
var weight = 491.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Odor Sleuth"),
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(7, "Thunder_Shock"),
	MoveSet.new(13, "Thunder Wave"),
	MoveSet.new(19, "Rock Tomb"),
	MoveSet.new(25, "Thunder Punch"),
	MoveSet.new(31, "Slash"),
	MoveSet.new(36, "Swagger"),
	MoveSet.new(41, "Body_Slam"),
	MoveSet.new(43, "Volt Switch"),
	MoveSet.new(49, "Rock Wrecker"),
	MoveSet.new(51, "Wild Charge")
]
