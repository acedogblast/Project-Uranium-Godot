extends Object
class_name BattleStatStage

var attack = 0
var defense = 0
var sp_attack = 0
var sp_defense = 0
var speed = 0
var accuracy = 0
var evasion = 0
var evasion_multiplier = 1.0 # Should be 1.0 most of the time. Be 0.0 when poke is invunrable by fly, dig, etc.

static func get_multiplier(stat: int) -> float:
    match stat:
        -6:
            return 0.25
        -5:
            return 2.0 / 7.0
        -4:
            return 1.0/ 3.0
        -3:
            return 2.0 / 5.0
        -2:
            return 0.5
        -1:
            return 2.0 / 3.0
        0:
            return 1.0
        1:
            return 3.0 / 2.0
        2:
            return 2.0
        3:
            return 5.0 / 2.0
        4:
            return 3.0
        5:
            return 7.0 / 2.0
        6:
            return 4.0
        _:
            print("Battle Error: Stage Stat is over limits!")
            return 1.0
    pass