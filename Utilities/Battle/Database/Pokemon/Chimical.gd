extends Object

# The name of the pokemon
var name = "Chimical"

# Pokedex ID#
var ID = 103

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 70
var attack = 40
var defense = 50
var sp_attack = 70
var sp_defense = 50
var speed = 50

# The pokemon's public and hidden abilities
var ability = "Petrify"
var hidden_ability = "Contrary"

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
var evolution_level = 40

# The pokemon's evolution ID
var evolution_ID = 104

# The pokemon's catch rate
var catch_rate = 135

# Weight in kg
var weight = 5.7

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Scratch"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(4, "Ember"),
	MoveSet.new(9, "Wrap"),
	MoveSet.new(14, "Smoke Screen"),
	MoveSet.new(17, "Poison_Fang"),
	MoveSet.new(23, "Curse"),
	MoveSet.new(27, "Flame Burst"),
	MoveSet.new(31, "Night Slash"),
	MoveSet.new(34, "Toxic"),
	MoveSet.new(39, "Flamethrower"),
	MoveSet.new(43, "Sludge Bomb"),
	MoveSet.new(46, "Crunch"),
	MoveSet.new(50, "Fire Blast")
]
