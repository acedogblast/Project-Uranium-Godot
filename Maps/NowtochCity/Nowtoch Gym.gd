extends Node2D

var background_music = "res://Audio/BGM/PU-Gym2.ogg";

var type = "Indoors"
var place_name = "Nowtoch City Gym"


var gym_guy
var maria
var trainer1
var trainer2

signal battle_done

func _ready():
	gym_guy = $NPC_Layer/GymGuy
	maria = $NPC_Layer/Maria
	trainer1 = $NPC_Layer/Trainer1
	trainer2 = $NPC_Layer/Trainer2

	Global.game.player.connect("trainer_battle", self, "trainer_battle")

	if Global.past_events.has("GYM1_TRAINER1_DEFEATED"):
		trainer1.seeking = false
		trainer1.defeated = true
	if Global.past_events.has("GYM1_TRAINER2_DEFEATED"):
		trainer2.seeking = false
		trainer2.defeated = true

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == trainer1.position:
		trainer1.face_player(direction)
		if !trainer1.defeated:
			trainer_battle(trainer1)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("GYM1_TRAINER_1_DEFEAT" , trainer1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
	if check_pos == trainer2.position:
		trainer2.face_player(direction)
		if !trainer2.defeated:
			trainer_battle(trainer1)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("GYM1_TRAINER_2_DEFEAT" , trainer2.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
	if check_pos == maria.position:
		maria.face_player(direction)
		Global.game.lock_player()

		if !Global.past_events.has("GYM1_COMPLETE"):
			for i in range(1, 8):
				Global.game.play_dialogue_with_point("GYM1_MARIA_" + str(i) , maria.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
			maira_battle()
			yield(self, "battle_done")
			Global.game.lock_player()
			for i in range(10, 13):
				Global.game.play_dialogue_with_point("GYM1_MARIA_" + str(i) , maria.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")
			
			# Add TM27
			Global.game.recive_item(259)
			yield(Global.game, "end_of_event")

			for i in range(13, 16):
				Global.game.play_dialogue_with_point("GYM1_MARIA_" + str(i) , maria.get_global_transform_with_canvas().get_origin())
				yield(Global.game, "event_dialogue_end")

		else:
			Global.game.play_dialogue_with_point("GYM1_MARIA_16" , maria.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

		Global.game.release_player()
	if check_pos == gym_guy.position:
		Global.game.lock_player()
		gym_guy.face_player(direction)
		Global.game.play_dialogue_with_point("GYM1_GYM_GUY_1" , gym_guy.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("GYM1_GYM_GUY_2" , gym_guy.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("GYM1_GYM_GUY_3" , gym_guy.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")
		Global.game.play_dialogue_with_point("GYM1_GYM_GUY_4" , gym_guy.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		if !Global.past_events.has("GYM1_GOT_WATER"):
			Global.game.play_dialogue_with_point("GYM1_GYM_GUY_5" , gym_guy.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.past_events.append("GYM1_GOT_WATER")
			Global.game.recive_item(187)
			yield(Global.game, "end_of_event")
		else:
			Global.game.play_dialogue_with_point("GYM1_GYM_GUY_6" , gym_guy.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
	if check_pos == Vector2(112, 1040) && OS.is_debug_build(): # TO BE DELETED
		Global.inventory.add_item_by_id_multiple(171, 5)
		print("Added")


func trainer_battle(npc_trainer):
	Global.game.lock_player()
	npc_trainer.seeking = false
	# Play encounter music
	npc_trainer.alert()
	yield(npc_trainer, "alert_done")
	match npc_trainer:
		trainer1:
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-MaleEncounter.ogg")
		trainer2:
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-FemaleEncounter.ogg")
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
			Global.game.play_dialogue_with_point("GYM1_TRAINER_1" , npc_trainer.get_global_transform_with_canvas().get_origin())
		trainer2:
			Global.game.play_dialogue_with_point("GYM1_TRAINER_2" , npc_trainer.get_global_transform_with_canvas().get_origin())
	yield(Global.game, "event_dialogue_end")

	match npc_trainer:
		trainer1:
			trainer1_battle()
		trainer2:
			trainer2_battle()

func trainer1_battle():
	var trainer = trainer1
	trainer.seeking = false

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.INDOOR_1
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer013.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("GYM1_TRAINER_1_DEFEAT")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("GYM1_TRAINER1_DEFEATED")
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
	bid.battle_back = bid.BattleBack.INDOOR_1
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer002.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("GYM1_TRAINER_2_DEFEAT")
	bid.victory_award = trainer.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer.defeated = true
		Global.past_events.append("GYM1_TRAINER2_DEFEATED")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()

func maira_battle():
	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_GYML
	bid.battle_back = bid.BattleBack.INDOOR_1
	bid.opponent = Opponent.new()
	bid.opponent.name = "LEADER Maria"
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer071.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_GYM_LEADER
	bid.opponent.after_battle_quote = tr("GYM1_MARIA_9")
	bid.victory_award = 1200
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD

	var poke_group = []
	var poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(35, 10) # Owten
	poke_group.append(poke)

	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(29, 10) # Feleng
	poke_group.append(poke)

	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(30, 12) # Felunge
	poke_group.append(poke)

	bid.opponent.pokemon_group = poke_group
	
	Global.game.trainer_battle(bid, false)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		Global.past_events.append("GYM1_COMPLETE")
	else:
		return
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	emit_signal("battle_done")