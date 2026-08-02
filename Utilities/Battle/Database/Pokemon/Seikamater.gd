extends Object

# The name of the pokemon
var name = "Seikamater"

# Pokedex ID#
var ID = 190

# The pokemon's type. If only one type use type1
var type1 = Type.BUG
var type2 = Type.NORMAL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 155
var attack = 95
var defense = 90
var sp_attack = 105
var sp_defense = 90
var speed = 65

# The pokemon's public and hidden abilities
var ability = "Elementalist"
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 0
var ev_yield_defense = 0
var ev_yield_sp_attack = 1
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 270

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 0

# The pokemon's evolution level
var evolution_level = 0

# The pokemon's evolution ID
var evolution_ID = 0

# The pokemon's catch rate
var catch_rate = 0

# Weight in kg
var weight = 638.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Leech Life"),
	MoveSet.new(1, "Scary Face"),
	MoveSet.new(1, "Scratch"),
	MoveSet.new(11, "Defend Order"),
	MoveSet.new(17, "Night Shade"),
	MoveSet.new(25, "Heal Order"),
	MoveSet.new(35, "Attack Order"),
	MoveSet.new(45, "Tri Attack"),
	MoveSet.new(55, "Fire Blast"),
	MoveSet.new(55, "Thunder"),
	MoveSet.new(55, "Hydro Pump"),
	MoveSet.new(65, "Quiver Dance"),
	MoveSet.new(75, "Hyper Beam")
]
