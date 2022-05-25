extends Object

# Class for containing information about an opponent for a battle.
# Contains stuff like what pokemon(s)
class_name Opponent

var pokemon_group = [] # Cannot be more that 6

var name

enum {OPPONENT_RIVAL, OPPONENT_TRAINER, OPPONENT_WILD, OPPONENT_GYM_LEADER}
var opponent_type

var after_battle_quote : String

var battle_texture : Texture

var ai : AI
