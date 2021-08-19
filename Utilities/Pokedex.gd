extends Node2D

var seen_count_label
var obtained_count_label
var mode = 0

var selected_panel = 0 # Values 0 - 5
var selected_ID = 1 # Values 1 - Highest ID
var top_panel_ID = 1

var highest_ID
var panels = [] # Should only be 6

var poke_data

signal close

func _ready():
	self.hide()
	var grid_texture = load("res://Graphics/Pictures/Pokedex/dexbg_grid.png")
	grid_texture.flags = Texture.FLAG_REPEAT
	$BG/Sprite.texture = grid_texture
	seen_count_label = $Seen/Count
	obtained_count_label = $Obtained/Count2
	seen_count_label.text = "0"
	obtained_count_label.text = "0"
	selected_panel = 0
	top_panel_ID = 1
	highest_ID = Global.registry.pokemon.size()

	for n in $List.get_children():
		$List.remove_child(n)
		n.queue_free()

func start():
	setup_panels()
	update_panels()
	update_pic()

	$Seen/Count.text = str(Global.pokedex_seen.size())
	$Obtained/Count2.text = str(Global.pokedex_caught.size())

	mode = 1

func _input(event):
	match mode:
		1:
			if event.is_action_pressed("ui_down") && selected_ID != highest_ID:
				selected_ID += 1
				if selected_panel < 5:
					selected_panel += 1
				else:
					top_panel_ID += 1
				update_panels()
				update_pic()
				return
			if event.is_action_pressed("ui_up") && selected_ID != 1:
				selected_ID -= 1
				if selected_panel != 0:
					selected_panel -= 1
				else:
					top_panel_ID -= 1
				update_panels()
				update_pic()
				return
			if event.is_action_pressed("x"):
				emit_signal("close")
				return
	pass

func setup_panels():
	for i in range(6):
		var panel_sprite = Sprite.new()
		panel_sprite.texture = load("res://Graphics/Pictures/Pokedex/dexarrow.png")
		panel_sprite.centered = false
		panel_sprite.vframes = 4
		panel_sprite.frame = 2
		panel_sprite.position = Vector2(0, i * 48)
		panel_sprite.name = "panel" + str(i)
		$List.add_child(panel_sprite)
		panels.append(panel_sprite)

		var icon = Sprite.new()
		icon.texture = load("res://Graphics/Icons/icon" + str("%03d" % (i + 1) ) + ".png") as Texture
		icon.hframes = 2
		icon.position = Vector2(35,15)
		icon.name = "Icon"
		panel_sprite.add_child(icon)

		var caught = TextureRect.new()
		caught.texture = load("res://Graphics/Pictures/Pokedex/dexball.png")
		caught.rect_position = Vector2(82,8)
		caught.name = "Caught"
		panel_sprite.add_child(caught)

		var id_label = Label.new()
		id_label.rect_position = Vector2(122,9)
		id_label.add_font_override("font",load("res://Utilities/Battle/MoveTextFont.tres"))
		id_label.text = str("%03d" % (i + 1) )
		id_label.name = "ID"
		panel_sprite.add_child(id_label)

		var name_label = Label.new()
		name_label.rect_position = Vector2(168,9)
		name_label.add_font_override("font",load("res://Utilities/Battle/MoveTextFont.tres"))
		name_label.text = "?????"
		name_label.name = "Name"
		panel_sprite.add_child(name_label)

func update_panels():
	for i in range(6):
		var panel = panels[i]
		var panel_id = top_panel_ID + i

		poke_data = Global.registry.get_pokemon_class(panel_id)

		panel.get_node("ID").text = str("%03d" % panel_id )
		
		# Check if player seen it?
		if Global.pokedex_seen.has(panel_id):
			panel.frame = 2
			panel.get_node("Name").text = poke_data.name
			panel.get_node("Icon").texture = load("res://Graphics/Icons/icon" + str("%03d" % panel_id ) + ".png") as Texture
			panel.get_node("Icon").hframes = 2
			panel.get_node("Icon").frame = 0
			panel.get_node("Icon").show()

			if Global.pokedex_caught.has(panel_id):
				panel.get_node("Caught").show()
			else:
				panel.get_node("Caught").hide()
		else:
			panel.frame = 0
			panel.get_node("Name").text = "?????"
			panel.get_node("Icon").hide()
			panel.get_node("Caught").hide()

		if panel_id == selected_ID:
			if Global.pokedex_seen.has(panel_id):
				panel.frame = 3
			else:
				panel.frame = 1

func update_pic():
	if Global.pokedex_seen.has(selected_ID):
		$Pic/Discover.frame = 0
		var tex : Texture = load("res://Graphics/Battlers/" + str("%03d" % selected_ID) + ".png") as Texture

		if tex == null:
			# Try loading with .PNG instead of .png
			tex = load("res://Graphics/Battlers/" + str("%03d" % selected_ID) + ".PNG") as Texture
	
		$Pic/Poke.texture = tex
		if $Pic/Poke.texture.get_width() != 80:
			var frames = $Pic/Poke.texture.get_width() / 80
			$Pic/Poke.hframes = frames
		else:
			$Pic/Poke.hframes = 1
			
		$Pic/Poke.show()
	else:
		$Pic/Discover.frame = 1
		$Pic/Poke.hide()