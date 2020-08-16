extends Node

var battle_instance : BattleInstanceData
var queue : BattleQueue
var registry
var battle_logic : BattleLogic

var battler1 : Pokemon # Player's pokemon
var battler2 : Pokemon # Foe's pokemon
var battler3 : Pokemon # Player's second pokemon in double battles
var battler4 : Pokemon # Foe's second pokemonin double battles

export var effect_weight = 0.0 # Used for stat change animation
var effect_enable = false
var effect_shader

var battle_command : BattleCommand

var battle_is_over = false

var battle_debug = false

signal wait
signal EndOfBattleLoop
signal battle_complete
signal continue_pressed

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
	$CanvasLayer/ColorRect.visible = false
	$CanvasLayer/BattleInterfaceLayer/LevelUp.visible = false
	$CanvasLayer/BattleInterfaceLayer/BattleBag.visible = false
	registry = load("res://Utilities/Battle/Database/Pokemon/registry.gd").new()
	
	# Check if we are testing
	if Global.past_events.size() == 0:
		test()
		battle_debug = true
	pass

func _process(_delta):
	if effect_enable:
		effect_shader.set_shader_param("effect_weight" , effect_weight)
func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("continue_pressed")


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

	
	if battle_debug:
		battle_logic.battle_debug = true

	# Set human opponent texture
	if battle_instance.battle_type != battle_instance.BattleType.SINGLE_WILD:
		$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.texture = battle_instance.opponent.battle_texture
		$CanvasLayer/BattleGrounds/FoeBase/FoeHuman/HumanShadow.texture = battle_instance.opponent.battle_texture
	
	# Load data to Foe Bar
	$CanvasLayer/BattleInterfaceLayer/BattleBars.set_foe_bar_by_pokemon(battler2)
	
	# Load data to Foe Battler
	$CanvasLayer/BattleGrounds/FoeBase.setup_by_pokemon(battler2)
	
	# Add Foe introduction to queue
	match battle_instance.battle_type:
		battle_instance.BattleType.SINGLE_TRAINER:
			$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.visible = true
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
			$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.visible = true
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
		battle_instance.BattleType.SINGLE_WILD:
			battle_instance.opponent.name = battler2.name
			$CanvasLayer/BattleGrounds/FoeBase/FoeHuman.hide()
			# Set battler2 sprite
			var poke = $CanvasLayer/BattleGrounds/FoeBase/Battler
			poke.position = Vector2(140,0)
			poke.scale = Vector2(2,2)
			poke.show()

			var action = BattleQueueAction.new()
			action.type = action.BATTLE_GROUNDS_POS_CHANGE
			action.battle_grounds_pos_change = $CanvasLayer/BattleGrounds.BattlePositions.INTRO_FADE
			queue.push(action)

			action = BattleQueueAction.new()
			action.type = action.WILD_INTRO
			queue.push(action)

			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = "WILD " + battle_instance.opponent.name + " appeared!"
			queue.push(action)




	# If human opponent add ball toss.
	if battle_instance.battle_type == battle_instance.BattleType.RIVAL or battle_instance.battle_type == battle_instance.BattleType.SINGLE_TRAINER:
		var action = BattleQueueAction.new()
		action.type = action.FOE_BALLTOSS
		queue.push(action)
	
	
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
				print("Battle Error: Action Queue is empty")
		else:
			call_deferred("battle_loop")
			yield(self, "EndOfBattleLoop")
	
	# After battle comands
	print("Battle is over.")
	emit_signal("battle_complete")


func test():
	var BID = load("res://Utilities/Battle/Classes/BattleInstanceData.gd")
	var OPP = load("res://Utilities/Battle/Classes/Opponent.gd")
	var bid = BID.new()
	bid.battle_type = BID.BattleType.SINGLE_WILD
	bid.battle_back = BID.BattleBack.FOREST
	bid.opponent = OPP.new()
	#bid.opponent.name = "Theo"
	bid.opponent.opponent_type = Opponent.OPPONENT_WILD
	bid.opponent.ai = load("res://Utilities/Battle/Classes/AI.gd").new()
	bid.opponent.ai.AI_Behavior = bid.opponent.ai.WILD
	#bid.opponent.after_battle_quote = "EVENT_MOKI_LAB_FIRST_POK_Battle_WIN"

	var poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(1,5)
	bid.opponent.pokemon_group.append(poke)
	
	bid.opponent.battle_texture = load("res://Graphics/Characters/trainer086.png")
	

	poke = Pokemon.new()
	poke.set_basic_pokemon_by_level(3,5)
	poke.experience += 75
	Global.pokemon_group.append(poke)
	Global.TrainerGender = 0
	
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
		_:
			print("Battle Error: Invalid opponent texture on function set_Vs_textures")
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
	var battle_back = $CanvasLayer/BattleGrounds/BattleBack
	var player_base = $CanvasLayer/BattleGrounds/PlayerBase
	var foe_base = $CanvasLayer/BattleGrounds/FoeBase
	match battle_instance.battle_back:
		battle_instance.BattleBack.INDOOR_1:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgIndoorA.png")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseIndoorA.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseIndoorA.png")
		battle_instance.BattleBack.FOREST:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgForest.PNG")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseForest.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseForest.png")
		battle_instance.BattleBack.FEILD_1:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgField.PNG")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseField.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseField.png")
		battle_instance.BattleBack.MOUNTAIN:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgMountain.png")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseMountain.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseMountain.png")
		battle_instance.BattleBack.CAVE:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgCave.png")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseCave.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseCave.png")
		battle_instance.BattleBack.CITY:
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgCity.png")
			player_base.texture = load("res://Graphics/Battlebacks/playerbaseCity.png")
			foe_base.texture = load("res://Graphics/Battlebacks/enemybaseCity.png")
		_:
			print("Battle Error: battle_back is not implemented or specified. Defaulting to battlebgIndoorA.png")
			battle_back.texture = load("res://Graphics/Battlebacks/battlebgIndoorA.png")
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
			if action.battle_grounds_pos_change == $CanvasLayer/BattleGrounds.BattlePositions.CAPTURE_ZOOM:
				$CanvasLayer/BattleInterfaceLayer/BattleBars/PlayerBar.visible = false
				$CanvasLayer/BattleGrounds/PlayerBase.visible = false
			$CanvasLayer/BattleGrounds.setPosistion(action.battle_grounds_pos_change)
			yield($CanvasLayer/BattleGrounds, "wait")
			if action.battle_grounds_pos_change == $CanvasLayer/BattleGrounds.BattlePositions.CAPTURE_ZOOM_BACK:
				$CanvasLayer/BattleInterfaceLayer/BattleBars/PlayerBar.visible = true
				$CanvasLayer/BattleGrounds/PlayerBase.visible = true
		action.BATTLE_TEXT:
			$CanvasLayer/BattleInterfaceLayer/Message/Label.text = action.battle_text
			$CanvasLayer/BattleInterfaceLayer/Message.visible = true
			if action.press_to_continue:
				$CanvasLayer/BattleInterfaceLayer/Message/Arrow.visible = true
				yield(self, "continue_pressed")
			else:
				$CanvasLayer/BattleInterfaceLayer/Message/Arrow.visible = false
				yield(get_tree().create_timer(2.0), "timeout")
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
					var percent = float(battler1.current_hp) / battler1.hp
					print("bar slide for player")
					bars.call_deferred("slide_player_bar", percent, battler1.current_hp)
				2: # Foe
					var percent = float(battler2.current_hp) / battler2.hp
					print("bar slide for foe")
					bars.call_deferred("slide_foe_bar", percent)
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
			$CanvasLayer/BattleInterfaceLayer/BattleBars.visible = false

			
			if !action.run_away:
				# Play victory music
				var victory_music
				match battle_instance.battle_type:
					BattleInstanceData.BattleType.SINGLE_TRAINER, BattleInstanceData.BattleType.RIVAL:
						victory_music = load("res://Audio/ME/PU-Victory Trainer Battle.ogg")
					BattleInstanceData.BattleType.SINGLE_WILD, BattleInstanceData.BattleType.DOUBLE_WILD:
						victory_music = load("res://Audio/BGM/PU-WildVictory.ogg") # There is another version in ME. Not sure which one to use.
					BattleInstanceData.BattleType.SINGLE_GYML, BattleInstanceData.BattleType.DOUBLE_GYML:
						victory_music = load("res://Audio/ME/PU-GymVictory.ogg")
					# TODO: Fill other battle types
				$CanvasLayer/AudioStreamPlayer.stop()
				$CanvasLayer/AudioStreamPlayer.stream = victory_music
				$CanvasLayer/AudioStreamPlayer.play()

				# Closing Battle quote
				var message = Global.TrainerName + " defeated\n"
				match battle_instance.opponent.opponent_type:
					Opponent.OPPONENT_RIVAL:
						message += "RIVAL "
					Opponent.OPPONENT_TRAINER:
						message += "TRAINER "
					Opponent.OPPONENT_WILD:
						message += "WILD "
				message += battle_instance.opponent.name
				$CanvasLayer/BattleInterfaceLayer/Message/Label.text = message
				$CanvasLayer/BattleInterfaceLayer/Message.visible = true
				$CanvasLayer/BattleInterfaceLayer/Message/Arrow.visible = true
				yield(self, "continue_pressed")
				$CanvasLayer/BattleInterfaceLayer/Message.visible = false

				# If applicable, show opponent win quote:
				if battle_instance.opponent.opponent_type == Opponent.OPPONENT_RIVAL:
					$CanvasLayer/BattleGrounds/AnimationPlayer.play("Opponent_Quote")
					yield($CanvasLayer/BattleGrounds/AnimationPlayer, "animation_finished")

					message = tr(battle_instance.opponent.after_battle_quote)
					$CanvasLayer/BattleInterfaceLayer/Message/Label.text = message
					$CanvasLayer/BattleInterfaceLayer/Message.visible = true
					yield(self, "continue_pressed")

					# Show money earned
					Global.money += battle_instance.victory_award
					$CanvasLayer/BattleInterfaceLayer/Message/Label.text = Global.TrainerName + " got $" + str(battle_instance.victory_award) + "\nfor winning!"
					yield(self, "continue_pressed")
			
			# Fade out of battle
			$CanvasLayer/BattleInterfaceLayer/Message.visible = false
			$CanvasLayer/BattleGrounds/AnimationPlayer.play("FadeOut")
			yield($CanvasLayer/BattleGrounds/AnimationPlayer, "animation_finished")
			$CanvasLayer/AudioStreamPlayer.stop()

			if action.winner == action.PLAYER_WIN:
				print("Player wins.")
			if action.winner == action.FOE_WIN:
				print("Foe wins.")
		action.STAT_CHANGE_ANIMATION:
			var effect
			var animation
			var sound
			
			match action.damage_target_index:
				1:
					animation = $CanvasLayer/BattleGrounds/PlayerBase/Battler/AnimationPlayer
					sound = $CanvasLayer/BattleGrounds/PlayerBase/Ball/AudioStreamPlayer
					effect_shader = $CanvasLayer/BattleGrounds/PlayerBase/Battler/Sprite.material
				2:
					animation = $CanvasLayer/BattleGrounds/FoeBase/Battler/AnimationPlayer
					sound = $CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer
					effect_shader = $CanvasLayer/BattleGrounds/FoeBase/Battler/Sprite.material
				_:
					print("Battle Error: Unimplemeted stat animation index")
			if action.stat_change_increase:
				effect = load("res://Graphics/Pictures/StatUp.png")
				sound.stream = load("res://Audio/SE/increase.wav")
				effect_shader.set_shader_param("effect_speed", 1.0)
			else:
				effect = load("res://Graphics/Pictures/StatDown.png")
				sound.stream = load("res://Audio/SE/decrease.wav")
				effect_shader.set_shader_param("effect_speed", -1.0)
			effect.set_flags(Texture.FLAG_REPEAT)
			effect_shader.set_shader_param("effect", effect)
			sound.play()
			effect_enable = true
			animation.play("StatChange")
			yield(animation, "animation_finished")
			effect_enable = false
		action.WILD_INTRO:
			#Play cry:
			$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.stream = load(battler2.get_cry())
			$CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer.play()

			# Slide battle bar
			$CanvasLayer/BattleInterfaceLayer/BattleBars.visible = true
			$CanvasLayer/BattleInterfaceLayer/BattleBars/FoeBar.visible = true
			$CanvasLayer/BattleInterfaceLayer/BattleBars/FoeBar.get_node("AnimationPlayer").play("Slide")

			yield($CanvasLayer/BattleGrounds/FoeBase/Ball/AudioStreamPlayer, "finished")
		action.HEAL:
			#if action.heal_sound:
				#var audioplayer = $CanvasLayer/BattleInterfaceLayer/BattleBars/AudioStreamPlayer
				#var sound = load("I can not find the file!")
			var bars = $CanvasLayer/BattleInterfaceLayer/BattleBars
			match action.damage_target_index:
				1: # Player
					var percent = float(battler1.current_hp) / battler1.hp
					print(percent)
					bars.call_deferred("slide_player_bar", percent, battler1.current_hp)
				2: # Foe
					var percent = float(battler2.current_hp) / battler2.hp
					print(percent)
					bars.call_deferred("slide_foe_bar", percent)
			yield(bars, "finished")
		action.LEVEL_UP_SE:
			var audioplayer = $CanvasLayer/BattleInterfaceLayer/BattleBars/AudioStreamPlayer
			var sound = load("res://Audio/ME/BW_lvup.ogg")
			sound.loop = false
			$CanvasLayer/BattleInterfaceLayer/BattleBars/PlayerBar/LevelLable.text = " " + str(action.level)
			audioplayer.stream = sound
			audioplayer.play()
			# Reset exp bar
			$CanvasLayer/BattleInterfaceLayer/BattleBars.call_deferred("reset_player_exp_bar")
		action.LEVEL_UP:
			# Update player bar
			$CanvasLayer/BattleInterfaceLayer/BattleBars.set_player_bar_by_pokemon(battler1)

			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/MaxHP/Value.text = "+" + str(action.level_stat_changes.hp_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Attack/Value.text = "+" + str(action.level_stat_changes.attack_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Defense/Value.text = "+" + str(action.level_stat_changes.defense_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/SpAtck/Value.text = "+" + str(action.level_stat_changes.spAtk_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/SpDef/Value.text = "+" + str(action.level_stat_changes.spDef_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Speed/Value.text = "+" + str(action.level_stat_changes.speed_change)
			$CanvasLayer/BattleInterfaceLayer/LevelUp.visible = true
		
			yield(self, "continue_pressed")

			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/MaxHP/Value.text = str(battler1.hp)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Attack/Value.text = str(battler1.attack)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Defense/Value.text = str(battler1.defense)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/SpAtck/Value.text = str(battler1.sp_attack)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/SpDef/Value.text = str(battler1.sp_defense)
			$CanvasLayer/BattleInterfaceLayer/LevelUp/Box/Improve/Speed/Value.text = str(battler1.speed)
		
			yield(self, "continue_pressed")
			$CanvasLayer/BattleInterfaceLayer/LevelUp.visible = false
		action.UPDATE_MAJOR_AILMENT: # To be remade as update bars
			var battler1_ailment = $CanvasLayer/BattleInterfaceLayer/BattleBars/PlayerBar/MajorAilment
			var battler2_ailment = $CanvasLayer/BattleInterfaceLayer/BattleBars/FoeBar/MajorAilment
			match action.damage_target_index:
				1:
					match battler1.major_ailment:
						null:
							battler1_ailment.hide()
						_:
							battler1_ailment.frame = battler1.major_ailment
							battler1_ailment.show()
				2:
					match battler2.major_ailment:
						null:
							battler2_ailment.hide()
						_:
							battler2_ailment.frame = battler2.major_ailment
							battler2_ailment.show()
		action.ESCAPE_SE:
			var audioplayer = $CanvasLayer/BattleInterfaceLayer/BattleBars/AudioStreamPlayer
			var sound = load("res://Audio/BGS/Flee.ogg")
			sound.loop = false
			audioplayer.stream = sound
			audioplayer.play()
		action.BALL_CAPTURE_TOSS:
			$CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer.play("Capture_Throw")
			yield($CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer, "animation_finished")
		action.BALL_SHAKE:
			$CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer.play("BallShake")
			yield($CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer, "animation_finished")
		action.BALL_BROKE:
			$CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer.play("BallBreak")
			yield($CanvasLayer/BattleGrounds/FoeBase/Ball/AnimationPlayer, "animation_finished")
		action.BALL_CAPTURE_SONG:
			$CanvasLayer/AudioStreamPlayer.stop()
			$CanvasLayer/AudioStreamPlayer.stream = "res://Audio/ME/PU-PokemonObtained.ogg"
			$CanvasLayer/AudioStreamPlayer.play()
		action.SET_BALL:
			$CanvasLayer/BattleGrounds/FoeBase.set_ball(action.ball_type)
		
		_:
			print("Battle Error: Battle Action type did not match any correct value.")

	emit_signal("EndOfBattleLoop")
func get_battle_command():
	var menu = $CanvasLayer/BattleInterfaceLayer/BattleComandSelect
	menu.get_node("AnimationPlayer").play("Slide")
	menu.visible = true
	menu.start(battler1.name)
	yield($CanvasLayer/BattleInterfaceLayer/BattleComandSelect, "command_received")

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
	
	if battler2.move_1 != null:
		snap.poke_move_list.append(battler2.move_1.name)
	if battler2.move_2 != null:
		snap.poke_move_list.append(battler2.move_2.name)
	if battler2.move_3 != null:
		snap.poke_move_list.append(battler2.move_3.name)
	if battler2.move_4 != null:
		snap.poke_move_list.append(battler2.move_4.name)
	return snap
