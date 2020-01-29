extends Object
class_name Move

# The name of the move
var name

# The type of the move
var type

# The style of the move (Physical, Special, Status)
var style

# The base power of the move
var base_power

# The accuracy of the move
var accuracy

# The priority of the move
var priority

# The critical hit level of the move 1=6.25% 2=12.5% 3=25% 4=33.3% 5=50% 
var critical_hit_level

# The secondary effect chance of the move
var secondary_effect_chance

# The flags of the move
var flags

# The total pp of the move
var total_pp

# The remaining pp of the move
var remaining_pp

# The target ability of the move (Single, Double, All, Self)
var target_ability

# The main status effect of the move.
enum {}
var main_status_effect
