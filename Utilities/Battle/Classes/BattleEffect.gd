extends Object
class_name BattleEffect

var effect
enum effects {SEEDED, CONFUSED, SLEEP_COUNTER, FORESIGHT, FOCUS_ENERGY, DROWSY, ENCORE, FLINCH, PROTECTED, BOUND, RAMPAGE, REFLECT, LIGHT_SCREEN, CHARGING, ENDURING, WISH, SUBSTITUTE, STOCKPILE, NIGHTMARE, CURSED, PERISH, MIST, SAFEGUARD, ROLLOUT}

var seeded_heal_target_index : int

var turn_count : int # A general purpose turn counter
var bound_move_name := ""

var rampage_move_name := ""
