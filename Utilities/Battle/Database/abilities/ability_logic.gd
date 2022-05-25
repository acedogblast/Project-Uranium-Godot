extends Object

enum INCREASE {
	HP,
	ATTACK,
	DEFENSE,
	SPECIAL_ATTACK,
	SPECIAL_DEFENSE,
	SPEED,
	STAB
}


# boost specific stat by percentage amount
func boost(stat: int, percentage: float) -> int:
	# calculate boost amount
	var boosted: int = stat * percentage
	
	# apply boost
	return boosted

# maybe unneeded
# lower specific stat by percentage amount
func lower(stat: int, percentage: float) -> int:
	# calculate lower amount
	var boosted: int = stat * percentage
	
	# apply lower
	return boosted


# seems unnecessary
func type_change(new_type: Type) -> Type:
	return new_type
	pass


func deal_damage(amount: int) -> void:
	
	
	pass


# TODO: needs discussion
func weather() -> void:
	pass


func protect() -> void:
	pass


func prevent() -> void:
	pass
