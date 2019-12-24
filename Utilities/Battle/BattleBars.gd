extends Node2D
signal finished
const PLAYER_HP_FULL_POS = Vector2(202, 90)
const PLAYER_HP_EMPTY_POS = Vector2(28, 90)
const PLAYER_EXP_FULL_POS = Vector2(154, 10)
const PLAYER_EXP_EMPTY_POS = Vector2(2, 10)
const FOE_HP_FULL_POS = Vector2(198, 90)
const FOE_HP_EMPTY_POS = Vector2(24, 90)

var foe_hp_percent = 1.0
var player_hp_percent = 1.0
var player_total_hp
var player_final_hp

var timer
var timer_step = 0


func set_player_bar_by_pokemon(poke):
	player_total_hp = poke.hp
	player_hp_percent = float(poke.current_hp) / float(player_total_hp)
	$PlayerBar/HPLable.text = str(poke.current_hp) + "/ " + str(player_total_hp)
	$PlayerBar/HPLable/HPLableShadow.text = str(poke.current_hp) + "/ " + str(player_total_hp)
	$PlayerBar/NameLable.text = " " + poke.name
	$PlayerBar/LevelLable.text = " " + str(poke.level)
	$PlayerBar/HP.region_rect = get_player_rect2d_by_percentage(player_hp_percent)
	pass
func set_foe_bar_by_pokemon(poke):
	foe_hp_percent = float(poke.current_hp) / float(poke.hp)
	$FoeBar/NameLable.text = " " + poke.name
	$FoeBar/LevelLable.text = " " + str(poke.level)
	$FoeBar/HP.region_rect = get_foe_rect2d_by_percentage(foe_hp_percent)
	pass
func get_foe_rect2d_by_percentage(percent: float):
	return Rect2(0,0, 174 * percent + 24, 90)
func get_player_rect2d_by_percentage(percent: float):
	return Rect2(0,0, 174 * percent + 28, 90)

func slide_player_bar(percent: float , final_hp : int): #TODO: Figure out how to tween the region rect of a sprite.
	player_final_hp = final_hp
	var tween = $PlayerBar/Tween
	tween.interpolate_method($PlayerBar/HP, "_tween_player_hp", $PlayerBar/HP.region_rect, get_player_rect2d_by_percentage(percent) , 0.5, tween.TRANS_LINEAR, tween.EASE_IN_OUT, 0.0)
	tween.start()

	print("Sliding Player HP to :" + str(percent) + "% or:" + str(final_hp))

	# Create a timer that sets off every 1/30 of a second to change hp lable
	#timer = Timer.new()
	#timer.wait_time = float(1/30)
	#timer.one_shot = false
	#timer.connect("timeout", self, "_update_player_hp_lable")
	#self.add_child(timer)
	#timer.start
	yield(tween,"tween_all_completed")
	$PlayerBar/HP.region_rect = get_player_rect2d_by_percentage(percent)
	$PlayerBar/HPLable.text = str(player_final_hp) + "/ " + str(player_total_hp)
	$PlayerBar/HPLable/HPLableShadow.text = $PlayerBar/HPLable.text

	player_hp_percent = percent
	emit_signal("finished")
func slide_foe_bar(percent: float):
	var tween = $FoeBar/Tween
	tween.interpolate_method($FoeBar/HP, "_tween_foe_hp", $FoeBar/HP.region_rect, get_foe_rect2d_by_percentage(percent) , 0.5, tween.TRANS_LINEAR, tween.EASE_IN_OUT, 0.0)
	tween.start()
	yield(tween,"tween_all_completed")
	$FoeBar/HP.region_rect = get_foe_rect2d_by_percentage(percent)
	foe_hp_percent = percent
	emit_signal("finished")


func _tween_player_hp(pos):
	var rect = $PlayerBar/HP.region_rect
	rect.pos = pos
	$PlayerBar/HP.region_rect = rect
func _tween_foe_hp(pos):
	var rect = $FoeBar/HP.region_rect
	rect.pos = pos
	$FoeBar/HP.region_rect = rect
#func _update_player_hp_lable():  # Should update 15 times  WILL COMPLETE LATER
#	if timer_step == 15:
#		timer.stop()
#		timer.queue_free()
#	else:
#		var hp : int = int()
#		
#		$PlayerBar/HPLable.text = str(hp) + "/ " + str(player_total_hp)
#		$PlayerBar/HPLable/HPLableShadow.text = $PlayerBar/HPLable.text
#		
#		timer_step = timer_step + 1