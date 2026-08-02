extends Object

# The name of the pokemon
var name = "Slothohm"

# Pokedex ID#
var ID = 115

# The pokemon's type. If only one type use type1
var type1 = Type.ELECTRIC
var type2 = Type.ROCK

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 90
var defense = 50
var sp_attack = 50
var sp_defense = 20
var speed = 70

# The pokemon's public and hidden abilities
var ability = "Energizate"
var ability_2 = "Motor Drive"
var hidden_ability = "Rock Head"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 68

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 40

# The pokemon's evolution ID
var evolution_ID = 116

# The pokemon's catch rate
var catch_rate = 75

# Weight in kg
var weight = 44.8

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
	MoveSet.new(43, "Body_Slam"),
	MoveSet.new(49, "Volt Switch"),
	MoveSet.new(51, "Zap Cannon"),
	MoveSet.new(55, "Head Smash")
]
