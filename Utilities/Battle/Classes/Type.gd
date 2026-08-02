extends Object
class_name Type
enum {
	NORMAL,
	FIGHTING,
	FLYING,
	POISON,
	GROUND,
	ROCK,
	BUG,
	GHOST,
	STEEL,
	UNKNOWN,
	FIRE,
	WATER,
	GRASS,
	ELECTRIC,
	PSYCHIC,
	ICE,
	DRAGON,
	DARK,
	NUCLEAR,
	FAIRY
}
static func type_advantage_multiplier(attack_move_type, defender_poke: Pokemon):
	var multiplier := 1.0
	if defender_poke.type2 != null:
		multiplier = multiplier * type_advantage_matrix(attack_move_type, defender_poke.type1) * type_advantage_matrix(attack_move_type, defender_poke.type2)
	else:
		multiplier = multiplier * type_advantage_matrix(attack_move_type, defender_poke.type1)
	return multiplier
static func type_advantage_matrix(attack_type, defending_type) -> float:
	match attack_type:
		NORMAL:
			match defending_type:
				ROCK:
					return 0.5
				GHOST:
					return 0.0
				STEEL:
					return 0.5
		FIGHTING:
			match defending_type:
				NORMAL:
					return 2.0
				FLYING:
					return 0.5
				POISON:
					return 0.5
				ROCK:
					return 2.0
				BUG:
					return 0.5
				GHOST:
					return 0.0
				STEEL:
					return 2.0
		FLYING:
			match defending_type:
				FIGHTING:
					return 2.0
				ROCK:
					return 0.5
				BUG:
					return 2.0
				STEEL:
					return 0.5
				GRASS:
					return 2.0
				ELECTRIC:
					return 0.5
		POISON:
			match defending_type:
				POISON:
					return 0.5
				GROUND:
					return 0.5
				ROCK:
					return 0.5
				GHOST:
					return 0.5
				STEEL:
					return 0.0
				GRASS:
					return 2.0
				ELECTRIC:
					return 0.5
		GROUND:
			match defending_type:
				FLYING:
					return 0.0
				POISON:
					return 2.0
				ROCK:
					return 2.0
				BUG:
					return 0.5
				STEEL:
					return 2.0
				FIRE:
					return 2.0
				GRASS:
					return 0.5
				ELECTRIC:
					return 2.0
		ROCK:
			match defending_type:
				FIGHTING:
					return 0.5
				FLYING:
					return 2.0
				GROUND:
					return 0.5
				BUG:
					return 2.0
				STEEL:
					return 0.5
				FIRE:
					return 2.0
				ICE:
					return 2.0
		BUG:
			match defending_type:
				FIGHTING:
					return 0.5
				FLYING:
					return 0.5
				POISON:
					return 0.5
				GHOST:
					return 0.5
				STEEL:
					return 0.5
				FIRE:
					return 0.5
				GRASS:
					return 2.0
				PSYCHIC:
					return 2.0
				DARK:
					return 2.0
				FAIRY:
					return 0.5
		GHOST:
			match defending_type:
				NORMAL: 
					return 0.0
				GHOST:
					return 2.0
				PSYCHIC:
					return 2.0
				DARK:
					return 0.5
		STEEL:
			match defending_type:
				ROCK:
					return 2.0
				STEEL:
					return 0.5
				FIRE:
					return 0.5
				WATER:
					return 0.5
				ELECTRIC:
					return 0.5
				ICE:
					return 2.0
				FAIRY:
					return 2.0
		FIRE:
			match defending_type:
				ROCK:
					return 0.5
				BUG:
					return 2.0
				STEEL:
					return 2.0
				FIRE:
					return 0.5
				WATER:
					return 0.5
				GRASS:
					return 2.0
				ICE:
					return 2.0
				DRAGON:
					return 0.5
		WATER:
			match defending_type:
				GROUND:
					return 2.0
				ROCK:
					return 2.0
				FIRE:
					return 2.0
				WATER:
					return 0.5
				GRASS:
					return 0.5
				DRAGON:
					return 0.5
		GRASS:
			match defending_type:
				FLYING:
					return 0.5
				POISON:
					return 0.5
				GROUND:
					return 2.0
				ROCK:
					return 2.0
				BUG:
					return 0.5
				STEEL:
					return 0.5
				FIRE:
					return 0.5
				WATER:
					return 2.0
				GRASS:
					return 0.5
				DRAGON:
					return 0.5
		ELECTRIC:
			match defending_type:
				FLYING:
					return 2.0
				GROUND:
					return 0.0
				WATER:
					return 2.0
				GRASS:
					return 0.5
				ELECTRIC:
					return 0.5
				DRAGON:
					return 0.5
		PSYCHIC:
			match defending_type:
				FIGHTING:
					return 2.0
				POISON:
					return 2.0
				STEEL:
					return 0.5
				PSYCHIC:
					return 0.5
				DARK:
					return 0.0
		ICE:
			match defending_type:
				FLYING:
					return 2.0
				GROUND:
					return 2.0
				STEEL:
					return 0.5
				FIRE:
					return 0.5
				WATER:
					return 0.5
				GRASS:
					return 2.0
				DRAGON:
					return 2.0
		DRAGON:
			match defending_type:
				STEEL:
					return 0.5
				DRAGON:
					return 2.0
				FAIRY:
					return 0.0
		DARK:
			match defending_type:
				FIGHTING:
					return 0.5
				GHOST:
					return 2.0
				PSYCHIC:
					return 2.0
				DARK:
					return 0.5
				FAIRY:
					return 0.5
		FAIRY:
			match defending_type:
				FLYING:
					return 2.0
				POISON:
					return 0.5
				STEEL:
					return 0.5
				FIRE:
					return 0.5
				DRAGON:
					return 2.0
				DARK:
					return 2.0
		NUCLEAR:
			if defending_type == STEEL || defending_type == NUCLEAR:
				return 0.5
			else:
				return 2.0
					

	return 1.0
