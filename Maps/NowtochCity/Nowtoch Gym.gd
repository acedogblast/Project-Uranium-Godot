extends Node2D

var background_music = "res://Audio/BGM/PU-Nowtoch City.ogg";

var type = "Indoors"
var place_name = "Nowtoch City Gym"


var gym_guy
var maria
var trainer1
var trainer2


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
	pass