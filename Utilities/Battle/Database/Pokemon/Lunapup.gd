extends Object

# The name of the pokemon
var name = "Lunapup"

# Pokedex ID#
var ID = 67

# The pokemon's type. If only one type use type1
var type1 = Type.GROUND
var type2 = Type.FIGHTING

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 64
var attack = 64
var defense = 64
var sp_attack = 30
var sp_defense = 44
var speed = 36

# The pokemon's public and hidden abilities
var ability = "Mold Breaker"
var ability_2 = "Guts"
var hidden_ability = "Defiant"

# The pokemon's Effort Value Yeild
var ev_yield_hp = 0
var ev_yield_attack = 1
var ev_yield_defense = 0
var ev_yield_sp_attack = 0
var ev_yield_sp_defense = 0
var ev_yield_speed = 0

# The pokemon's base experience yield when defeated
var exp_yield : int = 70

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
var catch_rate = 128

# Weight in kg
var weight = 8.0

# Moveset by leveling
var moveset = [
	MoveSet.new(1, "Tackle"),
	MoveSet.new(1, "Growl"),
	MoveSet.new(7, "Bulldoze"),
	MoveSet.new(10, "Howl"),
	MoveSet.new(12, "Low Kick"),
	MoveSet.new(15, "Endure"),
	MoveSet.new(22, "Wideguard"),
	MoveSet.new(25, "Bone Rush"),
	MoveSet.new(29, "Bulk Up"),
	MoveSet.new(31, "Reversal"),
	MoveSet.new(35, "Body_Slam"),
	MoveSet.new(39, "Detect"),
	MoveSet.new(42, "Dig"),
	MoveSet.new(45, "Close Combat"),
	MoveSet.new(48, "Moonlight"),
	MoveSet.new(54, "Earthquake")
]
