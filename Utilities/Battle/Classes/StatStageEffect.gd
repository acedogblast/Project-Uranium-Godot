extends Object
class_name StatStageEffect

# Limits: +6 to -6
var attack = 0
var defense = 0
var sp_attack = 0
var sp_defense = 0
var speed = 0
var accuracy = 0
var evasion = 0

func _init(at : int, def : int, sp_at : int, sp_def: int, speed_ : int, acc : int, eva : int):
    attack = at
    defense = def
    sp_attack = sp_at
    sp_defense = sp_def
    speed = speed_
    accuracy = acc
    evasion = eva