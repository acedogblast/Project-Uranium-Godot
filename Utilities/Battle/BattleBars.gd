extends Node2D
signal finished
const PLAYER_HP_FULL_POS = Vector2(202, 90)
const PLAYER_HP_EMPTY_POS = Vector2(28, 90)
const PLAYER_EXP_FULL_POS = Vector2(154, 10)
const PLAYER_EXP_EMPTY_POS = Vector2(2, 10)
const FOE_HP_FULL_POS = Vector2(198, 90)
const FOE_HP_EMPTY_POS = Vector2(24, 90)

var foe_hp_percent : float = 1.0
var player_hp_percent : float = 1.0
var player_total_hp : int
var player_final_hp : int
var foe_hp_width : int = 202
var player_hp_width : int = 202
var player_exp_percent : float = 0.0


func set_player_bar_by_pokemon(poke):
	player_total_hp = poke.hp
	player_hp_percent = float(poke.current_hp) / float(player_total_hp)
	player_exp_percent = poke.get_exp_bar_percent()
	player_hp_width = 174 * player_hp_percent + 28
	$PlayerBar/HPLable.text = str(poke.current_hp) + "/ " + str(player_total_hp)
	$PlayerBar/HPLable/HPLableShadow.text = str(poke.current_hp) + "/ " + str(player_total_hp)
	$PlayerBar/NameLable.text = " " + poke.name
	$PlayerBar/LevelLable.text = " " + str(poke.level)
	$PlayerBar/HP.region_rect = get_player_rect2d_by_percentage(player_hp_percent)
	$PlayerBar/EXP.region_rect = get_player_exp_rect2d_by_percentage(player_exp_percent)

	match poke.major_ailment:
		null:
			$PlayerBar/MajorAilment.hide()
		_:
			$PlayerBar/MajorAilment.frame = poke.major_ailment
			$PlayerBar/MajorAilment.show()

func set_foe_bar_by_pokemon(poke):
	foe_hp_percent = float(poke.current_hp) / float(poke.hp)
	foe_hp_width = 202 * foe_hp_percent
	$FoeBar/NameLable.text = " " + poke.name
	$FoeBar/LevelLable.text = " " + str(poke.level)
	$FoeBar/HP.region_rect = get_foe_rect2d_by_percentage(foe_hp_percent)

	match poke.major_ailment:
		null:
			$FoeBar/MajorAilment.hide()
		_:
			$FoeBar/MajorAilment.frame = poke.major_ailment
			$FoeBar/MajorAilment.show()
func get_foe_rect2d_by_percentage(percent: float):
	if percent <= 0.0:
		return Rect2(0,0, int(24), 90)
	return Rect2(0,0, int(174 * percent + 24), 90)
func get_player_rect2d_by_percentage(percent: float):
	if percent <= 0.0:
		return Rect2(0,0, int(28), 90)
	return Rect2(0,0, int(174 * percent + 28), 90)

func get_player_exp_rect2d_by_percentage(percent: float):
	return Rect2(0,0, int(152 * percent) , 10)

func slide_player_bar(percent: float , final_hp : int): #TODO: Figure out how to tween the region rect of a sprite.
	var increasing = false

	if percent > player_hp_percent:
		increasing = true

	print("Sliding Player HP to :" + str(percent) + "% or:" + str(final_hp))
	while $PlayerBar/HP.get_rect() != get_player_rect2d_by_percentage(percent):
		$PlayerBar/HP.region_rect = Rect2(0, 0, player_hp_width, 90)
		if increasing:
			player_hp_width = player_hp_width + 1
		else:
			player_hp_width = player_hp_width - 1
		await get_tree().create_timer(0.01).timeout
	$PlayerBar/HP.region_rect = get_player_rect2d_by_percentage(percent)
	$PlayerBar/HPLable.text = str(final_hp) + "/ " + str(player_total_hp)
	$PlayerBar/HPLable/HPLableShadow.text = $PlayerBar/HPLable.text
	player_final_hp = final_hp
	player_hp_percent = percent
	emit_signal("finished")
func slide_foe_bar(percent: float):
	var increasing = false

	if percent > foe_hp_percent:
		increasing = true

	while $FoeBar/HP.get_rect() != get_foe_rect2d_by_percentage(percent):
		$FoeBar/HP.region_rect = Rect2(0, 0, foe_hp_width, 90)
		if increasing:
			foe_hp_width = foe_hp_width + 1
		else:
			foe_hp_width = foe_hp_width - 1
		await get_tree().create_timer(0.01).timeout
	$FoeBar/HP.region_rect = get_foe_rect2d_by_percentage(percent)
	foe_hp_percent = percent
	emit_signal("finished")
func slide_player_exp_bar(percent: float): # Maximum length is 2 seconds.
	# 60 times max
	var loops = int( (percent - player_exp_percent) * 60.0)
	var current_percent = player_exp_percent
	if loops < 1:
		print("Caught exp bar lock")
		print("recived percent is: " + str(percent))
		print("Current bar is:" + str(player_exp_percent))
		print("Loops is: " + str(loops))

		
		player_exp_percent = percent
		$PlayerBar/EXP.region_rect = get_player_exp_rect2d_by_percentage(player_exp_percent)
		emit_signal("finished")
		return


	var step = 0.01666667

	# Play sound
	$AudioStreamPlayer.stream = load("res://Audio/SE/BW_exp.wav")
	$AudioStreamPlayer.play()

	for i in range(loops):
		$PlayerBar/EXP.region_rect = get_player_exp_rect2d_by_percentage(current_percent)
		current_percent = current_percent + step
		await get_tree().create_timer(0.033).timeout
	$AudioStreamPlayer.stop()
	player_exp_percent = percent
	$PlayerBar/EXP.region_rect = get_player_exp_rect2d_by_percentage(player_exp_percent)
	emit_signal("finished")
func _tween_player_hp(pos):
	var rect = $PlayerBar/HP.region_rect
	rect.pos = pos
	$PlayerBar/HP.region_rect = rect
func _tween_foe_hp(pos):
	var rect = $FoeBar/HP.region_rect
	rect.pos = pos
	$FoeBar/HP.set_region_rect(rect)
func get_color_by_percent(percent : float) -> Color:
	var color = Color(0.0,0.0,0.0)
	var inter : float = 0.0
	if percent > 0.5: # Green to yellow shade
		inter = (percent - 0.5) / 0.5
		color = Color(1.0 - inter, 1.0, 1.0)
	else: # Yellow to red shade
		inter = percent / 0.5
		color = Color(1.0, inter, 0.0)
	return color
func reset_player_exp_bar(): # Sets exp bar to zero
	$PlayerBar/EXP.region_rect = get_player_exp_rect2d_by_percentage(0.0)
	player_exp_percent = 0.0