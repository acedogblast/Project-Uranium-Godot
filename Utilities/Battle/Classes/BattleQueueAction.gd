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
	STAT_CHANGE_ANIMATION,
	WILD_INTRO,
	HEAL,
	LEVEL_UP,
	LEVEL_UP_SE
	}

enum {PLAYER_WIN, FOE_WIN}

var type

var battle_grounds_pos_change

var battle_text : String

var press_to_continue : bool = false

var damage_target_index # Used in both damage, faint, and exp_gain, stat_animation, heal

var damage_amount : int

var damage_effectiveness : float

var exp_gain_percent : float

var winner

var stat_change_increase : bool

var heal_amount : int

var heal_sound : bool

var level : int

var level_stat_changes : LevelUpChanges