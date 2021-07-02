extends Node2D


var next_scene1 = null

var background_music = "res://Audio/BGM/PU-Route 01.ogg";

var type = "Outside"
var place_name = "Route 01"
var wild_battle_back = BattleInstanceData.BattleBack.FOREST

# Wild Poke table
var wild_table = [
#	 ID  chance  lowest_level highest_level
	[7,   40,   2,           3],
	[9,   30,   2,           3],
	[12,  30,   2,           3]
]

# Trainers and their defeat status
var trainer1
var trainer1_defeated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	trainer1 = $NPC_Layer/Trainer1

	Global.game.player.connect("trainer_battle", self, "trainer_battle")

	if Global.past_events.has("ROUTE1_TRAINER1_DEFEATED"):
		trainer1_defeated = true

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	print("Tainer 1 pos: " + str($NPC_Layer/Trainer1.position))
	if check_pos == $NPC_Layer/Trainer1.position:
		$NPC_Layer/Trainer1.face_player(direction)
		if !trainer1_defeated:
			trainer_battle(trainer1)
		else:
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NPC_ROUTE1_TRAINER_1_DEFEAT" , trainer1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			Global.game.release_player()
		pass
	pass

func get_grass_cells():
	return get_node("Tile Layer 1/PU_autotiles").get_used_cells()

func trainer_battle(npc_trainer):
	match npc_trainer:
		trainer1:
			Global.game.lock_player()
			# Play encounter music
			trainer1.alert()
			yield(trainer1, "alert_done")
			Global.game.get_node("Background_music").stream = load("res://Audio/ME/PU-FemaleEncounter.ogg")
			Global.game.get_node("Background_music").play()

			# Walk towards player
			trainer1.move_to_player()
			yield(trainer1, "done_movement")

			# Pre-battle talk
			Global.game.play_dialogue_with_point("NPC_ROUTE1_TRAINER_1" , trainer1.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			trainer1_battle()
	
func trainer1_battle():
	var trainer = trainer1
	print("Start Trainer1 battle")

	var bid = BattleInstanceData.new()
	bid.battle_type = bid.BattleType.SINGLE_TRAINER
	bid.battle_back = bid.BattleBack.FEILD_1
	bid.opponent = Opponent.new()
	bid.opponent.name = trainer.trainer_name
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer002.png")
	bid.opponent.opponent_type = Opponent.OPPONENT_TRAINER
	bid.opponent.after_battle_quote = tr("NPC_ROUTE1_TRAINER_1_DEFEAT")
	bid.victory_award = trainer1.trainer_reward
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer1_defeated = true
		trainer1.seeking = false
		Global.past_events.append("ROUTE1_TRAINER1_DEFEATED")
	Global.game.get_node("Background_music").stream = load(background_music)
	Global.game.get_node("Background_music").play()
	Global.game.release_player()

func get_trainers():
	var trainers = []
	trainers.append(trainer1)

	return trainers
