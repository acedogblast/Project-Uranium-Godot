extends Node2D

const PLAYER_HP_FULL_POS = Vector2(202, 90)
const PLAYER_HP_EMPTY_POS = Vector2(28, 90)
const PLAYER_EXP_FULL_POS = Vector2(154, 10)
const PLAYER_EXP_EMPTY_POS = Vector2(2, 10)
const FOE_HP_FULL_POS = Vector2(198, 90)
const FOE_HP_EMPTY_POS = Vector2(24, 90)

var foe_hp_percent = 1.0
var player_hp_percent = 1.0


func set_player_bar_by_pokemon(poke):
	player_hp_percent = float(poke.current_hp) / float(poke.hp)
	$PlayerBar/NameLable.text = poke.name
	$PlayerBar/LevelLable.text = str(poke.level)
	$PlayerBar/HP.region_rect = get_player_rect2d_by_percentage(player_hp_percent)
	pass
func set_foe_bar_by_pokemon(poke):
	foe_hp_percent = float(poke.current_hp) / float(poke.hp)
	$FoeBar/NameLable.text = poke.name
	$FoeBar/LevelLable.text = str(poke.level)
	
	$FoeBar/HP.region_rect = get_foe_rect2d_by_percentage(foe_hp_percent)
	
	pass
func get_foe_rect2d_by_percentage(percent):
	return Rect2(0,0, 174 * percent + 24, 90)
func get_player_rect2d_by_percentage(percent):
	return Rect2(0,0, 174 * percent + 28, 90)