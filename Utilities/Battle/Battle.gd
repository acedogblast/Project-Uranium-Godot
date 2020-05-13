extends Node

var battle_instance : BattleInstanceData
var queue : BattleQueue
var registry
var battle_logic : BattleLogic

var battler1 : Pokemon # Player's pokemon
var battler2 : Pokemon # Foe's pokemon
var battler3 : Pokemon # Player's second pokemon in double battles
var battler4 : Pokemon # Foe's second pokemonin double battles


var battle_command : BattleCommand

var battle_is_over = false

signal wait
signal EndOfBattleLoop
#signal command_received

func _ready():
	$CanvasLayer/BattleGrounds.visible = false
	$CanvasLayer/TransitionEffects.visible = false
	$CanvasLayer/BattleInterfaceLayer/BattleBars.visible = false
	$CanvasLayer/BattleInterfaceLayer/Message.visible = false
	$CanvasLayer/BattleInterfaceLayer/PlayerToss.visible = false
	$CanvasLayer/BattleInterfaceLayer/BattleComandSelect.visible = false
	$CanvasLayer/BattleGrounds/ColorRect.color = Color("000000")
	$CanvasLayer/BattleGrounds/ColorRect.visible = true
	$CanvasLayer/BattleInterfaceLayer/BattleAttackSelect.visible = false
	registry = load("res://Utilities/Battle/Database/Pokemon/registry.gd").new()
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
	yield(self, "wait")
	# Initialize BattleQueue
	queue = BattleQueue.new()
	
	# Set first wave pokemon
	battler1 = Global.pokemon_group[0]
	battler2 = battle_instance.opponent.pokemon_group[0]
	battle_logic = load("res://Utilities/Battle/BattleLogic.gd").new(battler1, battler2 , battle_instance)
	# Set human opponent texture
	if battle_instance.battle_type != battle_instance.BattleType.SINGLE_WILD:
		$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.texture = battle_instance.opponent.battle_texture
		$CanvasLayer/BattleGrounds/FoeBase/FoeHuman/HumanShadow.texture = battle_instance.opponent.battle_texture
	
	# Add Foe introduction to queue
	match battle_instance.battle_type:
		battle_instance.BattleType.SINGLE_TRAINER:
			var action = BattleQueueAction.new()
			action.type = action.BATTLE_GROUNDS_POS_CHANGE
			action.battle_grounds_pos_change = $CanvasLayer/BattleGrounds.BattlePositions.INTRO_FADE
			queue.push(action)
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = "TRAINER " + battle_instance.opponent.name + "\nwould like to battle!"
			queue.push(action)
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = "TRAINER " + battle_instance.opponent.name + " sent\nout " + battle_instance.opponent.pokemon_group[0].name + "!"
			queue.push(action)
		battle_instance.BattleType.RIVAL:
			var action = BattleQueueAction.new()
			action.type = action.BATTLE_GROUNDS_POS_CHANGE
			action.battle_grounds_pos_change = $CanvasLayer/BattleGrounds.BattlePositions.INTRO_FADE
			queue.push(action)
			
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = "RIVAL Theo\nwould like to battle!"
			queue.push(action)
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = "RIVAL Theo sent\nout " + battler2.name + "!"
			queue.push(action)
	# If human opponent add ball toss.
	if battle_instance.battle_type == battle_instance.BattleType.RIVAL or battle_instance.battle_type == battle_instance.BattleType.SINGLE_TRAINER:
		var action = BattleQueueAction.new()
		action.type = action.FOE_BALLTOSS
		
		
		
		queue.push(action)
		pass
	# Load data to Foe Bar
	$CanvasLayer/BattleInterfaceLayer/BattleBars.set_foe_bar_by_pokemon(battler2)
	
	
	# Load data to Foe Battler
	$CanvasLayer/BattleGrounds/FoeBase.setup_by_pokemon(battler2)

	
	# Add Player toss to queue
	var action = BattleQueueAction.new()
	action.type = action.BATTLE_GROUNDS_POS_CHANGE
	action.battle_grounds_pos_change = $CanvasLayer/BattleGrounds.BattlePositions.PLAYER_TOSS
	queue.push(action)
	
	# Load data to Player Bar
	$CanvasLayer/BattleInterfaceLayer/BattleBars.set_player_bar_by_pokemon(battler1)
	$CanvasLayer/BattleGrounds/PlayerBase.setup_by_pokemon(battler1)

	# Go text
	action = BattleQueueAction.new()
	action.type = action.BATTLE_TEXT
	action.battle_text = "Go " + battler1.name + "!"
	queue.push(action)

	# Player toss animations
	action = BattleQueueAction.new()
	action.type = action.PLAYER_BALLTOSS
	queue.push(action)

	# Change view to CENTER 
	action = BattleQueueAction.new()
	action.type = action.BATTLE_GROUNDS_POS_CHANGE
	action.battle_grounds_pos_change = $CanvasLayer/BattleGrounds.BattlePositions.CENTER
	queue.push(action)
	# Start the battle loop until player wins or losses.
	
	while battle_is_over == false:
		if queue.is_empty(): # If queue is empty, get player battle comand.
			# Pop up battle comand menu.
			print("Getting comand from player")
			get_battle_command()

			# Get Foe command by AI while player chooses.
			var battle_snapshot = get_battle_snapshot()
			var foe_command = battle_instance.opponent.ai.get_command(battle_snapshot)

			yield(self, "wait") # wait for player comand.

			queue = battle_logic.generate_action_queue(battle_command, foe_command)

			if queue.is_empty():
				print("This should not be possible")
		else:
			call_deferred("battle_loop")
			yield(self, "EndOfBattleLoop")
	
	# After battle comands
	print("Battle is over.")


func test():
	var BID = load("res://Utilities/Battle/Classes/BattleInstanceData.gd")
	var OPP = load("res://Utilities/Battle/Classes/Opponent.gd")
	var bid = BID.new()
	bid.battle_type = BID.BattleType.RIVAL
	bid.battle_back = BID.BattleBack.INDOOR_1
	bid.opponent = OPP.new()
	bid.opponent.name = "Theo"
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.TESTING_1

	var poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	bid.opponent.pokemon_group.append(poke)
	
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer086.png")
	

	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(3,5)
	Global.pokemon_group.append(poke)
	Global.TrainerGender = 2
	
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
			$CanvasLayer/BattleInterfaceLayer/PlayerToss.texture = load("res://Graphics/Characters/trback000.png")
		1:
			$CanvasLayer/TransitionEffects/Vs/PlayerBanner.texture = load("res://Graphics/Transitions/vsTrainer9.png")
			$CanvasLayer/BattleInterfaceLayer/PlayerToss.texture = load("res://Graphics/Characters/trback009.png")
		2:
			$CanvasLayer/TransitionEffects/Vs/PlayerBanner.texture = load("res://Graphics/Transitions/vsTrainer1.png")
			$CanvasLayer/BattleInterfaceLayer/PlayerToss.texture = load("res://Graphics/Characters/trback001.png")
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
	emit_signal("wait")


func battle_loop():
	var action = queue.pop()
	match action.type:
		action.BATTLE_GROUNDS_POS_CHANGE:
			$CanvasLayer/BattleGrounds.setPosistion(action.battle_grounds_pos_change)
			yield($CanvasLayer/BattleGrounds, "wait")
		action.BATTLE_TEXT:
			$CanvasLayer/BattleInterfaceLayer/Message/Label.text = action.battle_text
			$CanvasLayer/BattleInterfaceLayer/Message.visible = true
			var t = Timer.new()
			t.set_wait_time(2) # Later add animation for text typing.
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			$CanvasLayer/BattleInterfaceLayer/Message.visible = false
		action.FOE_BALLTOSS:
			# if human opponent is visable play fadeing animation
			if $CanvasLayer/BattleGrounds/FoeBase/FoeHuman.visible == true:
				$CanvasLayer/BattleGrounds/FoeBase/FoeHuman/AnimationPlayer.play("FadeOut")
			$CanvasLayer/BattleGrounds/FoeBase/Ball.visible = true
			$CanvasLayer/BattleGrounds.foe_unveil()
			$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.visible = false
			yield($CanvasLayer/BattleGrounds, "unveil_finished")
		action.PLAYER_BALLTOSS:
			$CanvasLayer/BattleGrounds.player_unveil()
			yield($CanvasLayer/BattleGrounds, "unveil_finished")
		action.DAMAGE:
			# Play damage sound
			var audioplayer = $CanvasLayer/BattleInterfaceLayer/BattleBars/AudioStreamPlayer
			var sound
			var effect
			if action.damage_effectiveness > 2.0: # Super damage
				sound = load("res://Audio/SE/superdamage.wav")
				effect = "SuperDamage"
			elif action.damage_effectiveness < 1.0: # Low damage
				sound = load("res://Audio/SE/notverydamage.wav")
				effect = "LowDamage"
			else: # Normal damage
				sound = load("res://Audio/SE/normaldamage.wav")
				effect = "NormalDamage"
			audioplayer.stream = sound
			audioplayer.play()
			# Play damage animation
			match action.damage_target_index:
				1: # Player
					$CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer.play(effect)
					yield($CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer, "animation_finished")
				2: # Foe
					$CanvasLayer/BattleGrounds/FoeBase/Battler/AnimationPlayer.play(effect)
					yield($CanvasLayer/BattleGrounds/FoeBase/Battler/AnimationPlayer, "animation_finished")
			# Play hp bar slide
			var bars = $CanvasLayer/BattleInterfaceLayer/BattleBars
			match action.damage_target_index:
				1: # Player
					#print("bar slide for player")
					bars.slide_player_bar(float(battler1.current_hp) / battler1.hp, battler1.current_hp)
				2: # Foe
					#print("bar slide for foe")
					bars.slide_foe_bar(float(battler2.current_hp) / battler2.hp)
			yield(bars, "finished")
		action.FAINT:
			match action.damage_target_index:
				1:
					$CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer.stream = load(battler1.get_cry())
					$CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer.play()
					yield($CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer, "finished")
					$CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer.play("FaintPlayer")

					$CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer.stream = load("res://Audio/SE/faint.wav")
					$CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer.play()
					yield($CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer, "animation_finished")
					$CanvasLayer/BattleGrounds/PlayerBase/Battler.visible = false
				2:
					$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.stream = load(battler2.get_cry())
					$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.play()
					yield($CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer, "finished")
					$CanvasLayer/BattleGrounds/FoeBase/Battler/AnimationPlayer.play("FaintFoe")

					$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.stream = load("res://Audio/SE/faint.wav")
					$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.play()

					yield($CanvasLayer/BattleGrounds/FoeBase/Battler/AnimationPlayer, "animation_finished")
					$CanvasLayer/BattleGrounds/FoeBase/Battler.visible = false

		action.EXP_GAIN:
			var percent : float = action.exp_gain_percent
			$CanvasLayer/BattleInterfaceLayer/BattleBars.slide_player_exp_bar(percent)
			yield($CanvasLayer/BattleInterfaceLayer/BattleBars, "finished")
		action.BATTLE_END:
			battle_is_over = true
			if action.winner == action.PLAYER_WIN:
				print("Player wins.")
			if action.winner == action.FOE_WIN:
				print("Foe wins.")

		_:
			print("Battle Error: Battle Action type did not match any correct value.")

	emit_signal("EndOfBattleLoop")
func get_battle_command():
	var menu = $CanvasLayer/BattleInterfaceLayer/BattleComandSelect
	menu.get_node("AnimationPlayer").play("Slide")
	menu.visible = true
	menu.start(battler1.name)
	$CanvasLayer/BattleInterfaceLayer/BattleAttackSelect.reset()
	yield($CanvasLayer/BattleInterfaceLayer/BattleAttackSelect, "command_received")
	
	print("Command recived")

	emit_signal("wait")
func get_battle_snapshot():
	var snap = load("res://Utilities/Battle/Classes/BattleSnapshot.gd").new()
	snap.foe_poke_id = int(battler1.ID)
	snap.foe_hp_percentage = float(battler1.current_hp) / float(battler1.hp)
	snap.foe_poke_level = int(battler1.level)
	var index := 0
	for p in battle_instance.opponent.pokemon_group:
		if p == battler2:
			break
		else:
			index = index + 1
	snap.poke_index = int(index)
	snap.poke_remaining_hp = int(battler2.current_hp)
	snap.poke_max_hp = int(battler2.hp)
	snap.poke_level = int(battler2.level)
	for p in battle_instance.opponent.pokemon_group:
		snap.poke_list.push_back(int(p.ID))
	return snap
