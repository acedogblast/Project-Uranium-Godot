extends Object

# The name of the pokemon
var name = "Orchynx"

# Pokedex ID#
var ID = 1

# The pokemon's type. If only one type use type1
var type1 = Type.GRASS
var type2 = Type.STEEL

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 50
var attack = 55
var defense = 55
var sp_attack = 70
var sp_defense = 70
var speed = 50

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Effort Value Yeild
var ev_yield_type = ev_spAtk
enum {ev_hp, ev_atk, ev_def, ev_spAtk, ev_spDef, ev_Sp}

# The pokemon's leveling rate
var leveling_rate = MEDIUM_FAST
enum {SLOW, MEDIUM_SLOW, MEDIUM_FAST, FAST, ERRATIC, FLUCTUATING}

# The pokemon's gender ratio male percentage.
var male_ratio = 87.5