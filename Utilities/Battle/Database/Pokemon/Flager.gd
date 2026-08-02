extends Object

# The name of the pokemon
var name = "Flager"

# Pokedex ID#
var ID = 101

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 40
var attack = 55
var defense = 45
var sp_attack = 65
var sp_defense = 50
var speed = 90

# The pokemon's public and hidden abilities
var ability = "Flash Fire"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 69

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 155

# Weight in kg
var weight = 8.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(5, "Ember"),
	MoveSet.new(13, "Smoke Screen"),
	MoveSet.new(19, "Flame Wheel"),
	MoveSet.new(23, "Bite"),
	MoveSet.new(27, "Extreme_Speed"),
	MoveSet.new(31, "Flamethrower"),
	MoveSet.new(37, "Double Team"),
	MoveSet.new(43, "Flame_Impact"),
	MoveSet.new(47, "Flare Blitz"),
	MoveSet.new(53, "Fire Blast")
]
