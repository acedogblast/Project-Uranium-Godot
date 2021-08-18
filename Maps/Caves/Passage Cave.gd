extends Node2D

var background_music = "res://Audio/BGM/PU-Passage Cave.ogg"; # Same as route 1 apparently

var type = "Outside"
var place_name = "Passage Cave"
var dark = true
var wild_battle_back = BattleInstanceData.BattleBack.CAVE
var always_wild_gen_on_step = true

# Wild Poke table
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[20,  40,   4,           6], # Tonemy
	[15,  25,   4,           6], # Barewl
	[18,  25,   4,           6], # Gozard
	[22,  10,   4,           6]  # Dunsparce
]

# Trainers
var trainer1
var trainer2
var trainer3
var trainer4

# Items
var item1

func _ready():
	$ColorRect.show()
	trainer1 = $NPC_Layer/Trainer1
	trainer2 = $NPC_Layer/Trainer2
	trainer3 = $NPC_Layer/Trainer3
	#trainer4 = $NPC_Layer/Trainer4
	#trainer4.turning_directions = ["Down", "Left"]

	item1 = $NPC_Layer/Item

	Global.game.player.connect("trainer_battle", self, "trainer_battle")

	if Global.past_events.has("PASSAGE_CAVE_TRAINER_1_DEFEATED"):
		trainer1.seeking = false
		trainer1.defeated = true
	if Global.past_events.has("PASSAGE_CAVE_TRAINER_2_DEFEATED"):
		trainer2.seeking = false
		trainer2.defeated = true
	if Global.past_events.has("PASSAGE_CAVE_TRAINER_3_DEFEATED"):
		trainer3.seeking = false
		trainer3.defeated = true
	if Global.past_events.has("PASSAGE_CAVE_TRAINER_4_DEFEATED"):
		trainer4.seeking = false
		trainer4.defeated = true
	if Global.past_events.has("PASSAGE_CAVE_ITEM_1_TAKEN"):
		item1.queue_free()
		item1 = null

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == $NPC_Layer/Trainer1.position:
		$NPC_Layer/Trainer1.face_player(direction)
		if !trainer1.defeated:
			trainer_battle(trainer1)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_1_DEFEAT" , trainer1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	if check_pos == $NPC_Layer/Trainer2.position:
		$NPC_Layer/Trainer2.face_player(direction)
		if !trainer2.defeated:
			trainer_battle(trainer2)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_2_DEFEAT" , trainer2.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	if check_pos == $NPC_Layer/Trainer3.position:
		$NPC_Layer/Trainer3.face_player(direction)
		if !trainer3.defeated:
			trainer_battle(trainer3)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_3_DEFEAT" , trainer2.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	if item1 != null && check_pos == $NPC_Layer/Item.position:
		Global.game.lock_player()
		Global.past_events.append("PASSAGE_CAVE_ITEM_1_TAKEN")
		item1.queue_free()
		item1 = null
		Global.inventory.add_item_by_name_multiple("Great Ball", 1)
		Global.game.recive_item($NPC_Layer/Item.item_id)
		yield(Global.game, "end_of_event")
		Global.game.release_player()
	

func trainer_battle(npc_trainer):
	Global.game.lock_player()
	npc_trainer.seeking = false
	# Play encounter music
	npc_trainer.alert()
	yield(npc_trainer, "alert_done")
	match npc_trainer:
		trainer1, trainer3:
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-MaleEncounter.ogg")
		trainer2:
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-PsychicAthlete spotted.ogg")
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
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_1" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer2:
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_2" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer3:
			Global.game.play_dialogue_with_point("PASSAGE_CAVE_TRAINER_3" , npc_trainer.get_global_transform_with_canvas().get_origin())
		
	yield(Global.game, "event_dialogue_end")

	match npc_trainer:
		trainer1:
			trainer1_battle()
		trainer2:
			trainer2_battle()
		trainer3:
			trainer3_battle()
func trainer1_battle():
	var trainer = trainer1
	trainer.seeking = false

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.CAVE
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer004.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("PASSAGE_CAVE_TRAINER_1_DEFEATED")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("PASSAGE_CAVE_TRAINER_1_DEFEATED")
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
	bid.battle_back = bid.BattleBack.CAVE
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer016.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("PASSAGE_CAVE_TRAINER_2_DEFEATED")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("PASSAGE_CAVE_TRAINER_2_DEFEATED")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()
func trainer3_battle():
	var trainer = trainer3
	trainer.seeking = false

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.CAVE
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer004.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("PASSAGE_CAVE_TRAINER_3_DEFEATED")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("PASSAGE_CAVE_TRAINER_3_DEFEAT")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()