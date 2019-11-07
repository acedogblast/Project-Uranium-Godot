extends Object

# The name of the pokemon
var name = "Eletux"

# Pokedex ID#
var ID = 5

# The pokemon's type. If only one type use type1
var type1 = Type.WATER
var type2 = Type.ELECTRIC

# The pokemon's base stats (HP,Attack,Defense,Sp.Atack,Sp.Def,Speed)
var hp = 60
var attack = 50
var defense = 65
var sp_attack = 50
var sp_defense = 65
var speed = 45

# The pokemon's level
var level = 1

# The pokemon's total experience
var experience = 0

# The pokemon's nature
var nature

# The pokemon's public and hidden abilities
var ability
var hidden_ability

# The pokemon's Individual Values
var iv_hp
var iv_attack
var iv_defense
var iv_sp_attack
var iv_sp_defense
var iv_speed

# The pokemon's Effort Values
var ev_hp
var ev_attack
var ev_defense
var ev_sp_attack
var ev_sp_defense
var ev_speed

# The pokemon's held Item
var item

# The pokemon's Move set
var move_1
var move_2
var move_3
var move_4

# The pokemon's gender
var gender
enum {MALE, FEMALE}
