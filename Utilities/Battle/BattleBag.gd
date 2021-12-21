extends Node2D

var enabled = false
var stage = 1
signal command_received

enum {MEDICINE = 1, 
	POKEBALLS = 2, 
	BERRIES = 4, 
	BATTLE_ITEMS = 5, 
	LAST_ITEM,
	BACK,
	S1,
	S2,
	S3,
	S4,
	S5,
	S6,
	USE}
var selection = MEDICINE
var item_stacks
var page_count : int = 1
var current_page : int = 1
var last_item
var num_of_items

func start():
	enabled = true
	stage = 1
	selection = BACK
	self.visible = true
	# Slide
	$AnimationPlayer.play("SlideBag")

func _input(event):
	if enabled:
		if event.is_action_pressed("x"):
			match stage:
				1:
					enabled = false
					$Selection.visible = false
					# Close menu and go back
					$AnimationPlayer.play_backwards("SlideBag")
					yield($AnimationPlayer, "animation_finished")
					self.visible = false
					print("BattleBagHidden!")
					self.get_parent().get_node("BattleComandSelect").enabled = true
					self.get_parent().get_node("BattleComandSelect").visible = true
					self.get_parent().get_node("BattleComandSelect").change_Sel_Hand_Pos(true)
				2:
					$BagMenu/Tween.interpolate_property($BagMenu/Pages, "position", $BagMenu/Pages.position, Vector2(512,0), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
					$BagMenu/Tween.start()
					$AnimationPlayer.play_backwards("SlideToMenu")
					stage = 1
					selection = MEDICINE
					update_selection()
				3:
					$BagMenu/Pages.visible = true
					$BagMenu/Item.visible = false
					stage = 2
					update_selection()
			return
		if event.is_action_pressed("ui_down"):
			match stage:
				1:
					match selection:
						MEDICINE:
							selection = BERRIES
						POKEBALLS:
							selection = BATTLE_ITEMS
						BERRIES:
							if last_item == null:
								selection = BACK
							else:
								selection = LAST_ITEM
						BATTLE_ITEMS:
							selection = BACK
				2:
					select_down()
				3:
					selection = BACK
			update_selection()
		if event.is_action_pressed("ui_up"):
			match stage:
				1:
					match selection:
						BERRIES:
							selection = MEDICINE
						BATTLE_ITEMS:
							selection = POKEBALLS
						BACK:
							selection = BATTLE_ITEMS
						LAST_ITEM:
							selection = BERRIES
				2:
					select_up()
				3:
					selection = USE
			update_selection()
		if event.is_action_pressed("ui_left"):
			match stage:
				1:
					match selection:
						POKEBALLS:
							selection = MEDICINE
						BATTLE_ITEMS:
							selection = BERRIES
						BACK:
							if last_item == null:
								selection = BERRIES
							else:
								selection = LAST_ITEM
				2:
					select_left()
			update_selection()
		if event.is_action_pressed("ui_right"):
			match stage:
				1:
					match selection:
						MEDICINE:
							selection = POKEBALLS
						BERRIES:
							selection = BATTLE_ITEMS
						LAST_ITEM:
							selection = BACK
				2:
					select_right()
			update_selection()
		
		if event.is_action_pressed("ui_accept"):
			match stage:
				1:
					$Selection.visible = false
					match selection:
						MEDICINE,POKEBALLS,BERRIES,BATTLE_ITEMS:
							stage = 2
							if get_item_stacks(selection).size() == 0:
								get_parent().get_node("Message").get_node("Label").text = "You have no usable items in this pocket."
								get_parent().get_node("Message").visible = true
								yield(get_tree().create_timer(1.0), "timeout")
								get_parent().get_node("Message").visible = false
								stage = 1
								return
							$AudioStreamPlayer.stream = load("res://Audio/SE/SE_Select1.wav")
							$AudioStreamPlayer.play()
							$AnimationPlayer.play("SlideToMenu")
							yield($AnimationPlayer, "animation_finished")
							$BagMenu.visible = true
							generate_pages(selection)
							$BagMenu/Pages.visible = true
							$BagMenu/AnimationPlayer.play("Slide")
							$BagMenu/Tween.interpolate_property($BagMenu/Pages, "position", Vector2(512,0), Vector2(0,0), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
							$BagMenu/Tween.start()
							selection = S1
						LAST_ITEM:
							pass
						BACK:
							stage = 1
							$Bottom/Last/Select.visible = false
							enabled = false
							# Close menu and go back
							$AnimationPlayer.play_backwards("SlideBag")
							yield($AnimationPlayer, "animation_finished")
							self.visible = false
							print("BACK")
							self.get_parent().get_node("BattleComandSelect").enabled = true
							self.get_parent().get_node("BattleComandSelect").visible = true
				2:
					match selection:
						BACK:
							$BagMenu/Tween.interpolate_property($BagMenu/Pages, "position", $BagMenu/Pages.position, Vector2(512,0), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
							$BagMenu/Tween.start()
							$AnimationPlayer.play_backwards("SlideToMenu")
							stage = 1
							selection = MEDICINE
							update_selection()
						_:
							stage = 3
							update_selection()
							$BagMenu/Pages.visible = false
							$Selection.visible = false
							fill_icon_node(get_item_stack())
							$BagMenu/Item.visible = true
							selection = USE
				3:
					if selection == USE:
						stage = 4
						enabled = false
						var command = BattleCommand.new()
						command.command_type = command.USE_BAG_ITEM
						command.item = get_item_stack().get_item_id()
					
						# If item is ball set target to foe.
						if get_item_stack().is_ball():
							command.attack_target = 2 # For single battles!

						if get_item_stack().is_potion():
							var ani = self.get_parent().get_parent().get_node("ColorRect/AnimationPlayer")
							var party = self.get_parent().get_node("PokemonPartyMenu")
							ani.play("FadeIn")
							yield(ani, "animation_finished")
							self.hide()
							party.setup(true)
							party.set_prompt(tr("UI_PARTY_USE_ON_WHICH_POKE"))
							party.mode = 2
							party.show()
							yield(party, "close_party")

							if party.selection == party.CANCEL:
								ani.play("FadeIn")
								yield(ani, "animation_finished")
								party.hide()
								$BagMenu/Pages.visible = true
								$BagMenu/Item.visible = false
								self.show()
								ani.play("FadeOut")
								yield(ani, "animation_finished")
								stage = 2
								enabled = true
								update_selection()
								return
							else:
								command.attack_target = party.selection # index of pokemon_group array!
								ani.play("FadeIn")
								yield(ani, "animation_finished")
								party.hide()
								ani.play("FadeOut")
								yield(ani, "animation_finished")
						
						Global.inventory.remove_item(Global.inventory.get_item_by_id(command.item))
						$AudioStreamPlayer.stream = load("res://Audio/SE/SE_Select1.wav")
						$AudioStreamPlayer.play()
						enabled = false
						emit_signal("command_received", command)
						$BagMenu/Item.visible = false
						self.visible = false
						print("No visible 237")
						stage = 4
					else:
						$BagMenu/Pages.visible = true
						$BagMenu/Item.visible = false
						stage = 2
						update_selection()

func update_selection():
	match stage:
		1:
			$Selection.visible = true
			$Bottom/Back/Select.visible = false
			$Bottom/Last/Select.visible = false
			match selection:
				MEDICINE:
					$Selection.position = Vector2(132,78)
				POKEBALLS:
					$Selection.position = Vector2(385,125)
				BERRIES:
					$Selection.position = Vector2(132,205)
				BATTLE_ITEMS:
					$Selection.position = Vector2(385, 250)
				LAST_ITEM:
					$Selection.visible = false
					$Bottom/Last/Select.visible = true
				BACK:
					$Selection.visible = false
					$Bottom/Back/Select.visible = true
		2:
			$Bottom/Back/Select.visible = false
			$Selection.visible = true
			match selection:
				S1:
					$Selection.position = get_position_by_slot_index(0) + $BagMenu/Pages.position
				S2:
					$Selection.position = get_position_by_slot_index(1) + $BagMenu/Pages.position
				S3:
					$Selection.position = get_position_by_slot_index(2) + $BagMenu/Pages.position
				S4:
					$Selection.position = get_position_by_slot_index(3) + $BagMenu/Pages.position
				S5:
					$Selection.position = get_position_by_slot_index(4) + $BagMenu/Pages.position
				S6:
					$Selection.position = get_position_by_slot_index(5) + $BagMenu/Pages.position
				BACK:
					$Selection.visible = false
					$Bottom/Back/Select.visible = true
		3:
			match selection:
				USE:
					$BagMenu/Item/Select.position = Vector2(256, 160)
					$BagMenu/Item/Select.frame = 2
				BACK:
					$BagMenu/Item/Select.position = Vector2(256, 316)
					$BagMenu/Item/Select.frame = 3

			pass
	$AudioStreamPlayer.stream = load("res://Audio/SE/SE_Select1.wav")
	$AudioStreamPlayer.play()

func generate_pages(pocket):
	clear_pages()
	item_stacks = get_item_stacks(pocket)
	num_of_items = item_stacks.size()
	var pages = $BagMenu/Pages
	page_count = (num_of_items / 6) + 1
	$BagMenu/Pocket/Pages.text = "1/ " + str(page_count)

	match pocket:
		MEDICINE:
			$BagMenu/Pocket/Label.text = "Medicine"
		POKEBALLS:
			$BagMenu/Pocket/Label.text = "Poké Balls"
		BERRIES:
			$BagMenu/Pocket/Label.text = "Berries"
		BATTLE_ITEMS:
			$BagMenu/Pocket/Label.text = "Battle Items"


	var slot_index = 0
	for item_stack in item_stacks:
		var sprite = Sprite.new()
		sprite.texture = load("res://Graphics/Pictures/BATTLE/battleBagChoices.png")
		sprite.hframes = 6
		sprite.frame = 5
		sprite.position = get_position_by_slot_index(slot_index)
		var label = Label.new()
		label.add_font_override("font", load("res://Utilities/Battle/MoveTextFont.tres"))
		label.text = item_stack.get_name()
		label.rect_size = Vector2(160, 35)
		label.rect_position = Vector2(-80,-33)
		label.align = label.ALIGN_CENTER
		sprite.add_child(label)
		
		label = Label.new()
		label.add_font_override("font", load("res://Utilities/Battle/MoveTextFont.tres"))
		label.text = "x" + str(item_stack.get_item_quantity())
		label.rect_size = Vector2(160, 35)
		label.rect_position = Vector2(-80,5)
		label.align = label.ALIGN_CENTER
		sprite.add_child(label)

		var icon = Sprite.new()
		icon.texture = item_stack.get_item_icon()
		icon.position = Vector2(72, 10)
		sprite.add_child(icon)

		slot_index += 1
		pages.add_child(sprite)
func get_item_stacks(pocket):
	match pocket:
		MEDICINE:
			return Global.inventory.medicine
		POKEBALLS:
			return Global.inventory.balls
		BERRIES:
			return Global.inventory.berries
		BATTLE_ITEMS:
			return Global.inventory.battle_items
func clear_pages():
	for child in $BagMenu/Pages.get_children():
		$BagMenu/Pages.remove_child(child)
		child.queue_free()
func get_position_by_slot_index(slot_index : int) -> Vector2:
	var page = (slot_index / 6)
	var pos = slot_index - page * 6
	var final_pos = Vector2.ZERO
	final_pos += Vector2(512,0) * page
	match pos:
		0:
			final_pos += Vector2(135,72)
		1:
			final_pos += Vector2(362,72)
		2:
			final_pos += Vector2(135,165)
		3:
			final_pos += Vector2(362,165)
		4:
			final_pos += Vector2(135,258)
		5:
			final_pos += Vector2(362,258)
	return final_pos
func select_down():
	var index = 0 * current_page # Index of next selection
	match selection:
		S1:
			if num_of_items > index + 2:
				selection = S3
			else:
				selection = BACK
		S2:
			if num_of_items > index + 3:
				selection = S4
			else:
				selection = BACK
		S3:
			if num_of_items > index + 4:
				selection = S4
			else:
				selection = BACK
		S4:
			if num_of_items > index + 5:
				selection = S4
			else:
				selection = BACK
		S5, S6, USE:
			selection = BACK
func select_up():
	match selection:
		S3:
			selection = S1
		S4:
			selection = S2
		S5:
			selection = S3
		S6:
			selection = S4
		BACK:
			selection = S1
func select_left():
	match selection:
		S2:
			selection = S1
		S4:
			selection = S3
		S6:
			selection = S5
		_:
			# Change page
			if current_page > 1:
				left_page(selection)
func select_right():
	var index = 0 * current_page # Index of next selection
	match selection:
		S1:
			if num_of_items > index + 1:
				selection = S2
			else:
				selection = BACK
		S3:
			if num_of_items > index + 3:
				selection = S4
			else:
				selection = BACK
		S5:
			if num_of_items > index + 5:
				selection = S6
			else:
				selection = BACK
		_:
			if current_page < page_count:
				right_page(selection)
func left_page(select):
	match select:
		S1:
			selection = S2
		S3:
			selection = S4
		S5:
			selection = S6
	current_page -= 1
	$BagMenu/Pocket/Pages.text = str(current_page) + "/ " + str(page_count)
	$BagMenu/Tween.interpolate_property($BagMenu/Pages, "position", $BagMenu/Pages.position, $BagMenu/Pages.position + Vector2(512,0), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	$BagMenu/Tween.start()
	yield($BagMenu/Tween, "tween_completed")
func right_page(select):
	current_page += 1
	var index = 0 * current_page # Index of next selection
	match select:
		S2:
			selection = S1
		S4:
			if num_of_items > index + 2:
				selection = S3
			else:
				selection = S1
		S6:
			if num_of_items > index + 5:
				selection = S6
			else:
				selection = S1
	$BagMenu/Pocket/Pages.text = str(current_page) + "/ " + str(page_count)
	$BagMenu/Tween.interpolate_property($BagMenu/Pages, "position", $BagMenu/Pages.position, $BagMenu/Pages.position + Vector2(-512,0), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	$BagMenu/Tween.start()
	yield($BagMenu/Tween, "tween_completed")
func fill_icon_node(item: ItemStack):
	$BagMenu/Item/Use/Icon.texture = item.get_item_icon()
	$BagMenu/Item/Use/Label.text = item.get_description()
func get_item_stack():
	var index = 6 * (current_page - 1)
	match selection:
		S2:
			index += 1
		S3:
			index += 2
		S4:
			index += 3
		S5:
			index += 4
		S6:
			index += 5
	return item_stacks[index]
