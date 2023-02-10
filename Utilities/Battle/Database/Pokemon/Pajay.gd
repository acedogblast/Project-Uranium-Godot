extends Object

# The name of the pokemon
var name = "Panjay"

# Pokedex ID#
var ID = 52

# The pokemon's type. If only one type use type1
var type1 = Type.FIRE
var type2 = Type.FLYING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 80
var attack = 50
var defense = 60
var sp_attack = 110
var sp_defense = 80
var speed = 100

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 2
var ev_yield_sp_defense = 0
var ev_yield_speed = 1

# The pokemon's base experience yield when defeated
var exp_yield : int = 216

# The pokemon's leveling rate
var leveling_rate = FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 50

# The pokemon's evolution level
var evolution_level

# The pokemon's evolution ID
var evolution_ID

# The pokemon's catch rate
var catch_rate = 55

# Weight in kg
var weight = 28.3

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Will-O-Wisp"),
	MoveSet.new(1, "Peck"),
	MoveSet.new(1, "Incinerate"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(4, "Incinerate"),
	MoveSet.new(8, "Growl"),
	MoveSet.new(11, "Quick Attack"),
	MoveSet.new(15, "Air Cutter"),
	MoveSet.new(18, "Flame Burst"),
	MoveSet.new(23, "Sunny Day"),
	MoveSet.new(27, "Roost"),
	MoveSet.new(32, "Air Slash"),
	MoveSet.new(38, "Lava Plume"),
	MoveSet.new(44, "Feather Dance"),
	MoveSet.new(49, "Mirror Move"),
	MoveSet.new(55, "Flamethrower"),
	MoveSet.new(60, "Tailwind"),
	MoveSet.new(66, "Brave Bird"),
]
