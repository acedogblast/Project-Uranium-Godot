extends Object

# Class for data of a battle which includes Battle type, Opponent's pokemon, Battleback type, Victory award, etc.
# Required to start a battle
class_name BattleInstanceData

# Opponent data: Use Opponent class or any Subclass of Opponent
var opponent : Opponent

# Type of battle
var battle_type
enum BattleType {
	SINGLE_WILD, DOUBLE_WILD, SINGLE_TRAINER, DOUBLE_TRAINER, SINGLE_GYML, DOUBLE_GYML, RIVAL, URAYNE, LEGENDARY
}

# Battleback type
var battle_back
enum BattleBack {
	BEACH, CAVE, CHAMPIONSHIP_1, CHAMPIONSHIP_2, CITY, DIVE, FEILD_1, FEILD_2, FEILD_3, 
	FLOWER, GAMMA, GYM_4, ICE_CAVE, INDOOR_1, INDOOR_2, MOUNTAIN, NUCLEAR, PVP, RIVER, 
	SHELTER, SNOW, VOLCANO, WATER, FOREST
}

# Victory award in money
var victory_award : int = 0
