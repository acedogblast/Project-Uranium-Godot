@tool
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
	if(Engine.is_editor_hint()):
		# Special things when this is on editor mode
		$AnimationPlayer.seek($AnimationPlayer.current_animation_length)
	
	$Bag.connect("close_bag", Callable(self, "close_bag"))
	$PokemonPartyMenu.connect("close_party", Callable(self, "close_party"))
	$OptionsMenu.connect("closed", Callable(self, "_on_options_closed"))
	$Pokedex.connect("close", Callable(self, "close_dex"))
	$Card.connect("close", Callable(self, "close_card"))
	
	current = ORDER.PARTY
	init_pos = $Option_Text.position
	_build_exit_prompt()
	$Bag.set("enabled", false)
	
	$Save_Menu/Info/Player_Name/Name.text = "[right][color=#0070f8]" + Global.TrainerName + "[/color][/right]"

func _input(event):
	if menu_stage == 3:
		_exit_prompt_input(event)
		if get_viewport() != null:
			get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("x") && !locked:
		match menu_stage:
			0:
				Global.game.player.call_deferred("change_input", true)
				self.visible = true
				menu_stage = 1
				print("Toggling")
				$AnimationPlayer.play("Open Menu")
				var pn = Global.game.current_scene.get("place_name")
				if pn == null:
					pn = Global.game.current_scene.get("map_name")
				if pn == null:
					pn = ""
				$Place_Text.text = "[center]" + str(pn) + "[/center]"
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
		if event.is_action_pressed("z") and !saving and Global.can_run:
			Global.sprint = !Global.sprint
			if $Run/Sprite2D.frame == 0:
				$Run/Sprite2D.frame = 1
			else:
				$Run/Sprite2D.frame = 0
		if event.is_action_pressed("ui_accept"):
			select()
			return # This breaks out of the current method. Needed after select()
	
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
	await $Transition.finished
	hide_all()
	$PokemonPartyMenu.setup()
	$PokemonPartyMenu.show()
	$Transition.fade_from_color()
	await $Transition.finished
	$Transition.visible = false


func bag_setup():
	$Transition.visible = true
	$Transition.fade_to_color()
	await $Transition.finished
	hide_all()
	$Bag.setup()
	$Bag.show()
	$Transition.fade_from_color()
	await $Transition.finished
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
		$Bag.set("enabled", true)
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
			await $Transition.finished
			hide_all()
			$Pokedex.start()
			$Pokedex.show()
			$Transition.fade_from_color()
			await $Transition.finished
			$Transition.visible = false
		else:
			menu_stage = 1
	elif current == ORDER.OPTION:
		locked = true
		$OptionsMenu.open()
	elif current == ORDER.EXIT:
		_open_exit_prompt()
	elif current == ORDER.CARD:
		$Transition.fade_to_color()
		await $Transition.finished
		hide_all()
		$Card.setup()
		$Card.show()
		$Transition.fade_from_color()
		await $Transition.finished
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

	$Option_Text.text = "[center]"
	
	if current == ORDER.PARTY:
		#$Option_Text.rect_position = init_pos
		$Option_Text.text += "POKÉMON"
		
		grey_frame()
		$"Options/PARTY/Pokémon".frame = 1
	elif current == ORDER.BAG:
		#$Option_Text.rect_position.x = init_pos.x + 22
		$Option_Text.text += "BAG"
		
		grey_frame()
		$Options/BAG/Bag.frame = 1
	elif current == ORDER.POKEPOD:
		#$Option_Text.rect_position.x = init_pos.x - 2
		$Option_Text.text += "POKEPOD"
		
		grey_frame()
		$"Options/POKEPOD/Poképod".frame = 1
	elif current == ORDER.CARD:
		#$Option_Text.rect_position.x = init_pos.x - 24
		$Option_Text.text += "TRAINERCARD"
		
		grey_frame()
		$Options/CARD/Card.frame = 1
	elif current == ORDER.SAVE:
		#$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.text += "SAVE"
		
		grey_frame()
		$Options/SAVE/Save.frame = 1
	elif current == ORDER.OPTION:
		#$Option_Text.rect_position = init_pos
		$Option_Text.text += "OPTIONS"
		
		grey_frame()
		$Options/OPTION/Options.frame = 1
	elif current == ORDER.EXIT:
		#$Option_Text.rect_position.x = init_pos.x + 16
		$Option_Text.text += "EXIT"
		
		grey_frame()
		$Options/EXIT/Exit.frame = 1
	elif current == ORDER.POKEDEX:
		#$Option_Text.rect_position = init_pos
		$Option_Text.text += "POKEDEX"
		
		grey_frame()
		$Options/POKEDEX/Pokedex.frame = 1
	
	$Option_Text.text += "[/center]"
	
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
	
	# Godot 4: Create tweens programmatically
	var menu_tween = create_tween()
	menu_tween.set_parallel(true)  # Run all tweens simultaneously
	
	menu_tween.tween_property($Options/PARTY, "position", $Options/PARTY.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/BAG, "position", $Options/BAG.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/POKEPOD, "position", $Options/POKEPOD.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/CARD, "position", $Options/CARD.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/SAVE, "position", $Options/SAVE.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/OPTION, "position", $Options/OPTION.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/EXIT, "position", $Options/EXIT.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	menu_tween.tween_property($Options/POKEDEX, "position", $Options/POKEDEX.position + move_offset, 0.01).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	
	$Sounds/Move.play()
	await menu_tween.finished
	

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
	$Save_Menu/Info/Node2D/Location.text = "[center][color=#209808]" + Global.location + "[/color][/center]"
	$Save_Menu/Info/Player_Name/Name.text = "[right][color=#0070f8]" + Global.TrainerName + "[/color][/right]"
	$Save_Menu/Info/Time/Count.text = "[right][color=#0070f8]" + str(Global.time) + "[/color][/right]"
	$Save_Menu/Info/Badges/Count.text = "[right][color=#0070f8]" + str(Global.badges) + "[/color][/right]"

func close_bag():
	print("Closing bag")
	$Bag.set("enabled", false)
	$Transition.show()
	$Transition.fade_to_color()
	await $Transition.finished
	hide_all()
	$Bag.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()

func close_party():

	$PokemonPartyMenu.stage = 0
	$Transition.show()
	$Transition.fade_to_color()
	await $Transition.finished
	hide_all()
	$PokemonPartyMenu.hide()
	show_base()

	await get_tree().create_timer(0.3).timeout

	menu_stage = 1
	$Transition.fade_from_color()
	
func close_dex():
	$Pokedex.mode = 0
	$Transition.show()
	$Transition.fade_to_color()
	await $Transition.finished
	$Pokedex.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()

func close_card():
	$Card.mode = 0
	$Transition.show()
	$Transition.fade_to_color()
	await $Transition.finished
	$Card.hide()
	show_base()
	menu_stage = 1
	$Transition.fade_from_color()

func _on_options_closed():
	locked = false
	menu_stage = 1


# --- Exit prompt (faithful to the original: Return To Game / Exit To Menu / Exit To Desktop) ---
const EXIT_KEYS = ["Return To Game", "Exit To Menu", "Exit To Desktop"]
var exit_prompt: Node2D
var exit_labels := []
var exit_cursor: Sprite2D
var exit_idx := 0

func _build_exit_prompt():
	exit_prompt = Node2D.new()
	exit_prompt.name = "ExitPrompt"
	exit_prompt.z_index = 50
	var bg := ColorRect.new()
	bg.color = Color(0, 0, 0, 0.55)
	bg.position = Vector2(236, 148)
	bg.size = Vector2(276, 118)
	exit_prompt.add_child(bg)
	for i in range(3):
		var lbl: RichTextLabel = $Option_Text.duplicate()
		lbl.name = "exit%d" % i
		lbl.position = Vector2(266, 172 + i * 32)
		lbl.size = Vector2(212, 30)
		lbl.visible = true
		lbl.modulate = Color(1, 1, 1, 1)
		exit_prompt.add_child(lbl)
		exit_labels.append(lbl)
	# Official choice cursor (selarrow.png 12x28, drawn 1:1 like SpriteWindow_text)
	var cur := Sprite2D.new()
	cur.name = "exit_cursor"
	cur.texture = load("res://Graphics/Pictures/selarrow.png")
	cur.centered = false
	cur.scale = Vector2(0.5, 0.5)  # original draws UI in window px: 12x28 there = 6x14 in scene units
	exit_cursor = cur
	exit_prompt.add_child(exit_cursor)
	exit_prompt.visible = false
	add_child(exit_prompt)

func _open_exit_prompt():
	exit_idx = 0
	for i in range(3):
		exit_labels[i].text = tr(EXIT_KEYS[i])
	_update_exit_cursor()
	exit_prompt.visible = true
	menu_stage = 3

func _update_exit_cursor():
	exit_cursor.position = Vector2(258, 171 + exit_idx * 32)

func _close_exit_prompt():
	exit_prompt.visible = false
	menu_stage = 1

func _exit_prompt_input(event) -> void:
	if event.is_action_pressed("ui_down"):
		exit_idx = (exit_idx + 1) % 3
		_update_exit_cursor()
	elif event.is_action_pressed("ui_up"):
		exit_idx = (exit_idx + 2) % 3
		_update_exit_cursor()
	elif event.is_action_pressed("ui_cancel") or event.is_action_pressed("x"):
		_close_exit_prompt()
	elif event.is_action_pressed("ui_accept"):
		match exit_idx:
			0:
				_close_exit_prompt()
			1:
				Global.save_settings()
				Global.pokemon_group.clear()
				Global.past_events.clear()
				Global.pokedex_seen.clear()
				Global.pokedex_caught.clear()
				get_tree().paused = false
				get_tree().change_scene_to_file("res://IntroScenes/Menu.tscn")
			2:
				Global.save_settings()
				get_tree().quit()
