extends Object

# The name of the move
var name = "Blizzard"

# The type of the move
var type = Type.ICE

# The style of the move (Physical, Special, Status)
var style = MoveStyle.SPECIAL

# The base power of the move
var base_power = 110

# The accuracy of the move
var accuracy = 70

# The priority of the move
var priority = 0

# The critical hit level of the move 1=6.25% 2=12.5% 3=25% 4=33.3% 5=50% 
var critical_hit_level = 1

# The secondary effect chance of the move
var secondary_effect_chance = 0.1

# The secondary effect of the move
var secondary_effect = MajorAilment.FREEZE

# The flags of the move
var flags = []

# The total pp of the move
var total_pp = 5

# The target ability of the move (SINGLE_FOE, ALL_FOE, ALL, SELF)
var target_ability = MoveTarget.ALL_FOE
# attack, defense, sp_atack, sp_defense, speed, accuracy, evasion
var main_status_effect 