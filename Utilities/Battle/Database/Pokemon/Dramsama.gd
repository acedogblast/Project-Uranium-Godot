extends Object

# The name of the pokemon
var name = "Dramsama"

# Pokedex ID#
var ID = 143

# The pokemon's type. If only one type use type1
var type1 = Type.PSYCHIC
var type2 = Type.GHOST

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 85
var attack = 25
var defense = 70
var sp_attack = 105
var sp_defense = 65
var speed = 95

# The pokemon's public and hidden abilities
var ability = "Illusion"
var hidden_ability = "Synchronize"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 180

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
var catch_rate = 75

# Weight in kg
var weight = 42.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Hypnosis"),
	MoveSet.new(1, "Nightmare"),
	MoveSet.new(1, "Dream Eater"),
	MoveSet.new(1, "Psywave"),
	MoveSet.new(3, "Night Shade"),
	MoveSet.new(7, "Peck"),
	MoveSet.new(10, "Hypnosis"),
	MoveSet.new(12, "Teleport"),
	MoveSet.new(14, "Hidden Power"),
	MoveSet.new(16, "Calm Mind"),
	MoveSet.new(19, "Payback"),
	MoveSet.new(24, "Recover"),
	MoveSet.new(25, "Psyshock"),
	MoveSet.new(28, "Dream Eater"),
	MoveSet.new(31, "Confuse Ray"),
	MoveSet.new(33, "Pain Split"),
	MoveSet.new(37, "Psychic"),
	MoveSet.new(40, "Skill Swap"),
	MoveSet.new(45, "Shadow_Ball"),
	MoveSet.new(48, "Trick Room"),
	MoveSet.new(55, "Transform")
]
