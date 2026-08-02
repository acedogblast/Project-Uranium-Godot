extends Object

# The name of the pokemon
var name = "Linkite"

# Pokedex ID#
var ID = 147

# The pokemon's type. If only one type use type1
var type1 = Type.GHOST
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 35
var attack = 55
var defense = 25
var sp_attack = 20
var sp_defense = 50
var speed = 30

# The pokemon's public and hidden abilities
var ability = "Shadow Tag"
var ability_2 = "Cursed Body"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 78

# The pokemon's leveling rate
var leveling_rate = SLOW
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = null

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 75

# Weight in kg
var weight = 98.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Curse"),
	MoveSet.new(1, "Night Shade"),
	MoveSet.new(1, "Mean Look"),
	MoveSet.new(6, "Pursuit"),
	MoveSet.new(12, "Spite"),
	MoveSet.new(19, "Imprison"),
	MoveSet.new(24, "Shadow Claw"),
	MoveSet.new(29, "Pain Split"),
	MoveSet.new(33, "Shadow Sneak"),
	MoveSet.new(38, "Grudge"),
	MoveSet.new(43, "Memento"),
	MoveSet.new(49, "Phantom Force"),
	MoveSet.new(56, "Destiny Bond")
]
