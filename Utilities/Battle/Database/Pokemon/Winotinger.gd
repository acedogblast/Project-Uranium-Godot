extends Object

# The name of the pokemon
var name = "Winotinger"

# Pokedex ID#
var ID = 127

# The pokemon's type. If only one type use type1
var type1 = Type.FAIRY
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 110
var attack = 80
var defense = 85
var sp_attack = 105
var sp_defense = 85
var speed = 85

# The pokemon's public and hidden abilities
var ability = "Magic Guard"
var ability_2 = "Inner Focus"
var hidden_ability = "Inner Focus"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 2
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 193

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
var catch_rate = 90

# Weight in kg
var weight = 31.5

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Quick Attack"),
	MoveSet.new(1, "Foresight"),
	MoveSet.new(4, "Baby-Doll Eyes"),
	MoveSet.new(8, "Low Kick"),
	MoveSet.new(11, "Detect"),
	MoveSet.new(15, "Fairy Wind"),
	MoveSet.new(18, "Double Team"),
	MoveSet.new(22, "Feint"),
	MoveSet.new(25, "Calm Mind"),
	MoveSet.new(29, "Confuse Ray"),
	MoveSet.new(32, "High Jump Kick"),
	MoveSet.new(36, "Play Rough"),
	MoveSet.new(39, "Reversal"),
	MoveSet.new(43, "Misty Terrain"),
	MoveSet.new(46, "Aura Sphere"),
	MoveSet.new(50, "Final Gambit"),
	MoveSet.new(54, "Moonblast")
]
