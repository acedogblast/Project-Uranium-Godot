extends Node

var battle_instance : BattleInstanceData

func _ready():
	$CanvasLayer/BattleGrounds.visible = false
	$CanvasLayer/TransitionEffects.visible = false
	$CanvasLayer/BattleInterfaceLayer/BattleBars.visible = false
	$CanvasLayer/BattleInterfaceLayer/Message.visible = false
	$CanvasLayer/BattleInterfaceLayer/BattleComand.visible = false
	
	
	test()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass
func Start_Battle(bid : BattleInstanceData):
	battle_instance = bid
	# Set battle resources
	set_battle_music()
	set_battle_back()
	set_gender_textures()
	# Start TransistionEffects
	run_transition()
	
	
	
	pass

func test():
	var BID = load("res://Utilities/Battle/Classes/BattleInstanceData.gd")
	var OPP = load("res://Utilities/Battle/Classes/Opponent.gd")
	var bid = BID.new()
	bid.battle_type = BID.BattleType.SINGLE_GYML
	bid.battle_back = BID.BattleBack.INDOOR_1
	bid.opponent = OPP.new()
	bid.opponent.name = "Maria"
	Start_Battle(bid)

func set_Vs_textures():
	match battle_instance.opponent.name:
		"Theo":
			$CanvasLayer/TransitionEffects/Vs/OpponentBanner.texture = load("res://Graphics/Transitions/vsTrainer86.png")
			$CanvasLayer/TransitionEffects/Vs/SpriteLeft.texture = load("res://Graphics/Transitions/vsBar86.png")
			$CanvasLayer/TransitionEffects/Vs/SpriteRight.texture = load("res://Graphics/Transitions/vsBar86.png")
		"Maria":
			$CanvasLayer/TransitionEffects/Vs/OpponentBanner.texture = load("res://Graphics/Transitions/vsTrainer71.png")
			$CanvasLayer/TransitionEffects/Vs/SpriteLeft.texture = load("res://Graphics/Transitions/vsBar71.png")
			$CanvasLayer/TransitionEffects/Vs/SpriteRight.texture = load("res://Graphics/Transitions/vsBar71.png")
	$CanvasLayer/TransitionEffects/Vs/SpriteLeft.texture.flags = Texture.FLAG_REPEAT
	$CanvasLayer/TransitionEffects/Vs/SpriteRight.texture.flags = Texture.FLAG_REPEAT
	$CanvasLayer/TransitionEffects/Vs/SpriteLeft.region_enabled = true
	$CanvasLayer/TransitionEffects/Vs/SpriteRight.region_enabled = true
	$CanvasLayer/TransitionEffects/Vs/SpriteLeft.region_rect = Rect2(Vector2(0,0), Vector2(256,128))
	$CanvasLayer/TransitionEffects/Vs/SpriteRight.region_rect = Rect2(Vector2(0,0), Vector2(256,128))
	
	
	
	$CanvasLayer/TransitionEffects/Vs/OpponentBanner/Label.bbcode_text = "[center]" + battle_instance.opponent.name
func set_gender_textures():
	match Global.TrainerGender:
		0:
			$CanvasLayer/TransitionEffects/Vs/PlayerBanner.texture = load("res://Graphics/Transitions/vsTrainer0.png")
			$CanvasLayer/BattleGrounds/PlayerToss.texture = load("res://Graphics/Characters/trback000.png")
		1:
			$CanvasLayer/TransitionEffects/Vs/PlayerBanner.texture = load("res://Graphics/Transitions/vsTrainer9.png")
			$CanvasLayer/BattleGrounds/PlayerToss.texture = load("res://Graphics/Characters/trback009.png")
		2:
			$CanvasLayer/TransitionEffects/Vs/PlayerBanner.texture = load("res://Graphics/Transitions/vsTrainer1.png")
			$CanvasLayer/BattleGrounds/PlayerToss.texture = load("res://Graphics/Characters/trback001.png")
	$CanvasLayer/TransitionEffects/Vs/PlayerBanner/Label.bbcode_text = "[center]" + Global.TrainerName

func set_battle_music():
	match battle_instance.battle_type:
		battle_instance.BattleType.RIVAL:
			$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-TheoBattle.ogg")
		battle_instance.BattleType.SINGLE_WILD:
			$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-WildPokeBattle.ogg")
		battle_instance.BattleType.SINGLE_TRAINER:
			$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-TrainerPokeBattle.ogg")
		battle_instance.BattleType.SINGLE_GYML:
			$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-GymBattle.ogg")
		_:
			print("Battle Error: battle_type is not implemented or specified. Defaulting to PU-TrainerPokeBattle.ogg")
			$CanvasLayer/AudioStreamPlayer.stream = load("res://Audio/BGM/PU-TrainerPokeBattle.ogg")
	$CanvasLayer/AudioStreamPlayer.play()
func set_battle_back():
	match battle_instance.battle_back:
		battle_instance.BattleBack.INDOOR_1:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgIndoorA.png")
		battle_instance.BattleBack.FOREST:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgForest.PNG")
		battle_instance.BattleBack.FEILD_1:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgField.PNG")
		battle_instance.BattleBack.MOUNTAIN:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgMountain.png")
		battle_instance.BattleBack.CAVE:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgCave.png")
		battle_instance.BattleBack.CITY:
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgCity.png")
		_:
			print("Battle Error: battle_back is not implemented or specified. Defaulting to battlebgIndoorA.png")
			$CanvasLayer/BattleGrounds/BattleBack.texture = load("res://Graphics/Battlebacks/battlebgIndoorA.png")
func run_transition():
	$CanvasLayer/TransitionEffects.visible = true
	$CanvasLayer/TransitionEffects/Vs.visible = false
	$CanvasLayer/TransitionEffects/AnimationPlayer.play("GreyFlashing")
	yield($CanvasLayer/TransitionEffects/AnimationPlayer, "animation_finished")
	$CanvasLayer/TransitionEffects/GreyFlash.visible = false
	if battle_instance.battle_type == battle_instance.BattleType.RIVAL or battle_instance.battle_type == battle_instance.BattleType.SINGLE_GYML:
		set_Vs_textures()
		
		$CanvasLayer/TransitionEffects/Vs.visible = true
		$CanvasLayer/TransitionEffects/Vs/AnimationPlayer.play("SlideBars")
		yield($CanvasLayer/TransitionEffects/Vs/AnimationPlayer, "animation_finished")
	$CanvasLayer/TransitionEffects.visible = false
	$CanvasLayer/BattleGrounds.visible = true



