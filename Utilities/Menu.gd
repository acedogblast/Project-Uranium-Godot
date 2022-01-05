tool
extends Node2D

var current

var menu_stage = 0 # 0 = closed, 1 = first memu, 2 = second, ...

var offscreen_left = 556
var offscreen_right = -44
var init_pos
var saving = false
var locked = false

var move_offset
var menu_toggle = false

enum ORDER {
	PARTY,
	BAG,
	POKEPOD,
	CARD,
	SAVE,
	OPTION,
	EXIT,
	POKEDEX
}

func _ready():
	if(Engine.editor_hint):
		# Special things when this is on editor mode
		$AnimationPlayer.seek($AnimationPlayer.current_animation_length)
	
	$Bag.connect("close_bag", self, "close_bag")
	$PokemonPartyMenu.connect("close_party", self, "close_party")
	$Pokedex.connect("close", self, "close_dex")
	$Card.connect("close", self, "close_card")
	
	current = ORDER.PARTY
	init_pos = $Option_Text.rect_position
	$Bag.enabled = false
	
	$Save_Menu/Info/Player_Name/Name.bbcode_text = "[right][color=#0070f8]" + Global.TrainerName + "[/color][/right]"

func _input(event):
	if event.is_action_pressed("x") && !locked:
		match menu_stage:
			0:
				Global.game.player.call_deferred("change_input", true)
				self.visible = true
				menu_stage = 1
				print("Toggling")
				$AnimationPlayer.play("Open Menu")
				$Place_Text.bbcode_text = "[center]" + Global.game.current_scene.place_name + "[/center]"
			1:
				Global.game.player.call_deferred("change_input", false)
				menu_stage = 0
				print("Untoggling")
				$AnimationPlayer.current_animation = "Open Menu"
				$AnimationPlayer.seek(0, true)
				$AnimationPlayer.stop(true)
				self.visible = false
				
	if menu_stage == 1:
		
		if event.is_action_pressed("ui_left") and !saving:
			move_sprites("Left")
		if event.is_action_pressed("ui_right") and !saving:
			move_sprites("Right")
		if event.is_action_pressed("z") and !saving:
			Global.sprint = !Global.sprint
			if $Run/Sprite.frame == 0:
				$Run/Sprite.frame = 1
			else:
				$Run/Sprite.frame = 0
		if event.is_action_pressed("ui_accept"):
			select()
			return null # This breaks out of the current method. Needed after select()
	
	if menu_stage == 2:
		match current:
			ORDER.SAVE:
				if event.is_action_pressed("ui_down"):
					if $Yes_no/Box/Cursor.position.y == 32:
						$Yes_no/Box/Cursor.position.y = 64
				elif event.is_action_pressed("ui_up"):
					if $Yes_no/Box/Cursor.position.y == 64:
						$Yes_no/Box/Cursor.position.y -= 32
				if event.is_action_pressed("ui_accept"):
					if $Yes_no/Box/Cursor.position.y == 32:
						print("Saved")
						SaveSystem.save_game(1)
						# Play save sound effect
						$Sounds/Save.play()
					else:
						$Yes_no/Box/Cursor.position.y = 32
					$Save_Menu.visible = false
					$Yes_no.visible = false
					DialogueSystem.reset()
					menu_stage = 1
				
func party_logic():
	print("party logic")
	$Transition.fade_to_color()
	yield($Transition, "finished")
	hide_all()
	$PokemonPartyMenu.setup()
	$PokemonPartyMenu.show()
	$Transition.fade_from_color()
	yield($Transition, "finished")
	$Transition.visible = false


func bag_setup():
	$Transition.visible = true
	$Transition.fade_to_color()
	yield($Transition, "finished")
	hide_all()
	$Bag.setup()
	$Bag.show()
	$Transition.fade_from_color()
	yield($Transition, "finished")
	$Transition.visible = false


func show_base():
	hide_all()
	$BG.show()
	$Bottom.show()
	$Top.show()
	$Place_Text.show()
	$Option_Text.show()
	$Options.show()
	$Run.show()

func hide_all():
	for c in get_children():
		if c is AnimationPlayer or c is Node or c.name == "Transition":
			continue
		else:
			c.hide()
	pass


func select(): # Stage should be 1
	menu_stage = 2
	if current == ORDER.SAVE:
		setup_save_boxes()
		$Save_Menu.visible = true
		$Yes_no.visible = true
		DialogueSystem.start_dialog("UI_MENU_SAVE_PROMPT")
	elif current == ORDER.BAG:
		$Bag.enabled = true
		bag_setup()
	elif current == ORDER.PARTY:
		# Check if we have any pokes
		if Global.pokemon_group.size() == 0:
			menu_stage = 1
			return
		$PokemonPartyMenu.stage = 1
		party_logic()
	elif current == ORDER.POKEDEX:
		if Global.past_events.has("EVENT_MOKI_TOWN_DEMO"):
			$Transition.fade_to_color()
			yield($Transition, "finished")
			hide_all()
			$Pokedex.start()
			$Pokedex.show()
			$Transition.fade_from_color()
			yield($Transition, "finished")
			$Transition.visible = false
		else:
			menu_stage = 1
	elif current == ORDER.CARD:
		$Transition.fade_to_color()
		yield($Transition, "finished")
		hide_all()
		$Card.setup()
		$Card.show()
		$Transition.fade_from_color()
		yield($Transition, "finished")
		$Transition.visible = false
	else:
		menu_stage = 1
	

func move_sprites(dir):
	if dir == "Left":
		current -= 1
		
		if current == -1:
			current = 7
		
	else:
		current += 1
		
		if current == 8:
			current = 0

	$Option_Text.bbcode_text = "[center]"
	
	if current == ORDER.PARTY:
		#$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text += "POKÉMON"
		
		grey_frame()
		$"Options/PARTY/Pokémon".frame = 1
	elif current == ORDER.BAG:
		#$Option_Text.rect_position.x = init_pos.x + 22
		$Option_Text.bbcode_text += "BAG"
		
		grey_frame()
		$Options/BAG/Bag.frame = 1
	elif current == ORDER.POKEPOD:
		#$Option_Text.rect_position.x = init_pos.x - 2
		$Option_Text.bbcode_text += "POKEPOD"
		
		grey_frame()
		$"Options/POKEPOD/Poképod".frame = 1
	elif current == ORDER.CARD:
		#$Option_Text.rect_position.x = init_pos.x - 24
		$Option_Text.bbcode_text += "TRAINERCARD"
		
		grey_frame()
		$Options/CARD/Card.frame = 1
	elif current == ORDER.SAVE:
		#$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.bbcode_text += "SAVE"
		
		grey_frame()
		$Options/SAVE/Save.frame = 1
	elif current == ORDER.OPTION:
		#$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text += "OPTIONS"
		
		grey_frame()
		$Options/OPTION/Options.frame = 1
	elif current == ORDER.EXIT:
		#$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.bbcode_text += "EXIT"
		
		grey_frame()
		$Options/EXIT/Exit.frame = 1
	elif current == ORDER.POKEDEX:
		#$Option_Text.rect_position = init_pos
		$Option_Text.bbcode_text += "POKEDEX"
		
		grey_frame()
		$Options/POKEDEX/Pokedex.frame = 1
	
	$Option_Text.bbcode_text += "[/center]"
	
	slide(dir)

func slide(dir):
	if dir == "Left":
		for node in get_child(5).get_children():
			if node.position.x > 512:
				node.position.x = offscreen_right
		
		move_offset = Vector2(38 * 2, 0)
	else:
		for node in get_child(5).get_children():
			if node.position.x < 0:
				node.position.x = offscreen_left
		
		move_offset = -Vector2(38 * 2, 0)
		
	$Options/PARTY/Tween.interpolate_property($Options/PARTY, "position", $Options/PARTY.position, $Options/PARTY.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/BAG/Tween.interpolate_property($Options/BAG, "position", $Options/BAG.position, $Options/BAG.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/POKEPOD/Tween.interpolate_property($Options/POKEPOD, "position", $Options/POKEPOD.position, $Options/POKEPOD.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/CARD/Tween.interpolate_property($Options/CARD, "position", $Options/CARD.position, $Options/CARD.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/SAVE/Tween.interpolate_property($Options/SAVE, "position", $Options/SAVE.position, $Options/SAVE.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/OPTION/Tween.interpolate_property($Options/OPTION, "position", $Options/OPTION.position, $Options/OPTION.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/EXIT/Tween.interpolate_property($Options/EXIT, "position", $Options/EXIT.position, $Options/EXIT.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Options/POKEDEX/Tween.interpolate_property($Options/POKEDEX, "position", $Options/POKEDEX.position, $Options/POKEDEX.position + move_offset, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	$Options/PARTY/Tween.start()
	$Options/BAG/Tween.start()
	$Options/POKEPOD/Tween.start()
	$Options/CARD/Tween.start()
	$Options/SAVE/Tween.start()
	$Options/OPTION/Tween.start()
	$Options/EXIT/Tween.start()
	$Options/POKEDEX/Tween.start()
	
	$Sounds/Move.play()
	yield($Options/POKEDEX/Tween, "tween_completed")
	

func grey_frame():
	$"Options/PARTY/Pokémon".frame = 0
	$"Options/POKEPOD/Poképod".frame = 0
	$Options/BAG/Bag.frame = 0
	$Options/CARD/Card.frame = 0
	$Options/OPTION/Options.frame = 0
	$Options/POKEDEX/Pokedex.frame = 0
	$Options/SAVE/Save.frame = 0
	$Options/EXIT/Exit.frame = 0

func setup_save_boxes():
	$Save_Menu/Info/Node2D/Location.bbcode_text = "[center][color=#209808]" + Global.location + "[/color][/center]"
	$Save_Menu/Info/Player_Name/Name.bbcode_text = "[right][color=#0070f8]" + Global.TrainerName + "[/color][/right]"
	$Save_Menu/Info/Time/Count.bbcode_text = "[right][color=#0070f8]" + str(Global.time) + "[/color][/right]"
	$Save_Menu/Info/Badges/Count.bbcode_text = "[right][color=#0070f8]" + str(Global.badges) + "[/color][/right]"

func close_bag():
	print("Closing bag")
	$Bag.enabled = false
	$Transition.show()
	$Transition.fade_to_color()
	yield($Transition, "finished")
	hide_all()
	$Bag.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()

func close_party():

	$PokemonPartyMenu.stage = 0
	$Transition.show()
	$Transition.fade_to_color()
	yield($Transition, "finished")
	hide_all()
	$PokemonPartyMenu.hide()
	show_base()

	yield(get_tree().create_timer(0.3), "timeout")

	menu_stage = 1
	$Transition.fade_from_color()
	
func close_dex():
	$Pokedex.mode = 0
	$Transition.show()
	$Transition.fade_to_color()
	yield($Transition, "finished")
	$Pokedex.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()

func close_card():
	$Card.mode = 0
	$Transition.show()
	$Transition.fade_to_color()
	yield($Transition, "finished")
	$Card.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()
