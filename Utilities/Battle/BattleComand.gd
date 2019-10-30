extends Node2D

var enabled = false
enum {ATTACK, BAG, POKE, RUN}
var selected = ATTACK

const ATTACK_POS = Vector2(76, 20)
const BAG_POS = Vector2(195, 20)
const POKE_POS = Vector2(315, 20)
const RUN_POS = Vector2(435, 20)
func _ready():
	$SelHand/AnimationPlayer.play("Squeez")

func _input(event):
	if event.is_action_pressed("ui_left") and enabled and selected != ATTACK:
		selected -= 1
	if event.is_action_pressed("ui_right") and enabled and selected != RUN:
		selected += 1
	change_Sel_Hand_Pos()
func change_Sel_Hand_Pos():
	match selected:
		ATTACK:
			$SelHand.position = ATTACK_POS
		BAG:
			$SelHand.position = BAG_POS
		POKE:
			$SelHand.position = POKE_POS
		RUN:
			$SelHand.position = RUN_POS
	pass