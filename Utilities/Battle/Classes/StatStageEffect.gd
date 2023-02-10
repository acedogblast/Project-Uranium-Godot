extends Object
class_name StatStageEffect

# Limits: +6 to -6
var attack : int = 0
var defense : int = 0
var sp_attack : int = 0
var sp_defense : int = 0
var speed : int = 0
var accuracy : int = 0
var evasion : int = 0

func _init(at : int,def : int,sp_at : int,sp_def: int,speed_ : int,acc : int,eva : int):
    attack = at
    defense = def
    sp_attack = sp_at
    sp_defense = sp_def
    speed = speed_
    accuracy = acc
    evasion = eva