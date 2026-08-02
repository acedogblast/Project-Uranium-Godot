extends Object
class_name Ability


enum ABILITY_TYPE {
	TEST,
	BOOST,
	LOWER,
	TYPE_CHANGE,
	DAMAGE_DEAL,
	WEATHER,
	PROTECT,
	NO_CHANGE,
	PREVENT,
	
}

var name : String
var description : String

var id : int

var type = ABILITY_TYPE.BOOST

func on_use() -> void:
	# call function to use from ability_logic.gd
	
	pass
