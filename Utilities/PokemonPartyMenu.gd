extends Node2D
# Slots
enum {S1, S2, S3, S4, S5, S6, CANCEL}
# S1 S2  
# S3 S4
# S5 S6
#    CANCEL
var selection = CANCEL
# Configs
enum {MANAGE, SELECT}
var config = MANAGE
var stage = 0 # 0 = disabled, 1 = menu, 2 = second menu, ...
var size

var multi_line
var switch_line = -1
var switching = false
var swap_select

# Orignal positions of slots
var original_s1 = Vector2(0,0)
var original_s2 = Vector2(256,16)
var original_s3 = Vector2(0,96)
var original_s4 = Vector2(256,112)
var original_s5 = Vector2(0,192)
var original_s6 = Vector2(256,208)

var mode = 0 # 0 = out of battle, 1 = in battle, -2 = special, 2 = use item
var cancel_locked = false
signal close_party


func _ready():
	# Testing setup. Should be disabled when not testing!
	#test_setup()

	# Fill slots with current pokemon
	update_slots()
func setup(battle_mode = false, lock_cancel = false):
	update_slots()
	$Prompt/Prompt.text = tr("UI_PARTY_PROMPT_1")
	$Prompt/Prompt/Shadow.text = tr("UI_PARTY_PROMPT_1")
	$Prompt/NinePatchRect.size = Vector2(396, 64)
	cancel_locked = lock_cancel
	if battle_mode:
		mode = 1
	stage = 1

func _input(event):
	if stage == 1:
		var next_selection = null
		if event.is_action_pressed("ui_down") && (selection != S5 || selection != CANCEL):
			match selection:
				S1:
					next_selection = S3
				S2:
					next_selection = S4
				S3:
					next_selection = S5
				S4:
					next_selection = S6
				S6, S5:
					next_selection = CANCEL
		if event.is_action_pressed("ui_up") && (selection != S1 || selection != S2):
			match selection:
				S3:
					next_selection = S1
				S4:
					next_selection = S2
				S5:
					next_selection = S3
				S6:
					next_selection = S4
				CANCEL:
					next_selection = S6
		if event.is_action_pressed("ui_left") && (selection != S1 || selection != S3 || selection != S5 || selection != CANCEL):
			match selection:
				S2:
					next_selection = S1
				S4:
					next_selection = S3
				S6:
					next_selection = S5
		if event.is_action_pressed("ui_right") && (selection != S2 || selection != S4 || selection != S6 || selection != CANCEL):
			match selection:
				S1:
					next_selection = S2
				S3:
					next_selection = S4
				S5:
					next_selection = S6
			
		if next_selection != null:
			next_selection = check_selection(next_selection)
			change_slot_texture(selection, next_selection)
			# Play select sound
			$AudioStreamPlayer.play()
			selection = next_selection
			next_selection = null
		
		if event.is_action_pressed("ui_accept"):
			match stage:
				1:
					if mode == -2: # Special case for battle
						mode = 1
						$Prompt/Prompt.text = tr("UI_PARTY_PROMPT_1")
						$Prompt/Prompt/Shadow.text = tr("UI_PARTY_PROMPT_1")
						$Prompt/NinePatchRect.size = Vector2(396, 64)
						return

					if switching:
						if selection == swap_select:
							switching = false
							swap_select = null
						else:
							# Swap out animation
							var slot1 = get_slot_by_selection(swap_select)
							var slot2 = get_slot_by_selection(selection)
							$Tween1.interpolate_property(slot1, "position", slot1.position, get_slot_offset_when_swap(swap_select) + slot1.position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
							$Tween2.interpolate_property(slot2, "position", slot2.position, get_slot_offset_when_swap(selection) + slot2.position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
							$Tween1.start()
							$Tween2.start()
							await $Tween2.tween_all_completed

							# logical swap
							var temp = Global.pokemon_group[get_index_by_selection(swap_select)]
							Global.pokemon_group[get_index_by_selection(swap_select)] = Global.pokemon_group[get_index_by_selection(selection)]
							Global.pokemon_group[get_index_by_selection(selection)] = temp
							update_slots()

							# Swap in animation
							$Tween1.interpolate_property(slot1, "position", slot1.position, get_slot_original_pos_by_selection(swap_select), 0.5 ,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
							$Tween2.interpolate_property(slot2, "position", slot2.position, get_slot_original_pos_by_selection(selection), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
							$Tween1.start()
							$Tween2.start()
							await $Tween2.tween_all_completed

							switching = false
							swap_select = null
							change_slot_texture(swap_select, null)
							change_slot_texture(null, selection)
						return
					match selection:
						CANCEL:
							if switching:
								stage = 1
								switching = false
								update_slots()
							else:
								if cancel_locked:
									stage = 1
									return
								stage = 0
								selection = CANCEL
								emit_signal("close_party")
						S1,S2,S3,S4,S5,S6: 
							if mode == 2:
								stage = 0
								emit_signal("close_party")
								return
							stage = 2
							$Prompt/NinePatchRect.size = Vector2(360, 64)
							multi_line = load("res://Utilities/UI/MultilinePrompt.tscn").instantiate()
							add_child(multi_line)
							var text_lines

							if mode == 1: # In battle
								text_lines = tr("UI_PARTY_SWITCH_IN") + ","
								text_lines += tr("UI_PARTY_SUMMARY") + ","
							else:
								text_lines = tr("UI_PARTY_SUMMARY") + ","
								if Global.pokemon_group.size() != 1:
									text_lines += tr("UI_PARTY_SWITCH") + ","
									switch_line = 1
								text_lines += tr("UI_PARTY_ITEM") + ","
							text_lines += tr("UI_PARTY_CANCLE")

							multi_line.setup_BLC(text_lines, null, Vector2(360,384))
							multi_line.set_width(152)
							
							var name
							match selection:
								S1:
									name = Global.pokemon_group[0].name
								S2:
									name = Global.pokemon_group[1].name
								S3:
									name = Global.pokemon_group[2].name
								S4:
									name = Global.pokemon_group[3].name
								S5:
									name = Global.pokemon_group[4].name
								S6:
									name = Global.pokemon_group[5].name
							$Prompt/Prompt.text = tr("UI_PARTY_PROMPT_2") + name
							$Prompt/Prompt/Shadow.text = tr("UI_PARTY_PROMPT_2") + name
							multi_line.connect("selected",Callable(self,"get_multiline_result"))
			pass
	if event.is_action_pressed("x"):
		match stage:
			1:
				if cancel_locked:
					return

				selection = CANCEL
				stage = 0
				emit_signal("close_party")
			2:
				multi_line.queue_free()
				stage = 1
		pass
	
func update_slots():
	#print("Updating slots.")
	#print("Size of pokemon group:" + str(Global.pokemon_group.size()))
	size = Global.pokemon_group.size()
	for i in range(1, 7):
		if i == 1: # First slot use round slot texture
			$Slot1/TextureRect.texture = load("res://Graphics/Pictures/partyPanelRound.png")
		elif i <= Global.pokemon_group.size():
			get_node("Slot" + str(i) + "/TextureRect").texture = load("res://Graphics/Pictures/partyPanelRect.png")
		else : # Use rect slot texture
			get_node("Slot" + str(i) + "/TextureRect").texture = load("res://Graphics/Pictures/partyPanelBlank.png")
			get_node("Slot" + str(i) + "/Content").visible = false
	pass
	
	# Fill slots
	var index = 1
	for poke in Global.pokemon_group:
		var slot_content = get_node("Slot" + str(index) + "/Content")
		slot_content.visible = true

		var name_label = slot_content.get_node("Name")
		change_label_text(name_label, poke.name)

		var level_label = slot_content.get_node("Level")
		change_label_text(level_label, "Lv." + str(poke.level))
		
		var hp_label = slot_content.get_node("HP")
		change_label_text(hp_label, str(poke.current_hp) + "/ " + str(poke.hp))
		
		var gender_label = slot_content.get_node("Gender")
		if poke.gender == poke.MALE:
			change_label_text(gender_label , "♂")
			gender_label.add_theme_color_override("font_color" , Color("0070f8"))
			gender_label.get_node("Shadow").add_theme_color_override("font_color" , Color("78b8e8"))
		if poke.gender == poke.FEMALE:
			change_label_text(gender_label , "♀")
			gender_label.add_theme_color_override("font_color" , Color("e82010"))
			gender_label.get_node("Shadow").add_theme_color_override("font_color" , Color("f8a8b8"))

		var icon_texture = slot_content.get_node("Poke")
		icon_texture.texture = poke.get_icon_texture()

		var hp_bar = slot_content.get_node("HP_Bar/ColorRect")
		set_hp_bar_by_percent(hp_bar, float(poke.current_hp) / float(poke.hp))

		# If hp is zero change background to faint
		if poke.current_hp == 0:
			if index == 1:
				slot_content.get_parent().get_node("TextureRect").texture = load("res://Graphics/Pictures/partyPanelRoundFnt.png")
			else:
				slot_content.get_parent().get_node("TextureRect").texture = load("res://Graphics/Pictures/partyPanelRectFnt.png")
			pass
		index += 1

func test_setup():
	print("Test setup! Adding/Modifining pokemon!")
	var poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(3,5)
	poke.current_hp = 0
	Global.pokemon_group.append(poke)
	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	Global.pokemon_group.append(poke)
	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	Global.pokemon_group.append(poke)
	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	Global.pokemon_group.append(poke)
	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	Global.pokemon_group.append(poke)
	stage = 1
func change_label_text(label : Label, text : String):
	label.text = text
	label.get_node("Shadow").text = text
func set_hp_bar_by_percent(color_rect : ColorRect, percent : float):
	color_rect.size = Vector2(96 * percent , 4)
	var color_of_hp
	if percent > 0.5:
		color_of_hp = Color( 0, 1, 0, 1) # Green
	elif percent <= 0.5 && percent > 0.2:
		color_of_hp = Color( 1, 1, 0, 1) # Yellow
	else:
		color_of_hp = Color( 1, 0, 0, 1) # Red
	color_rect.color = color_of_hp
func change_slot_texture(current, next):
	# Change current selected slot to normal texture
	var panel_round = load("res://Graphics/Pictures/partyPanelRound.png")
	var panel_round_fnt = load("res://Graphics/Pictures/partyPanelRoundFnt.png")
	var panel_round_sel = load("res://Graphics/Pictures/partyPanelRoundSel.png")
	var panel_round_sel_fnt = load("res://Graphics/Pictures/partyPanelRoundSelFnt.png")
	var panel_rect = load("res://Graphics/Pictures/partyPanelRect.png")
	var panel_rect_fnt = load("res://Graphics/Pictures/partyPanelRectFnt.png")
	var panel_rect_sel = load("res://Graphics/Pictures/partyPanelRectSel.png")
	var panel_rect_sel_fnt = load("res://Graphics/Pictures/partyPanelRectSelFnt.png")
	var panel_cancel = load("res://Graphics/Pictures/partyCancel.png")
	var panel_cancel_sel = load("res://Graphics/Pictures/partyCancelSel.png")

	var panel_round_swap = load("res://Graphics/Pictures/partyPanelRoundSwap.png")
	var panel_round_sel_swap = load("res://Graphics/Pictures/partyPanelRoundSelSwap.png")
	var panel_rect_swap = load("res://Graphics/Pictures/partyPanelRectSwap.png")
	var panel_rect_sel_swap = load("res://Graphics/Pictures/partyPanelRectSelSwap.png")

	match current:
		S1:
			if Global.pokemon_group[0].current_hp != 0:
				$Slot1/TextureRect.texture = panel_round
			else:
				$Slot1/TextureRect.texture = panel_round_fnt
			if swap_select == S1:
				$Slot1/TextureRect.texture = panel_round_swap
		S2:
			if Global.pokemon_group[1].current_hp != 0:
				$Slot2/TextureRect.texture = panel_rect
			else:
				$Slot2/TextureRect.texture = panel_rect_fnt
			if swap_select == S2:
				$Slot2/TextureRect.texture = panel_rect_swap
		S3:
			if Global.pokemon_group[2].current_hp != 0:
				$Slot3/TextureRect.texture = panel_rect
			else:
				$Slot3/TextureRect.texture = panel_rect_fnt
			if swap_select == S3:
				$Slot3/TextureRect.texture = panel_rect_swap
		S4:
			if Global.pokemon_group[3].current_hp != 0:
				$Slot4/TextureRect.texture = panel_rect
			else:
				$Slot4/TextureRect.texture = panel_rect_fnt
			if swap_select == S4:
				$Slot4/TextureRect.texture = panel_rect_swap
		S5:
			if Global.pokemon_group[4].current_hp != 0:
				$Slot5/TextureRect.texture = panel_rect
			else:
				$Slot5/TextureRect.texture = panel_rect_fnt
			if swap_select == S5:
				$Slot5/TextureRect.texture = panel_rect_swap
		S6:
			if Global.pokemon_group[5].current_hp != 0:
				$Slot6/TextureRect.texture = panel_rect
			else:
				$Slot6/TextureRect.texture = panel_rect_fnt
			if swap_select == S6:
				$Slot6/TextureRect.texture = panel_rect_swap
		CANCEL:
			$Cancel/TextureRect.texture = panel_cancel

	# Change next slot to selected texture
	match next:
		S1:
			if Global.pokemon_group[0].current_hp != 0:
				$Slot1/TextureRect.texture = panel_round_sel
			else:
				$Slot1/TextureRect.texture = panel_round_sel_fnt
			if switching:
				$Slot1/TextureRect.texture = panel_round_sel_swap
		S2:
			if Global.pokemon_group[1].current_hp != 0:
				$Slot2/TextureRect.texture = panel_rect_sel
			else:
				$Slot2/TextureRect.texture = panel_rect_sel_fnt
			if switching:
				$Slot2/TextureRect.texture = panel_rect_sel_swap
		S3:
			if Global.pokemon_group[2].current_hp != 0:
				$Slot3/TextureRect.texture = panel_rect_sel
			else:
				$Slot3/TextureRect.texture = panel_rect_sel_fnt
			if switching:
				$Slot3/TextureRect.texture = panel_rect_sel_swap
		S4:
			if Global.pokemon_group[3].current_hp != 0:
				$Slot4/TextureRect.texture = panel_rect_sel
			else:
				$Slot4/TextureRect.texture = panel_rect_sel_fnt
			if switching:
				$Slot4/TextureRect.texture = panel_rect_sel_swap
		S5:
			if Global.pokemon_group[4].current_hp != 0:
				$Slot5/TextureRect.texture = panel_rect_sel
			else:
				$Slot5/TextureRect.texture = panel_rect_sel_fnt
			if switching:
				$Slot5/TextureRect.texture = panel_rect_sel_swap
		S6:
			if Global.pokemon_group[5].current_hp != 0:
				$Slot6/TextureRect.texture = panel_rect_sel
			else:
				$Slot6/TextureRect.texture = panel_rect_sel_fnt
			if switching:
				$Slot6/TextureRect.texture = panel_rect_sel_swap
		CANCEL:
			$Cancel/TextureRect.texture = panel_cancel_sel
func check_selection(next_slot):
	if selection == CANCEL:
		match next_slot:
			S2:
				if size < 2:
					return S1
			S3:
				if size < 3:
					return check_selection(S2)
			S4:
				if size < 4:
					return check_selection(S3)
			S5:
				if size < 5:
					return check_selection(S4)
			S6:
				if size < 6:
					return check_selection(S5)
	else:
		match next_slot:
			S2:
				if size < 2:
					return CANCEL
			S3:
				if size < 3:
					return CANCEL
			S4:
				if size < 4:
					return CANCEL
			S5:
				if size < 5:
					return CANCEL
			S6:
				if size < 6:
					return CANCEL
				
	return next_slot
func get_multiline_result():
	var result = multi_line.selected_line
	if result == multi_line.lines - 1: # Cancel
		stage = 1
		return

	if mode == 1: # In battle
		match result:
			0:  # Switch out
				# Check if selection is already in battle
				multi_line.queue_free()
				var battle_node = self.get_parent().get_parent().get_parent()
				if battle_node.check_if_battler_is_already_out(Global.pokemon_group[selection]):
					$Prompt/NinePatchRect.size = Vector2(512, 64)
					$Prompt/Prompt.text = Global.pokemon_group[selection].name + tr("UI_PARTY_ALREADY_IN_BATTLE")
					$Prompt/Prompt/Shadow.text = Global.pokemon_group[selection].name + tr("UI_PARTY_ALREADY_IN_BATTLE")
					mode = -2 # Special mode
					stage = 1
					return
				emit_signal("close_party")
				return
			1: # Summary
				pass




		pass
	else:
		multi_line.queue_free()
		if switch_line == result:
			stage = 1
			switch_poke_order()
			return
		
		# TODO: Remove this when done
		stage = 1
		return
		
		stage = 3
		# Open next menus
		if result == 0: # TODO: Open Summary
			pass


	
	pass
func switch_poke_order():
	switching = true
	swap_select = selection
	change_slot_texture(null, swap_select)
	pass
func get_index_by_selection(sel):
	match sel:
		S1:
			return 0
		S2:
			return 1
		S3:
			return 2
		S4:
			return 3
		S5:
			return 4
		S6:
			return 5
func get_slot_by_selection(sel):
	match sel:
		S1:
			return $Slot1
		S2:
			return $Slot2
		S3:
			return $Slot3
		S4:
			return $Slot4
		S5:
			return $Slot5
		S6:
			return $Slot6
func get_slot_offset_when_swap(sel):
	match sel:
		S1,S3,S5:
			return Vector2(-300, 0)
		S2,S4,S6:
			return Vector2(300, 0)
func get_slot_original_pos_by_selection(sel):
	match sel:
		S1:
			return original_s1
		S2:
			return original_s2
		S3:
			return original_s3
		S4:
			return original_s4
		S5:
			return original_s5
		S6:
			return original_s6
func set_prompt(message : String):
	$Prompt/Prompt.text = message
	$Prompt/Prompt/Shadow.text = message
