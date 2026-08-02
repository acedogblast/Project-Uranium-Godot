extends Object

# The name of the pokemon
var name = "Miasmedic"

# Pokedex ID#
var ID = 125

# The pokemon's type. If only one type use type1
var type1 = Type.FAIRY
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 81
var attack = 102
var defense = 72
var sp_attack = 79
var sp_defense = 99
var speed = 29

# The pokemon's public and hidden abilities
var ability = "Healer"
var ability_2 = "Poison Touch"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 1
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 158

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
var catch_rate = 200

# Weight in kg
var weight = 15.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Aromatic Mist"),
	MoveSet.new(1, "Heal Pulse"),
	MoveSet.new(1, "Sweet Scent"),
	MoveSet.new(1, "Fairy Wind"),
	MoveSet.new(6, "Sweet Kiss"),
	MoveSet.new(8, "Odor Sleuth"),
	MoveSet.new(13, "Echoed Voice"),
	MoveSet.new(17, "Calm Mind"),
	MoveSet.new(21, "Draining Kiss"),
	MoveSet.new(25, "Aromatherapy"),
	MoveSet.new(29, "Poison Jab"),
	MoveSet.new(31, "Moonblast"),
	MoveSet.new(35, "Charm"),
	MoveSet.new(38, "Flail"),
	MoveSet.new(42, "Misty Terrain"),
	MoveSet.new(44, "Skill Swap"),
	MoveSet.new(48, "Psychic"),
	MoveSet.new(53, "Toxic"),
	MoveSet.new(57, "Reflect"),
	MoveSet.new(64, "Sludge Wave")
]
