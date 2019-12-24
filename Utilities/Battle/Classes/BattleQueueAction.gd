extends Object
class_name BattleQueueAction
enum {
	BATTLE_GROUNDS_POS_CHANGE,
	BATTLE_TEXT,
	MOVE_ANIMATION,
	DAMAGE,
	FOE_BALLTOSS,
	PLAYER_BALLTOSS
	}
var type

var battle_grounds_pos_change

var battle_text : String

var damage_target_index

var damage_amount : int

var damage_effectiveness : float