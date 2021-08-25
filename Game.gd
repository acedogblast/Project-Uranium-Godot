extends Node2D

var player
var menu
var battle
var overlay

var start_scene = preload("res://Maps/MokiTown/HeroHome.tscn")
var current_scene
var scenes = []
var trainers = [] # array of trainers in the current scene
var cliffs = []

var loaded = false
var isInteracting = false
var isTransitioning = false
var last_heal_point
var player_defeated = false # True when player lost a battle and transioning to last heal point scene

signal event_dialogue_end
signal tranistion_complete
signal loaded
signal end_of_event

onready var transition = $CanvasLayer/Transition

func _ready():
	Global.game = self
	menu = $CanvasLayer/Menu
	$CanvasLayer/Fade.modulate = Color(1.0,1.0,1.0,0.0)
	$BG.show()

	#Makes player an instance of Player, makes it a child, and adds it to the group save
	player = load("res://Utilities/Player.tscn").instance()
	add_child(player)

	if OS.is_debug_build():
		overlay = preload("res://Utilities/debug_overlay.tscn").instance()
		overlay.add_stat("onGrass", Global, "onGrass", false)
		#overlay.add_stat("Grass Position", Global, "grass_positions", false)
		#overlay.add_stat("Exit Grass Position", Global, "exitGrassPos", false)
		#overlay.add_stat("Direction", player, "dir", false)
		overlay.add_stat("Player Pos", player, "position", false)
		add_child(overlay)

	
	loaded = false
	self.call_deferred("setup")
	
func setup():
	#If load_game_from_id has a value, then load game from the id
	if Global.load_game_from_id != null:
		# Loads game data
		SaveSystem.load_game(Global.load_game_from_id)
		print("loading Game.gd")
		# Wait until all data is loaded
		if loaded == false:
			yield(self, "loaded")
		print("Finished loading Game.gd")
		loaded = true
	#If the above is false change the scene to start_scene
	else:
		# New Game

		# init inventory
		Global.inventory = load("res://Utilities/Items/Inventory.gd").new()

		change_scene(start_scene)
		player.position = Vector2(192,144)
		player.direction = player.DIRECTION.UP
		player.set_idle_frame(player.direction)

	player.z_index = 10 # DO NOT CHANGE! see AutoZSorter for details
	var result = DialogueSystem.connect("dialogue_end", self, "dialog_end", [], CONNECT_DEFERRED)
	player.set_idle_frame(player.direction)
	player.canMove = true

	if ("place_name" in current_scene):
		Global.location = current_scene.place_name
	else:
		Global.location = "TBD"
		print("WARNING: current_scene script does not have place_name set.")
	$CanvasLayer/Menu.visible = true
	$CanvasLayer/ZoneMessage.visible = true

	player.connect("wild_battle", self, "wild_battle")
	$Clock.connect("timeout", self, "clock_timeout")
	$Clock.start()

func _process(_delta):
	# Sort and assign Z index
	var nodes = get_tree().get_nodes_in_group("auto_z_layering")

	nodes.sort_custom(AutoZSorter, "sort_ascending")
	var index = 10
	for node in nodes:
		node.z_index = index
		index += 1

	#Quick save
	if Input.is_action_just_pressed("F1"):
		SaveSystem.save_game(1)
	
	if Input.is_action_just_pressed("F2"):
		overlay.toggle()

func change_menu_text():
	if $CanvasLayer/Menu/Place_Text.bbcode_text != current_scene.place_name:
		$CanvasLayer/Menu/Place_Text.bbcode_text = "[center]" + current_scene.place_name + "[/center]"

func change_scene(scene):
	if scene != null:
		# Clear and delete scenes
		for node in scenes:
			node.free()
		scenes.clear()

	if scene is String:
		var new_scene = load(scene)
		scenes.append(new_scene.instance())
		current_scene = new_scene
		add_child(current_scene)
	elif scene is Resource:
		var new_scene = scene.instance()
		scenes.append(new_scene)
		current_scene = new_scene
		add_child(current_scene)
	elif scene == null: # Should only be for transitioning from one scene to another seamlessly
		# Find out that the new scene is
		print("seamless transision")
		current_scene = get_current_scene_where_player_is()
	else:
		print("GAME WARNING: change_scene arg is not what it should be.")
		pass
	

	# Load and start background music if available.
	if "background_music" in current_scene && current_scene.background_music != null:
		var music = load(current_scene.background_music)
		$Background_music.stream = music
		$Background_music.play()
	# If scene is outdoors, play zone animation
	if "type" in current_scene && current_scene.type == "Outside":
		$CanvasLayer/ZoneMessage/AnimationPlayer.stop()
		$CanvasLayer/ZoneMessage/Bar/Label.text = current_scene.place_name
		$CanvasLayer/ZoneMessage/AnimationPlayer.play("Slide")
	Global.location = current_scene.place_name

	# Apply dark mask over scene
	if "dark" in current_scene && current_scene.dark == true:
		print("Dark Place")
		$CanvasLayer/Dark.show()
		$CanvasLayer/Dark.scale = Vector2(1,1)
		if current_scene.place_name == "Passage Cave":
			$CanvasLayer/Dark.scale = Vector2(2,2)
	else:
		$CanvasLayer/Dark.hide()

	# Move player to heal_point if defeated and heal party
	if player_defeated:
		player.position = current_scene.heal_point
		Global.heal_party()
		player_defeated = false

	# Get grass positions for the new scene
	
	if "type" in current_scene && current_scene.type == "Outside" && current_scene.has_method("get_grass_cells"):
		var grass_cells = current_scene.get_grass_cells() # Get Array of Vector2s of cells in cell cord
		var final_pos = [] # Array of Vector2s of grass global locations

		for cells in grass_cells:
			var pos = cells
			pos = pos * 32
			pos = pos + current_scene.position
			pos = pos + Vector2(16,16)
			final_pos.append(pos)
		Global.grass_positions = final_pos
	else:
		Global.grass_positions.clear()

	# Get new trainers
	trainers.clear()
	trainers = current_scene.get_tree().get_nodes_in_group("trainers")

	# Get cliffs
	cliffs.clear()
	cliffs = get_cliffs()

	# Load adjacent sceens
	if "adjacent_scenes" in current_scene && current_scene.adjacent_scenes != null && current_scene.adjacent_scenes.size() != 0:
		for scene_array in current_scene.adjacent_scenes:
			# Check if scene is already in the scenes array
			var is_already_loaded = true
			var scene_filename = scene_array[0]
			for scene in scenes:
				if scene.filename == scene_filename:
					break
				else:
					is_already_loaded = false
			
			if is_already_loaded == false:
				# Add the scene
				var new_scene = load(scene_filename).instance()
				scenes.append(new_scene)
				new_scene.position = current_scene.position + scene_array[1]
				add_child(new_scene)


#Gets the destination and direction from Stairs.gd, and goes to the next line
func room_transition(dest, dir):

	lock_player()
	
	$CanvasLayer/Transition/AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(0.28), "timeout")
	
	var target_stair_node
	for node in get_tree().get_nodes_in_group("Stairs"):
		if node.position == dest:
			target_stair_node = node
			break
	target_stair_node.get_node("CollisionShape2D").disabled = true
	
	#if dir is set to up, then set the player dircetion to 2, and if dir is down, then set the player direction to 1
	if dir == "Up":
		player.direction = 2
	elif dir == "Down":
		player.direction = 1
	
	#Set's the player's position to trainerx and trainery, waits .3 seconds, and then plays the fade_out animation
	player.position = dest
	#player.movePrevious()
	yield(get_tree().create_timer(0.3), "timeout")
	$CanvasLayer/Transition/AnimationPlayer.play("fade_out")
	
	#Calls the move method from PlayerNew.gd, and passes the true variable, disables input, and waits .3 seconds
	player.move(true)
	#player.movePrevious()
	player.inputDisabled = true
	yield(get_tree().create_timer(0.3), "timeout")
	

	target_stair_node.get_node("CollisionShape2D").disabled = false
	
	#Calls the change_input method from PlayerNew.gd, and calls the transition_visibility method
	release_player()
	Global.location = current_scene.place_name

#If the player is not transitioning, then set isTransitioning to true, and call the change_input method, and wait until the transition fade_to_color animation has finished
func door_transition(path_scene, new_position, direction = null):
	yield(transition.fade_to_color(), "completed")

	if path_scene != null:
		change_scene(load(path_scene))
	yield(get_tree().create_timer(0.3), "timeout")
	player.position = new_position
	player.visible = true
	transition.fade_from_color()

	# Check if exit is also a door
	for door in get_tree().get_nodes_in_group("Doors"):
		if door.position == new_position:
			door.set_open()
			if direction != null:
				Global.game.player.direction = direction
			Global.game.player.move(true)
			door.animation_close()
			break
	release_player()
	emit_signal("tranistion_complete")

#Checks to see if the player is interacting, if not and the interaction title isn't null then is interacting is set to true, the change_input method is called, the play_dialogue method is called, we wait until the dialogue event has ended, and the change_input method is called again
func interaction(check_pos : Vector2, direction): # Starts the dialogue instead of the scene script
	if !current_scene.has_method("interaction"):
		print("ERROR: current scene does not have interaction method.")
		return
	
	var interaction_title = current_scene.interaction(check_pos, direction)
	if interaction_title != null && typeof(interaction_title) == TYPE_STRING:
		lock_player()
		play_dialogue(interaction_title)
		yield(self, "event_dialogue_end")
		release_player()
	#If the above is false then print collider
	else:
		print("Game.gd interation: " + str(check_pos))
	
#Wait .1 second, set isInteracting to false, and emit the signal event_dialogue_end
func dialog_end():
	yield(get_tree().create_timer(0.1), "timeout")
	DialogueSystem.set_show_arrow(false)
	isInteracting = false
	emit_signal("event_dialogue_end")
	
#A position check for the node
func check_node(pos):
	for node in get_tree().get_nodes_in_group("interact"):
		if node.position == pos:
			return Node
		pass
	pass

#saves the state by saving the current_scene, player.position, and player.direction
func save_state():
	# Save player posistion relative to the current scene.
	var save_position = player.position - current_scene.position

	var state = {
		"current_scene": current_scene.filename,
		"player_position": save_position, 
		"player_direction": player.direction,
		"last_heal_point": last_heal_point
	}
	SaveSystem.set_state(filename, state)

func load_state(): # Automatically called when loading a save file
	if SaveSystem.has_state(filename):
		var state = SaveSystem.get_state(filename)
		change_scene(load(state["current_scene"]))
		player.direction = state["player_direction"]
		player.position = state["player_position"]

		if state.has("last_heal_point"):
			last_heal_point = state["last_heal_point"]
		loaded = true
		emit_signal("loaded")

func play_dialogue(title): # Plays a dialogue without freezing player
	DialogueSystem.set_show_arrow(false)
	DialogueSystem.start_dialog(title)
	
func play_dialogue_with_point(title, vector2): # Plays a dialogue with point and without freezing player
	DialogueSystem.set_show_arrow(true)
	DialogueSystem.set_point_to(vector2)
	DialogueSystem.start_dialog(title)

func lock_player(): # Locks player to prevent user input. Useful for events.
	player.call_deferred("change_input", true)
	Global.game.menu.locked = true
	Global.block_wild = true
func release_player(): # Releases player to prevent user input. Useful for events.
	player.call_deferred("change_input", false)
	Global.game.menu.locked = false
	Global.block_wild = false

func get_current_scene_where_player_is(): # Should only be called when player is outside
	for scene in scenes:
		# Get the bounds of the scene
		var tilemap = scene.get_node("Tile Layer 1")
		if tilemap == null:
			print("GAME ERROR: tilemap is null")
			return
		var map_cell_rect = tilemap.get_used_rect() # Returns rect of cell cordinates. Not Global positions.
		var map_rect = Rect2(scene.position, Vector2(map_cell_rect.size.x * 32, map_cell_rect.size.y * 32))
		
		#print(map_rect)
		#print(player.position)
		if map_rect.has_point(player.position):
			if scene == null:
				print("Problem")
			return scene
	print("Missed scene scan")

func wild_battle():
	Global.game.menu.locked = true
	print("Triggered Wild Battle")
	if !"wild_table" in current_scene:
		print("GAME ERROR: tried to make a wild encounter but current scene doesn't have a wild_table.")
		return

	Global.game.get_node("Background_music").stop()

	battle = load("res://Utilities/Battle/Battle.tscn").instance()
	add_child(battle)

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_WILD

	if "wild_battle_back" in current_scene:
		bid.battle_back = current_scene.wild_battle_back
	else:
		print("Game.gd Warning: Wild battle back was not set. Defaulting to Forest.")
		bid.battle_back = bid.BattleBack.FOREST
	bid.opponent = Opponent.new()
	bid.opponent.opponent_type = Opponent.OPPONENT_WILD
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD

	var poke = generate_wild_poke()
	bid.opponent.pokemon_group.append(poke)
	Global.game.battle.Start_Battle(bid)
	yield(Global.game.battle, "battle_complete")
	player_defeated = !battle.player_won
	
	if player_defeated:
		player_defeated()
		return
	Global.game.get_node("Background_music").play()
	yield(battle.get_node("CanvasLayer/ColorRect/AnimationPlayer"), "animation_finished")
	battle.queue_free()
	release_player()
func trainer_battle(bid : BattleInstanceData):
	lock_player()
	Global.game.get_node("Background_music").stop()
	battle = load("res://Utilities/Battle/Battle.tscn").instance()
	add_child(battle)
	Global.game.battle.Start_Battle(bid)
	yield(Global.game.battle, "battle_complete")

	player_defeated = !battle.player_won
	if player_defeated:
		player_defeated()
		return
	Global.game.get_node("Background_music").play()
	yield(battle.get_node("CanvasLayer/ColorRect/AnimationPlayer"), "animation_finished")
	battle.queue_free()
	release_player()
func generate_wild_poke() -> Pokemon:
	var poke = Pokemon.new()
	# Generate poke
	var value = Global.rng.randi() % 100 + 1 # Random number [1,100]

	# Get the wild poke table from current scene
	var table = current_scene.wild_table
	var n = 0
	var poke_id
	var index = 0
	for i in range(table.size()):
		var rate = table[i][1]
		if value >= n && value <= rate + n:
			poke_id = table[i][0]
			index = i
			break
		else:
			n += rate

	# Get level
	var level = Global.rng.randi_range(table[index][2], table[index][3])
	poke.set_basic_pokemon_by_level(poke_id,level)
	return poke
func player_defeated():

	# Spawn at last pokecenter/healpoint
	if last_heal_point == null:
		# Spawn home:
		last_heal_point = "res://Maps/MokiTown/HeroHome.tscn"
	change_scene(last_heal_point)
	release_player()

func clock_timeout():
	Global.time += 1
	print("Tick")

func get_cliffs():
	var nodes = []
	if current_scene.get_node("NPC_Layer") == null:
		return nodes

	for node in current_scene.get_node("NPC_Layer").get_children():
		if node.is_in_group("Cliff"):
			nodes.append(node)
	return nodes

func recive_item(item_name_or_ID):
	var item
	var pocket
	if typeof(item_name_or_ID) == TYPE_STRING:
		item = Global.inventory.get_item_by_name(item_name_or_ID)
	if typeof(item_name_or_ID) == TYPE_INT:
		item = Global.inventory.get_item_by_id(item_name_or_ID)
	
	Global.game.get_node("Background_music").stream_paused = true
	var sound = load("res://Audio/ME/Jingle - Regular Item.ogg")
	sound.loop = false
	Global.game.get_node("Effect_music").stream = sound
	Global.game.get_node("Effect_music").play()

	Global.game.play_dialogue(Global.TrainerName + " obtained \n" + item.name + "!")
	yield(Global.game, "event_dialogue_end")

	Global.game.play_dialogue(Global.TrainerName + " put the " + item.name + "\nin the " + Global.inventory.get_pocket_name(item) + ".")
	yield(Global.game, "event_dialogue_end")
	Global.game.get_node("Background_music").stream_paused = false

	# Add item to bag
	Global.inventory.add_item(item)

	emit_signal("end_of_event")
