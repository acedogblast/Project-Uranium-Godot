extends Object

# The name of the pokemon
var name = "Pahar"

# Pokedex ID#
var ID = 50

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 45
var attack = 45
var defense = 50
var sp_attack = 70
var sp_defense = 60
var speed = 60

# The pokemon's public and hidden abilities
var ability
var hidden_ability

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
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level = 19

# The pokemon's evolution ID
var evolution_ID = 51

# The pokemon's catch rate
var catch_rate = 255

# Weight in kg
var weight = 1.6

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Peck"),
	MoveSet.new(4, "Incinerate"),
	MoveSet.new(8, "Growl"),
	MoveSet.new(11, "Quick Attack"),
	MoveSet.new(15, "Air Cutter"),
	MoveSet.new(18, "Flame Burst"),
	MoveSet.new(22, "Sunny Day"),
	MoveSet.new(25, "Roost"),
	MoveSet.new(29, "Air Slash"),
	MoveSet.new(32, "Lava Plume"),
	MoveSet.new(36, "Feather Dance"),
	MoveSet.new(39, "Mirror Move"),
	MoveSet.new(43, "Flamethrower"),
	MoveSet.new(46, "Tailwind"),
	MoveSet.new(50, "Brave Bird"),
]
