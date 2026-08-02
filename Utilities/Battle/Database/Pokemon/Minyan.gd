extends Object

# The name of the pokemon
var name = "Minyan"

# Pokedex ID#
var ID = 69

# The pokemon's type. If only one type use type1
var type1 = Type.DARK
var type2 = Type.POISON

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 48
var attack = 64
var defense = 36
var sp_attack = 58
var sp_defense = 35
var speed = 61

# The pokemon's public and hidden abilities
var ability = "Blood Lust"
var hidden_ability = "Poison Touch"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 60

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
var catch_rate = 140

# Weight in kg
var weight = 14.8

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(3, "Poison_Sting"),
	MoveSet.new(8, "Taunt"),
	MoveSet.new(13, "Bite"),
	MoveSet.new(17, "Mean Look"),
	MoveSet.new(22, "Poison_Fang"),
	MoveSet.new(24, "Swagger"),
	MoveSet.new(28, "Thief"),
	MoveSet.new(31, "Venoshock"),
	MoveSet.new(36, "Nasty Plot"),
	MoveSet.new(38, "Drain Life"),
	MoveSet.new(42, "Foul Play"),
	MoveSet.new(45, "Venom Drench"),
	MoveSet.new(47, "Toxic"),
	MoveSet.new(50, "Shadow Sneak")
]
