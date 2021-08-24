extends Node2D

var adjacent_scenes = [
	["res://Maps/KevlarTown/Kevlar Town.tscn", Vector2(-352,1824)],
	["res://Maps/NowtochCity/Nowtoch City.tscn", Vector2(-480, -2368)]
]

var background_music = "res://Audio/BGM/PU-Route 01.ogg"; # Same as route 1 apparently

var type = "Outside"
var place_name = "Route 02"
var wild_battle_back = BattleInstanceData.BattleBack.FOREST

# Wild Poke table
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[7,   40,   3,           5], # Chyinmunk
	[9,   30,   3,           5], # Birbie
	[12,  10,   3,           5], # Cubbug
	[35,  10,   3,           5], # Owten
	[15,   5,   3,           5], # Barewl
	[32,   5,   3,           5]  # Mankey 
]

# Trainers
var trainer1
var trainer2
var trainer3
var trainer4

# Items
var item1

func _ready():
	trainer1 = $NPC_Layer/Trainer1
	trainer2 = $NPC_Layer/Trainer2
	#trainer3 = $NPC_Layer/Trainer3
	#trainer4 = $NPC_Layer/Trainer4
	#trainer4.turning_directions = ["Down", "Left"]
	item1 = $NPC_Layer/Item1

	Global.game.player.connect("trainer_battle", self, "trainer_battle")

	if Global.past_events.has("ROUTE2_TRAINER1_DEFEATED"):
		trainer1.seeking = false
		trainer1.defeated = true
	if Global.past_events.has("ROUTE2_TRAINER2_DEFEATED"):
		trainer2.seeking = false
		trainer2.defeated = true
	if Global.past_events.has("ROUTE2_TRAINER3_DEFEATED"):
		trainer3.seeking = false
		trainer3.defeated = true
	if Global.past_events.has("ROUTE2_TRAINER4_DEFEATED"):
		trainer4.seeking = false
		trainer4.defeated = true
	if Global.past_events.has("ROUTE2_ITEM_1_TAKEN"):
		item1.queue_free()
		item1 = null

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == $NPC_Layer/Trainer1.position:
		$NPC_Layer/Trainer1.face_player(direction)
		if !trainer1.defeated:
			trainer_battle(trainer1)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_1_DEFEAT" , trainer1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	if check_pos == $NPC_Layer/Trainer2.position:
		$NPC_Layer/Trainer2.face_player(direction)
		if !trainer2.defeated:
			trainer_battle(trainer2)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_2_DEFEAT" , trainer2.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	if check_pos == $NPC_Layer/Barewl.position:
		#$NPC_Layer/Trainer2.face_player(direction)
		Global.game.lock_player()
		Global.game.get_node("Effect_music").stream = load("res://Audio/SE/015Cry.wav")
		Global.game.get_node("Effect_music").play()
		Global.game.play_dialogue_with_point("NPC_ROUTE2_BAREWL" , $NPC_Layer/Barewl.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
	pass

	if item1 != null && check_pos == $NPC_Layer/Item1.position:
		Global.game.lock_player()
		Global.past_events.append("ROUTE2_ITEM_1_TAKEN")
		Global.inventory.add_item_by_id_multiple(item1.item_id, 1)
		item1.queue_free()
		item1 = null
		Global.game.recive_item($NPC_Layer/Item1.item_id)
		yield(Global.game, "end_of_event")
		Global.game.release_player()


func trainer_battle(npc_trainer):
	Global.game.lock_player()
	npc_trainer.seeking = false
	# Play encounter music
	npc_trainer.alert()
	yield(npc_trainer, "alert_done")
	match npc_trainer:
		trainer1, trainer2:
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-MaleEncounter.ogg")
		#trainer3, trainer4:
		#	Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-MaleEncounter.ogg")
	Global.game.get_node("Background_music").play()

	# Turn player to face trainer
	match npc_trainer.facing:
		"Up":
			Global.game.player.set_facing_direction("Down")
		"Down":
			Global.game.player.set_facing_direction("Up")
		"Left":
			Global.game.player.set_facing_direction("Right")
		"Right":
			Global.game.player.set_facing_direction("Left")

	# Walk towards player
	npc_trainer.move_to_player()
	yield(npc_trainer, "done_movement")

	# Pre-battle talk
	match npc_trainer:
		trainer1:
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_1" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer2:
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_2" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer3:
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_3" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer4:
			Global.game.play_dialogue_with_point("NPC_ROUTE2_TRAINER_4" , npc_trainer.get_global_transform_with_canvas().get_origin())

	yield(Global.game, "event_dialogue_end")

	match npc_trainer:
		trainer1:
			trainer1_battle()
		trainer2:
			trainer2_battle()
		#trainer3:
		#	trainer3_battle()
		#trainer4:
		#	trainer4_battle()
	pass

func get_grass_cells():
	return get_node("Grass").get_used_cells()

func trainer1_battle():
	var trainer = trainer1
	trainer.seeking = false

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.FOREST
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer003.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("NPC_ROUTE2_TRAINER_1_DEFEAT")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("ROUTE2_TRAINER1_DEFEATED")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()
func trainer2_battle():
	var trainer = trainer2
	trainer.seeking = false

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.MOUNTAIN
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer004.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("NPC_ROUTE2_TRAINER_2_DEFEAT")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("ROUTE2_TRAINER2_DEFEATED")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()