extends Object

# The name of the move
var name = "Sky Fall"

# The type of the move
var type = Type.FLYING

# The style of the move (Physical, Special, Status)
var style = MoveStyle.PHYSICAL

# The base power of the move
var base_power = 85

# The accuracy of the move
var accuracy = 100

# The priority of the move
var priority = 0

# The critical hit level of the move 1=6.25% 2=12.5% 3=25% 4=33.3% 5=50% 
var critical_hit_level = 1

# The secondary effect chance of the move
var secondary_effect_chance = 0.3

# The secondary effect of the move
var secondary_effect = MajorAilment.PARALYZE

# The flags of the move
var flags = []

# The total pp of the move
var total_pp = 15

# The target ability of the move (SINGLE_FOE, ALL_FOE, ALL, SELF)
var target_ability = MoveTarget.SINGLE_FOE
# attack, defense, sp_atack, sp_defense, speed, accuracy, evasion
var main_status_effect 