extends Object
class_name Nature

var nature

enum {
	HARDY,
	LONELY,
	BRAVE,
	ADAMANT,
	NAUGHTY,
	DOCILE,
	BOLD,
	RELAXED,
	IMPISH,
	LAX,
	SERIOUS,
	TIMID,
	HASTY,
	JOLLY,
	NAIVE,
	BASHFUL,
	MODEST,
	MILD,
	QUIET,
	RASH,
	QUIRKY,
	CALM,
	GENTLE,
	SASSY,
	CAREFUL
}

enum stat_types {ATTACK, DEFENSE, SP_ATTACK, SP_DEFENSE, SPEED}
static func get_stat_multiplier(n , type) -> float:
	match type:
		stat_types.ATTACK:
			if n == LONELY or n == BRAVE or n == ADAMANT or n == NAUGHTY:
				return 1.1
			if n == BOLD or n == TIMID or n == MODEST or n == CALM:
				return 0.9
		stat_types.DEFENSE:
			if n == BOLD or n == RELAXED or n == IMPISH or n == LAX:
				return 1.1
			if n == LONELY or n == HASTY or n == MILD or n == GENTLE:
				return 0.9
		stat_types.SP_ATTACK:
			if n == MODEST or n == MILD or n == QUIET or n == RASH:
				return 1.1
			if n == ADAMANT or n == IMPISH or n == JOLLY or n == CAREFUL:
				return 0.9
		stat_types.SP_DEFENSE:
			if n == CALM or n == GENTLE or n == SASSY or n == CAREFUL:
				return 1.1
			if n == NAUGHTY or n == LAX or n == NAIVE or n == RASH:
				return 0.9
		stat_types.SPEED:
			if n == TIMID or n == HASTY or n == JOLLY or n == NAIVE:
				return 1.1
			if n == BRAVE or n == BOLD or n == TIMID or n == QUIET:
				return 0.9
	return 1.0