extends Object

# The name of the pokemon
var name = "Dunsparce"

# Pokedex ID#
var ID = 22

# The pokemon's type. If only one type use type1
var type1 = Type.NORMAL
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 100
var attack = 70
var defense = 70
var sp_attack = 65
var sp_defense = 65
var speed = 45

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 1
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 83

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 42

# The pokemon's evolution ID
var evolution_ID = 23

# The pokemon's catch rate
var catch_rate = 190

# Weight in kg
var weight = 14.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Rage"),
	MoveSet.new(1, "Defense Curl"),
	MoveSet.new(4, "Rollout"),
	MoveSet.new(7, "Spite"),
	MoveSet.new(10, "Pursuit"),
	MoveSet.new(13, "Screech"),
	MoveSet.new(16, "Yawn"),
	MoveSet.new(19, "Ancient Power"),
	MoveSet.new(22, "Take Down"),
	MoveSet.new(25, "Roost"),
	MoveSet.new(28, "Glare"),
	MoveSet.new(31, "Dig"),
	MoveSet.new(34, "Double-Edge"),
	MoveSet.new(37, "Coil"),
	MoveSet.new(40, "Endure"),
	MoveSet.new(42, "Sky Fall"),
	MoveSet.new(43, "Drill Run"),
	MoveSet.new(46, "Endeavor"),
	MoveSet.new(49, "Flail")
]
