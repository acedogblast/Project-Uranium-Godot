extends Object

# The name of the pokemon
var name = "S51"

# Pokedex ID#
var ID = 97

# The pokemon's type. If only one type use type1
var type1 = Type.PSYCHIC
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 60
var defense = 60
var sp_attack = 60
var sp_defense = 60
var speed = 60

# The pokemon's public and hidden abilities
var ability = "Levitate"
var hidden_ability = "Analytic"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 72

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 40

# The pokemon's evolution ID
var evolution_ID = 98

# The pokemon's catch rate
var catch_rate = 45

# Weight in kg
var weight = 12.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Confusion"),
	MoveSet.new(4, "Growl"),
	MoveSet.new(8, "Hypnosis"),
	MoveSet.new(11, "Magnet Bomb"),
	MoveSet.new(15, "Psybeam"),
	MoveSet.new(18, "Headbutt"),
	MoveSet.new(22, "Hidden Power"),
	MoveSet.new(25, "Iron_Defense"),
	MoveSet.new(29, "Simple Beam"),
	MoveSet.new(32, "Zen Headbutt"),
	MoveSet.new(36, "Gyro Ball"),
	MoveSet.new(39, "Ancient Power"),
	MoveSet.new(42, "Rapid_Spin"),
	MoveSet.new(45, "Psychic"),
	MoveSet.new(45, "Recover"),
	MoveSet.new(50, "Light Screen"),
	MoveSet.new(50, "Reflect"),
	MoveSet.new(53, "Trick Room"),
	MoveSet.new(56, "Laser Pulse"),
	MoveSet.new(59, "Meteor Mash")
]
