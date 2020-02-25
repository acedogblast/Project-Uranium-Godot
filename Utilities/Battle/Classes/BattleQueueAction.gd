extends Object
class_name BattleQueueAction
enum {
	BATTLE_GROUNDS_POS_CHANGE,
	BATTLE_TEXT,
	MOVE_ANIMATION,
	DAMAGE,
	FOE_BALLTOSS,
	PLAYER_BALLTOSS,
	BATTLE_END,
	FAINT,
	EXP_GAIN,
	STAT_CHANGE_ANIMATION
	}

enum {PLAYER_WIN, FOE_WIN}

var type

var battle_grounds_pos_change

var battle_text : String

var damage_target_index # Used in both damage, faint, and exp_gain

var damage_amount : int

var damage_effectiveness : float

var exp_gain_percent : float

var winner

var stat_change_increase : bool