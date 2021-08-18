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
	LEVEL_UP_SE,
	UPDATE_BARS,
	UPDATE_MAJOR_AILMENT,
	ESCAPE_SE,
	BALL_CAPTURE_TOSS,
	BALL_SHAKE,
	BALL_BROKE,
	SET_BALL,
	SWITCH_POKE,
	NEXT_POKE
	}

enum {PLAYER_WIN, FOE_WIN}

var type

var battle_grounds_pos_change

var battle_text : String

var press_to_continue : bool = false

var damage_target_index # Used in damage, faint, and exp_gain, stat_animation, heal, UPDATE_MAJOR_AILMENT, NEW_POKE

#var damage_amount : int

var damage_effectiveness : float

var exp_gain_percent : float

var winner

var stat_change_increase : bool

var heal_amount : int

var heal_sound : bool

var level : int

var level_stat_changes : LevelUpChanges

var run_away : bool = false

var ball_type

var captured : bool = false

var switch_poke

func get_type_name():
	match self.type:
		BATTLE_GROUNDS_POS_CHANGE:
			return "BATTLE_GROUNDS_POS_CHANGE"
		BATTLE_TEXT:
			return "BATTLE_TEXT"
		MOVE_ANIMATION:
			return "MOVE_ANIMATION"
		DAMAGE:
			return "DAMAGE"
		BATTLE_END:
			return "BATTLE_END"
		FAINT:
			return "FAINT"
		EXP_GAIN:
			return "EXP_GAIN"
		STAT_CHANGE_ANIMATION:
			return "STAT_CHANGE_ANIMATION"
		WILD_INTRO:
			return "WILD_INTRO"
		HEAL:
			return "HEAL"
		LEVEL_UP:
			return "LEVEL_UP"
		LEVEL_UP_SE:
			return "LEVEL_UP_SE"
		UPDATE_MAJOR_AILMENT:
			return "UPDATE_MAJOR_AILMENT"
		ESCAPE_SE:
			return "ESCAPE_SE"
		BALL_CAPTURE_TOSS:
			return "BALL_CAPTURE_TOSS"
		BALL_SHAKE:
			return "BALL_SHAKE"
		BALL_BROKE:
			return "BALL_BROKE"
		SET_BALL:
			return "SET_BALL"
		SWITCH_POKE:
			return "SWITCH_POKE"
		NEXT_POKE:
			return "NEXT_POKE"
		UPDATE_BARS:
			return "UPDATE_BARS"
		_:
			return str(self.type)