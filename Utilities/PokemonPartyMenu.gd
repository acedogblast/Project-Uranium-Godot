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
var mode = 0 # 0 = disabled, 1 = menu, 2 = second menu, ...
var size

signal close_party


func _ready():
	# Testing setup. Should be disabled when not testing!
	#test_setup()

	# Fill slots with current pokemon
	update_slots()
func setup():
	update_slots()
func _input(event):
	if mode == 1:
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
			#print("ui_accept")
			match selection:
				CANCEL:
					#print("CANCEL")
					mode = 0
					emit_signal("close_party")
			pass
		if event.is_action_pressed("x"):
			emit_signal("close_party")
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
			gender_label.add_color_override("font_color" , Color("0070f8"))
			gender_label.get_node("Shadow").add_color_override("font_color" , Color("78b8e8"))
		if poke.gender == poke.FEMALE:
			change_label_text(gender_label , "♀")
			gender_label.add_color_override("font_color" , Color("e82010"))
			gender_label.get_node("Shadow").add_color_override("font_color" , Color("f8a8b8"))

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
	mode = 1
func change_label_text(label : Label, text : String):
	label.text = text
	label.get_node("Shadow").text = text
func set_hp_bar_by_percent(color_rect : ColorRect, percent : float):
	color_rect.rect_size = Vector2(96 * percent , 4)
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
	match current:
		S1:
			if Global.pokemon_group[0].current_hp != 0:
				$Slot1/TextureRect.texture = panel_round
			else:
				$Slot1/TextureRect.texture = panel_round_fnt
		S2:
			if Global.pokemon_group[1].current_hp != 0:
				$Slot2/TextureRect.texture = panel_rect
			else:
				$Slot2/TextureRect.texture = panel_rect_fnt
		S3:
			if Global.pokemon_group[2].current_hp != 0:
				$Slot3/TextureRect.texture = panel_rect
			else:
				$Slot3/TextureRect.texture = panel_rect_fnt
		S4:
			if Global.pokemon_group[3].current_hp != 0:
				$Slot4/TextureRect.texture = panel_rect
			else:
				$Slot4/TextureRect.texture = panel_rect_fnt
		S5:
			if Global.pokemon_group[4].current_hp != 0:
				$Slot5/TextureRect.texture = panel_rect
			else:
				$Slot5/TextureRect.texture = panel_rect_fnt
		S6:
			if Global.pokemon_group[5].current_hp != 0:
				$Slot6/TextureRect.texture = panel_rect
			else:
				$Slot6/TextureRect.texture = panel_rect_fnt
		CANCEL:
			$Cancel/TextureRect.texture = panel_cancel

	# Change next slot to selected texture
	match next:
		S1:
			if Global.pokemon_group[0].current_hp != 0:
				$Slot1/TextureRect.texture = panel_round_sel
			else:
				$Slot1/TextureRect.texture = panel_round_sel_fnt
		S2:
			if Global.pokemon_group[1].current_hp != 0:
				$Slot2/TextureRect.texture = panel_rect_sel
			else:
				$Slot2/TextureRect.texture = panel_rect_sel_fnt
		S3:
			if Global.pokemon_group[2].current_hp != 0:
				$Slot3/TextureRect.texture = panel_rect_sel
			else:
				$Slot3/TextureRect.texture = panel_rect_sel_fnt
		S4:
			if Global.pokemon_group[3].current_hp != 0:
				$Slot4/TextureRect.texture = panel_rect_sel
			else:
				$Slot4/TextureRect.texture = panel_rect_sel_fnt
		S5:
			if Global.pokemon_group[4].current_hp != 0:
				$Slot5/TextureRect.texture = panel_rect_sel
			else:
				$Slot5/TextureRect.texture = panel_rect_sel_fnt
		S6:
			if Global.pokemon_group[5].current_hp != 0:
				$Slot6/TextureRect.texture = panel_rect_sel
			else:
				$Slot6/TextureRect.texture = panel_rect_sel_fnt
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
