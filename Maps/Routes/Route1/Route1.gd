extends Node2D


var next_scene1 = null

var background_music = "res://Audio/BGM/PU-Route 01.ogg";

var type = "Outside"
var place_name = "Route 01"

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
	if Global.past_events.has("ROUTE1_TRAINER1_DEFEATED"):
		trainer1_defeated = true

func interaction(collider, direction): # collider is a Vector2 of the position of object to interact
	var npc_collider = Vector2(collider.x + 16, collider.y)

	if npc_collider == $NPC_Layer/Trainer1.position:
		$NPC_Layer/Trainer1.face_player(direction)
		if !trainer1_defeated:
			trainer1_battle()
		pass
	pass

func get_grass_cells():
	return get_node("Tile Layer 1/PU_autotiles").get_used_cells()

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
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	bid.opponent.pokemon_group = trainer.get_poke_group()
	
	Global.game.trainer_battle(bid)
	yield(Global.game.battle, "battle_complete")
	if Global.game.battle.player_won:
		trainer1_defeated = true
		Global.past_events.append("ROUTE1_TRAINER1_DEFEATED")