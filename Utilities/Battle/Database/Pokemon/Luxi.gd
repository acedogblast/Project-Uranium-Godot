extends Object

# The name of the pokemon
var name = "Luxi"

# Pokedex ID#
var ID = 176

# The pokemon's type. If only one type use type1
var type1 = Type.DRAGON
var type2 = Type.FAIRY

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 30
var defense = 40
var sp_attack = 50
var sp_defense = 60
var speed = 40

# The pokemon's public and hidden abilities
var ability = "Super Luck"
var hidden_ability = "Regenerator"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 70

# The pokemon's leveling rate
var leveling_rate = MEDIUM_SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 42

# Weight in kg
var weight = 28.9

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Charm"),
	MoveSet.new(1, "Metronome"),
	MoveSet.new(1, "Dragon Rage"),
	MoveSet.new(7, "Metronome"),
	MoveSet.new(9, "Focus_Energy"),
	MoveSet.new(13, "Fairy Wind"),
	MoveSet.new(18, "Wish"),
	MoveSet.new(20, "Swift"),
	MoveSet.new(25, "Dragon Breath"),
	MoveSet.new(29, "Baton Pass"),
	MoveSet.new(33, "After You"),
	MoveSet.new(37, "Dazzling Gleam"),
	MoveSet.new(41, "Moonlight"),
	MoveSet.new(45, "Dragon_Pulse"),
	MoveSet.new(48, "Dragon Dance"),
	MoveSet.new(55, "Moonblast"),
	MoveSet.new(60, "Draco Meteor")
]
