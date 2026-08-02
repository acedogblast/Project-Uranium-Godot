extends Object
class_name BattleLogic

var turn_order = []
var queue
enum {B1 = 1, B2 = 2, B3 = 3, B4 = 4} # Used for turn order and indicating which poke in battle

var battler1 : Pokemon # Player's pokemon
var battler2 : Pokemon # Foe's pokemon
var battler3 : Pokemon # Player's second pokemon in double battles
var battler4 : Pokemon # Foe's second pokemonin double battles

var battler1_stat_stage : BattleStatStage
var battler2_stat_stage : BattleStatStage
var battler3_stat_stage : BattleStatStage
var battler4_stat_stage : BattleStatStage

var battler1_effects = []
var battler2_effects = []
var battler3_effects = []
var battler4_effects = []

var battler1_past_moves = []
var battler2_past_moves = []
var battler3_past_moves = []
var battler4_past_moves = []

var battle_instance : BattleInstanceData

var item_database
var pokemon_registry

var battle_debug = true

var escape_attempts = 0
var can_escape = false

var double_battle = false

func _init(b1, b2 , bid):
	battler1 = b1
	battler2 = b2
	battler1_stat_stage = BattleStatStage.new()
	battler2_stat_stage = BattleStatStage.new()
	battle_instance = bid
	item_database = load("res://Utilities/Items/database.gd").new()
	pokemon_registry = registry.new()
	pass
func generate_action_queue(player_command : BattleCommand, foe_command : BattleCommand):
	queue = BattleQueue.new()
	var action
	get_turn_order(player_command, foe_command)
	
	if can_escape == true && player_command.command_type == player_command.RUN:
		action = BattleQueueAction.new()
		action.type = action.ESCAPE_SE
		queue.push(action)
		
		action = BattleQueueAction.new()
		action.type = action.BATTLE_TEXT
		action.battle_text = bt("Got away safely!")
		action.press_to_continue = true
		queue.push(action)

		action = BattleQueueAction.new()
		action.type = action.BATTLE_END
		action.winner = action.PLAYER_WIN
		action.run_away = true
		queue.push(action)
		return queue
	if can_escape == false && player_command.command_type == player_command.RUN:
		action = BattleQueueAction.new()
		action.type = action.BATTLE_TEXT
		action.battle_text = bt("Can't escape!", [])
		queue.push(action)
	
	if player_command.command_type == player_command.USE_BAG_ITEM:
		var item = load("res://Utilities/Items/database.gd").new().get_item_by_id(player_command.item)
		print("Using item: " + item.name)

		if player_command.item >= 170 && player_command.item <= 181: # Potion / Medicin
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = bt("{1} used the\n{2}.", [Global.TrainerName, tr(item.name)])
			queue.push(action)
			
			var effected_poke = Global.pokemon_group[player_command.attack_target]

			match item.id:
				170: # Potion
					print("Before heal hp: " + str(effected_poke.current_hp))
					var heal_amount = 20
					if effected_poke.current_hp + heal_amount > effected_poke.hp:
						effected_poke.current_hp = effected_poke.hp
					else:
						effected_poke.current_hp += heal_amount
					print("After heal hp: " + str(effected_poke.current_hp))

				171, 187: # Super Potion or Fresh Water
					var heal_amount = 50
					if effected_poke.current_hp + heal_amount > effected_poke.hp:
						effected_poke.current_hp = effected_poke.hp
					else:
						effected_poke.current_hp += heal_amount
				172: # Hyper Potion
					var heal_amount = 200
					if effected_poke.current_hp + heal_amount > effected_poke.hp:
						effected_poke.current_hp = effected_poke.hp
					else:
						effected_poke.current_hp += heal_amount
				173: # Max Potion
					effected_poke.current_hp = effected_poke.hp
				174: # Full Restore
					effected_poke.current_hp = effected_poke.hp
					effected_poke.major_ailment = null
				176, 177, 178, 179, 180, 181: # Heals. NOTE: Not checked if the heal matches the ailment. Should be done before.
					effected_poke.major_ailment = null
			action = BattleQueueAction.new()
			action.type = action.UPDATE_BARS
			queue.push(action)

			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = bt("{1}'s HP was restored.", [tr(effected_poke.name)])
			queue.push(action)



		if player_command.item >= 208 && player_command.item <= 232 && battle_instance.battle_type == BattleInstanceData.BattleType.SINGLE_WILD: # Item is a type of pokeball
			action = BattleQueueAction.new()
			action.type = action.SET_BALL
			action.ball_type = player_command.item
			queue.push(action)
			# Capture wild pokemon
			var a : int# Modified catch rate
			var b : int# Shake probability
			var target = get_battler_by_index(player_command.attack_target)
			var bonus_ball = get_ball_catch_rate(player_command.item)
			var bonus_status = 1
			var broke_out = false
			var shakes = 0
			
			var catch_rate = pokemon_registry.get_pokemon_class(target.ID).catch_rate

			# Original (pbThrowPokeBall): x2 for sleep/frozen, x1.5 for other status
			match target.major_ailment:
				MajorAilment.SLEEP, MajorAilment.FROZEN:
					bonus_status = 2
				MajorAilment.PARALYSIS, MajorAilment.POISON, MajorAilment.BURN:
					bonus_status = 1.5

			a = (3 * target.hp - 2 * target.current_hp) * catch_rate * bonus_ball

			a = a / (3 * target.hp) * bonus_status
			if a > 255:
				a = 255

			#warning-ignore:NARROWING_CONVERSION
			# Original shake check (Gen 4 double sqrt): y = 0x000FFFF0 / sqrt(sqrt(0x00FF0000/x))
			b = 1048560.0 / sqrt(sqrt(16711680.0 / a))

			# Add actions
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = bt("{1} threw a {2}.", [Global.TrainerName, tr(item_database.get_item_by_id(player_command.item).name)])
			queue.push(action)
			
			action = BattleQueueAction.new()
			action.type = action.BATTLE_GROUNDS_POS_CHANGE
			action.battle_grounds_pos_change = 6 #CAPTURE_ZOOM
			queue.push(action)

			action = BattleQueueAction.new()
			action.type = action.BALL_CAPTURE_TOSS
			queue.push(action)

			for i in range(4):
				var shake = Global.rng.randi_range(0, 65535)
				shakes += 1
				if b > shake:
					continue
				else:
					broke_out = true
					break
			
			for i in range(shakes):
				action = BattleQueueAction.new()
				action.type = action.BALL_SHAKE
				queue.push(action)
			
			if broke_out:
				action = BattleQueueAction.new()
				action.type = action.BALL_BROKE
				queue.push(action)

				action = BattleQueueAction.new()
				action.type = action.BATTLE_TEXT
				action.battle_text = get_battler_title_by_index(player_command.attack_target) + " broke free!"
				queue.push(action)

				action = BattleQueueAction.new()
				action.type = action.BATTLE_GROUNDS_POS_CHANGE
				action.battle_grounds_pos_change = 7 #CAPTURE_ZOOM_BACK
				queue.push(action)
			else:
				# Capture sucsesful
				action = BattleQueueAction.new()
				action.type = action.BATTLE_END
				action.captured = true
				action.winner = action.PLAYER_WIN
				queue.push(action)
				return queue

	if player_command.command_type == player_command.SWITCH_POKE:
		action = BattleQueueAction.new()
		action.type = action.SWITCH_POKE
		action.switch_poke = player_command.switch_to_poke # The next poke by index of Global.pokemon_group
		queue.push(action)
		
		# Reset battler1
		battler1 = Global.pokemon_group[player_command.switch_to_poke]
		battler1_effects = []
		battler1_stat_stage = BattleStatStage.new()
		battler1_past_moves = []
	
	var battler # The pokemon preforming the move
	var battler_index # The index of the pokemon preforming the move
	var command

	match battle_instance.battle_type:
		battle_instance.BattleType.SINGLE_WILD, battle_instance.BattleType.SINGLE_TRAINER, battle_instance.BattleType.SINGLE_GYML, battle_instance.BattleType.RIVAL:
			double_battle = true
		_:
			double_battle = false


	while !turn_order.is_empty():
		var turn = turn_order.pop_front()
		match turn:
			B1:
				battler = battler1
				command = player_command
				battler_index = 1
			B2:
				battler = battler2
				command = foe_command
				battler_index = 2
			B3:
				battler = battler3
				battler_index = 3
			B4:
				battler = battler4
				battler_index = 4

		if command.command_type == command.ATTACK:
			var skip_turn = false
			var target_index

			match command.attack_target:
				command.B1:
					target_index = 1
				command.B2:
					target_index = 2
				command.B3:
					target_index = 3
				command.B4:
					target_index = 4
			# Preturn Effects
			var battler_effects = get_effects_by_index(battler_index)
			for each_effect in battler_effects:
				match each_effect.effect:
					BattleEffect.effects.FLINCH:
						battler_effects.remove_at(battler_effects.find(each_effect))
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("{1} flinched and couldn't move!", [get_battler_title_by_index(battler_index)])
						queue.push(action)
						skip_turn = true
						break
					BattleEffect.effects.CONFUSED:
						if each_effect.turn_count <= 0:
							# remove confusion
							battler_effects.remove_at(battler_effects.find(each_effect))
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("{1} snapped out of confusion!", [get_battler_title_by_index(target_index)])
							queue.push(action)
							break
						else:
							if percent_chance(0.50):
								# Player attacks normally
									each_effect.turn_count -= 1
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("{1} is confused!", [get_battler_title_by_index(target_index)])
									queue.push(action)
									break
							else:
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = bt("It hurt itself in its confusion!", [])
								queue.push(action)

								# Damage self
								var raw_damage: int = 0
								var base_damage: int = 0
								var effective_attacker_stat = BattleStatStage.get_multiplier(get_stage_stat_by_index(battler_index).attack) * battler.attack
								var effective_defender_stat = BattleStatStage.get_multiplier(get_stage_stat_by_index(battler_index).defense) * get_battler_by_index(battler_index).defense
								
								base_damage = int(
									( ( (2 * battler.level) / 5 ) + 2 ) * 40 * (effective_attacker_stat / effective_defender_stat)
								)
								#warning-ignore:integer_division
								base_damage = (base_damage / 50) + 2
								raw_damage = base_damage * Global.rng.randf_range(0.85,1.0)
								remove_hp(battler_index, raw_damage)

								action = BattleQueueAction.new()
								action.type = action.DAMAGE
								action.damage_target_index = battler_index
								action.damage_effectiveness = 1.0
								if post_damage_checks(battler_index):
									return queue
								pass
					
			if skip_turn:
				continue
			# Preturn Major Ailments
			var battler_ailment = get_battler_by_index(battler_index)
			
			if battler_ailment != null && battler_ailment.major_ailment != null:
				match battler_ailment.major_ailment:
					MajorAilment.FROZEN:
						if percent_chance(0.2):
							# Thaw out
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("{1} thawed out!", [get_battler_title_by_index(battler_index)])
							queue.push(action)

							battler_ailment.major_ailment = null
							action = BattleQueueAction.new()
							action.type = action.UPDATE_MAJOR_AILMENT
							action.damage_target_index = battler
							queue.push(action)
						else:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("{1} is frozen solid!", [get_battler_title_by_index(battler_index)])
							queue.push(action)
							skip_turn = true
					MajorAilment.SLEEP:
						if get_effect_from_effects(BattleEffect.effects.SLEEP_COUNTER, battler_index).turn_count == 0:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("{1} woke up!", [get_battler_title_by_index(battler_index)])
							queue.push(action)
							battler_ailment.major_ailment = null
							action = BattleQueueAction.new()
							action.type = action.UPDATE_MAJOR_AILMENT
							action.damage_target_index = battler_index
							queue.push(action)
						else:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("{1} is fast asleep.", [get_battler_title_by_index(battler_index)])
							queue.push(action)
							get_effect_from_effects(BattleEffect.effects.SLEEP_COUNTER, battler_index).turn_count -= 1
							skip_turn = true
					MajorAilment.PARALYSIS:
							if percent_chance(0.25):
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = bt("{1} is paralyzed! It can't move!", [get_battler_title_by_index(battler_index)])
								queue.push(action)
								skip_turn = true
			if skip_turn:
				continue

			var move
			match command.attack_move:
				battler.move_1.name:
					move = battler.move_1
				battler.move_2.name:
					move = battler.move_2
				battler.move_3.name:
					move = battler.move_3
				battler.move_4.name:
					move = battler.move_4


			# Two-turn moves (Dig...): forced to release on turn 2
			var charging_fx = get_effect_from_effects(BattleEffect.effects.CHARGING, battler_index)
			if charging_fx != null:
				var charged = get_move_from_name_from_battler(charging_fx.rampage_move_name, battler_index)
				if charged != null:
					move = charged

			# Rampage lock (Thrash/Outrage 0x0D2): forced to repeat the move
			var rampage_fx = get_effect_from_effects(BattleEffect.effects.RAMPAGE, battler_index)
			if rampage_fx != null:
				var forced = get_move_from_name_from_battler(rampage_fx.rampage_move_name, battler_index)
				if forced != null and forced.remaining_pp > 0:
					move = forced

			# Change move if encore is in effect:
			if get_effects_by_index(battler_index).has(BattleEffect.effects.ENCORE):
				# Check if there is enough pp
				var encore_indused_move = get_move_from_name_from_battler(get_past_moves_by_index(battler_index).back(), battler_index)
				if encore_indused_move.remaining_pp == 0:
					# Remove encore effect
					remove_effect(battler_index, BattleEffect.effects.ENCORE)
				else:
					move = encore_indused_move
			
			# Charge target index to battler if move effects self
			if move.target_ability == MoveTarget.SELF:
				target_index = battler_index

			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = bt("{1} used\n{2}!", [get_battler_title_by_index(battler_index), tr(command.attack_move)])
			queue.push(action)
			# Decrement move PP, PP should be at least 1 at this point.
			if move.remaining_pp == 0:
				print("Battle Error: " + str(move.name) + " PP is zero.")
			move.remaining_pp = move.remaining_pp - 1
			# Calculate if move hits or not
			
			
			if not _intro_abilities_done:
				_intro_abilities_done = true
				for ii in [1, 2]:
					if get_ability(ii) == "Intimidate":
						var foe_i = 2 if ii == 1 else 1
						var st_i = get_stage_stat_by_index(foe_i)
						st_i.attack = clampi(st_i.attack - 1, -6, 6)
						var iact = BattleQueueAction.new()
						iact.type = iact.BATTLE_TEXT
						iact.battle_text = get_battler_title_by_index(ii) + "'s Intimidate\ncut " + get_battler_title_by_index(foe_i) + "'s Attack!"
						queue.push(iact)
			acted_this_round += 1
			# Reset protect streak when the user picks any non-protect move
			if move.mechanic == null or move.mechanic.get("kind") != "protect":
				protect_rates[battler_index] = 1
			if move.mechanic == null or move.mechanic.get("kind") != "power_fury_cutter":
				fury_counts[battler_index] = 0

			if does_attack_hit(move, target_index, battler_index) and not (
					target_index != battler_index
					and does_index_has_effect(target_index, BattleEffect.effects.PROTECTED)
					and _emit_protected_text(target_index)):

				if move.base_power != null || move.name == "Low Kick":
					var crit_ratio_bonus = 0

					if get_effects_by_index(battler_index).has(BattleEffect.effects.FOCUS_ENERGY):
						crit_ratio_bonus += 2

					var crit_bonus2 = crit_ratio_bonus
					if get_ability(battler_index) == "Super Luck":
						crit_bonus2 += 1
					var did_crit = does_crit(int(move.critical_hit_level + crit_bonus2))
					if get_ability(target_index) in ["Battle Armor", "Shell Armor"]:
						did_crit = false
						
					# Calculate damage done.
					var raw_damage: int = 0
					var base_damage: int = 0
					var total_damage_modifier: float = 1.0
					var target_modifier: float = 1.0
					var weather_modifier: float = 1.0
					if weather == "sun":
						if move.type == Type.FIRE: weather_modifier = 1.5
						elif move.type == Type.WATER: weather_modifier = 0.5
					elif weather == "rain":
						if move.type == Type.WATER: weather_modifier = 1.5
						elif move.type == Type.FIRE: weather_modifier = 0.5
					var critical_modifier: float = 1.0
					var STAB_modifier: float = 1.0
					var random_modifier: float = 1.0
					var type_modifer: float = 1.0
					var burn_modifer: float = 1.0
					var other_modifer: float = 1.0

					# Check for modifers
					
					# Charge bounus:
					if get_past_moves_by_index(battler_index).back() == "Charge" && move.type == Type.ELECTRIC:
						other_modifer = 2.0


					# Physical moves use Attack/Defense, special moves use Sp.Atk/Sp.Def (official behavior)
					var atk_stage: int
					var def_stage: int
					var atk_base: int
					var def_base: int
					if move.style == MoveStyle.SPECIAL:
						atk_stage = get_stage_stat_by_index(battler_index).sp_attack
						def_stage = get_stage_stat_by_index(target_index).sp_defense
						atk_base = battler.sp_attack
						def_base = get_battler_by_index(target_index).sp_defense
					else:
						atk_stage = get_stage_stat_by_index(battler_index).attack
						def_stage = get_stage_stat_by_index(target_index).defense
						atk_base = battler.attack
						def_base = get_battler_by_index(target_index).defense
					# Psyshock-family: special move hits the target's physical Defense (original 0x122)
					if move.mechanic != null and move.mechanic.get("kind") == "target_phys_def":
						def_stage = get_stage_stat_by_index(target_index).defense
						def_base = get_battler_by_index(target_index).defense
					# Critical hits ignore the attacker's negative stages and the defender's positive stages
					if did_crit:
						atk_stage = maxi(atk_stage, 0)
						def_stage = mini(def_stage, 0)
					var effective_attacker_stat = BattleStatStage.get_multiplier(atk_stage) * atk_base

					var effective_defender_stat = BattleStatStage.get_multiplier(def_stage) * def_base
					
					
					if move.name == "Low Kick":
						var low_kick_power
						var target_weight = float(get_battler_by_index(target_index).weight)

						if target_weight < 10.0:
							low_kick_power = 20
						elif target_weight < 25.0:
							low_kick_power = 40
						elif target_weight < 50.0:
							low_kick_power = 60
						elif target_weight < 100.0:
							low_kick_power = 80
						elif target_weight < 200.0:
							low_kick_power = 100
						else:
							low_kick_power = 120

						base_damage = int(
							( ( (2 * battler.level) / 5 ) + 2 ) * low_kick_power * (effective_attacker_stat / effective_defender_stat)
						)
					else:
						var eff_power = move.base_power
						if move.mechanic != null:
							match move.mechanic.get("kind"):
								"power_hp_user":
									# Eruption (0x08B): max(1, N * hp / totalhp)
									eff_power = maxi(1, int(move.mechanic.get("n", 150) * battler.current_hp / battler.hp))
								"power_hp_ladder":
									# Reversal/Flail (0x098): n = 48*hp/tot -> 20/40/80/100/150/200
									var n48 = int(48 * battler.current_hp / battler.hp)
									eff_power = 20
									if n48 < 33: eff_power = 40
									if n48 < 17: eff_power = 80
									if n48 < 10: eff_power = 100
									if n48 < 5: eff_power = 150
									if n48 < 2: eff_power = 200
								"power_punishment":
									# Punishment (0x08F): min(20*(somme des hausses + 3), 200)
									var st = get_stage_stat_by_index(target_index)
									var mult = 0
									for v in [st.attack, st.defense, st.speed, st.sp_attack, st.sp_defense, st.accuracy, st.evasion]:
										if v > 0: mult += v
									eff_power = mini(20 * (mult + 3), 200)
								"power_double_if_hit":
									# Revenge/Avalanche (0x081): x2 si la cible nous a blessés cette manche
									var rec = turn_damage_taken.get(battler_index)
									if rec != null and rec.get("from") == target_index and rec.get("amount", 0) > 0:
										eff_power = move.base_power * 2
								"power_double_if_status":
									if get_battler_by_index(target_index).major_ailment != null:
										eff_power = move.base_power * 2
								"power_double_if_poisoned":
									if get_battler_by_index(target_index).major_ailment == MajorAilment.POISON:
										eff_power = move.base_power * 2
								"power_double_if_target_hit":
									var trec = turn_damage_taken.get(target_index)
									if trec != null and trec.get("amount", 0) > 0:
										eff_power = move.base_power * 2
								"power_double_if_second":
									if acted_this_round >= 2:
										eff_power = move.base_power * 2
								"power_magnitude":
									# Original 0x095: mag 4-10 pondere [1,2,4,6,4,2,1]/20, puissances [10..150]
									var mtable = [4, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 10]
									var mag = mtable[Global.rng.randi_range(0, mtable.size() - 1)]
									eff_power = [10, 30, 50, 70, 90, 110, 150][mag - 4]
									var mact = BattleQueueAction.new()
									mact.type = mact.BATTLE_TEXT
									mact.battle_text = "Magnitude " + str(mag) + "!"
									queue.push(mact)
								"power_fury_cutter":
									# 0x091: double par usage consécutif, plafond 160
									var fc = fury_counts.get(battler_index, 0)
									eff_power = mini(move.base_power * int(pow(2, fc)), 160)
									fury_counts[battler_index] = fc + 1
								"power_rollout":
									var ro = get_effect_from_effects(BattleEffect.effects.ROLLOUT, battler_index)
									if ro == null:
										ro = BattleEffect.new()
										ro.effect = BattleEffect.effects.ROLLOUT
										ro.turn_count = 0
										get_effects_by_index(battler_index).append(ro)
									eff_power = move.base_power * int(pow(2, ro.turn_count))
									ro.turn_count += 1
									if ro.turn_count >= 5:
										remove_effect(battler_index, BattleEffect.effects.ROLLOUT)
								"power_spit_up":
									var spu = get_effect_from_effects(BattleEffect.effects.STOCKPILE, battler_index)
									if spu == null or spu.turn_count == 0:
										eff_power = 0
									else:
										eff_power = move.base_power * spu.turn_count
										remove_effect(battler_index, BattleEffect.effects.STOCKPILE)
								"power_double_below_half":
									# Brine (0x080): x2 si la cible est a moitie PV ou moins
									var tgt = get_battler_by_index(target_index)
									if tgt.current_hp * 2 <= tgt.hp:
										eff_power = move.base_power * 2
						base_damage = int(
							( ( (2 * battler.level) / 5 ) + 2 ) * eff_power * (effective_attacker_stat / effective_defender_stat)
						)
					#warning-ignore:integer_division
					base_damage = (base_damage / 50) + 2
					
					if did_crit:
						critical_modifier = 2.25 if get_ability(battler_index) == "Sniper" else 1.5
					if move.type == battler.type1 || move.type == battler.type2:
						STAB_modifier = 1.5
					var rng = Global.rng
					random_modifier = rng.randf_range(0.85,1.0)

					if get_battler_by_index(battler_index).major_ailment == MajorAilment.BURN && move.style == MoveStyle.PHYSICAL:
						burn_modifer = 0.5

					# Abilities in the damage formula
					var atk_ab = get_ability(battler_index)
					var def_ab2 = get_ability(target_index)
					if atk_ab == "Guts" and battler.major_ailment != null and move.style == MoveStyle.PHYSICAL:
						other_modifer *= 1.5
						burn_modifer = 1.0
					var pinch = {"Overgrow": Type.GRASS, "Blaze": Type.FIRE, "Torrent": Type.WATER, "Swarm": Type.BUG}
					if pinch.has(atk_ab) and move.type == pinch[atk_ab] and battler.current_hp * 3 <= battler.hp:
						other_modifer *= 1.5
					if def_ab2 == "Thick Fat" and (move.type == Type.FIRE or move.type == Type.ICE):
						other_modifer *= 0.5

					# Screens (0x0A1/0x0A2): halve damage unless crit
					if not did_crit:
						if move.style == MoveStyle.PHYSICAL and does_index_has_effect(target_index, BattleEffect.effects.REFLECT):
							other_modifer *= 0.5
						elif move.style == MoveStyle.SPECIAL and does_index_has_effect(target_index, BattleEffect.effects.LIGHT_SCREEN):
							other_modifer *= 0.5

					
					type_modifer = Type.type_advantage_multiplier(move.type, get_battler_by_index(target_index))
					# Abilities: outright immunities/absorptions
					if target_index != battler_index:
						var def_ab = get_ability(target_index)
						if (def_ab == "Levitate" and move.type == Type.GROUND) \
								or (def_ab == "Flash Fire" and move.type == Type.FIRE) \
								or (def_ab == "Volt Absorb" and move.type == Type.ELECTRIC) \
								or (def_ab == "Water Absorb" and move.type == Type.WATER):
							type_modifer = 0.0
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(target_index) + "'s " + def_ab + "\nmade the move ineffective!"
							queue.push(action)

					# Foresight check
					if get_effect_from_effects(BattleEffect.effects.FORESIGHT, target_index) != null:
						if (get_battler_by_index(target_index).type1 == Type.GHOST || get_battler_by_index(target_index).type2 == Type.GHOST) && (move.type == Type.NORMAL || move.type == Type.FIGHTING):
							type_modifer = 1.0


					total_damage_modifier = target_modifier * weather_modifier * critical_modifier * STAB_modifier * random_modifier * type_modifer * burn_modifer * other_modifer
					#warning-ignore:narrowing_conversion
					raw_damage = base_damage * total_damage_modifier

					# Mechanics: OHKO (0x070): deals the target's current HP; type immunity applies
					if move.mechanic != null and move.mechanic.get("kind") == "ohko":
						raw_damage = 0 if type_modifer == 0.0 else get_battler_by_index(target_index).current_hp

					# Psywave (0x06F): level * (rand(101)+50)/100, immunity applies
					if move.mechanic != null and move.mechanic.get("kind") == "fixed_psywave":
						raw_damage = 0 if type_modifer == 0.0 else maxi(1, int(battler.level * (Global.rng.randi_range(0, 100) + 50) / 100.0))

					# Endeavor (0x06E): brings the target down to the user's HP
					if move.mechanic != null and move.mechanic.get("kind") == "fixed_endeavor":
						var tgt_e = get_battler_by_index(target_index)
						if battler.current_hp >= tgt_e.current_hp or type_modifer == 0.0:
							raw_damage = 0
						else:
							raw_damage = tgt_e.current_hp - battler.current_hp

					# Counter (0x071): returns double the physical damage taken this round
					if move.mechanic != null and move.mechanic.get("kind") == "fixed_counter":
						var crec = turn_damage_taken.get(battler_index)
						if crec == null or crec.get("style") != MoveStyle.PHYSICAL or crec.get("from") != target_index:
							raw_damage = 0
						else:
							raw_damage = crec.get("amount", 0) * 2

					# Mechanics: fixed damage (Dragon Rage, Night Shade...) bypasses the formula, immunity still applies
					if move.mechanic != null and move.mechanic.get("kind") == "fixed":
						if type_modifer == 0.0:
							raw_damage = 0
						else:
							var amt = move.mechanic.get("amount")
							raw_damage = battler.level if amt is String else int(amt)

					# Mechanics: multi-hit — roll per-hit damage and report the count
					var hit_count := 1
					if move.mechanic != null and raw_damage > 0:
						match move.mechanic.get("kind"):
							"hits":
								hit_count = int(move.mechanic.get("n", 2))
							"multi_hit":
								# Official distribution (086 fn 0x0C0): uniform pick in [2,2,3,3,4,5]
								var hitchances = [2, 2, 3, 3, 4, 5]
								hit_count = hitchances[Global.rng.randi_range(0, hitchances.size() - 1)]
						if hit_count > 1:
							var total := 0
							for _hit in range(hit_count):
								total += int(base_damage * target_modifier * weather_modifier * critical_modifier * STAB_modifier * Global.rng.randf_range(0.85, 1.0) * type_modifer * burn_modifer * other_modifer)
							raw_damage = maxi(total, hit_count)

					if battle_debug:
						print("Raw Damage: " + str(raw_damage) + " , To battler: " + str(target_index))

					if raw_damage != 0:
						var sub_fx = get_effect_from_effects(BattleEffect.effects.SUBSTITUTE, target_index) if target_index != battler_index else null
						if sub_fx != null:
							# The substitute soaks the hit (0x10C)
							sub_fx.turn_count -= raw_damage
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("The substitute took damage for {1}!", [get_battler_title_by_index(target_index)])
							queue.push(action)
							if sub_fx.turn_count <= 0:
								remove_effect(target_index, BattleEffect.effects.SUBSTITUTE)
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = bt("{1}'s substitute faded!", [get_battler_title_by_index(target_index)])
								queue.push(action)
							raw_damage = 0
					if raw_damage != 0:
						# Sturdy: survives any hit from full HP at 1 HP
						if get_ability(target_index) == "Sturdy" and target_index != battler_index \
								and get_battler_by_index(target_index).current_hp == get_battler_by_index(target_index).hp \
								and raw_damage >= get_battler_by_index(target_index).current_hp:
							raw_damage = get_battler_by_index(target_index).current_hp - 1
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(target_index) + " hung on\nwith Sturdy!"
							queue.push(action)
					if raw_damage != 0:
						# Endure (0x0E8): survive any hit at 1 HP
						if does_index_has_effect(target_index, BattleEffect.effects.ENDURING) and raw_damage >= get_battler_by_index(target_index).current_hp:
							raw_damage = get_battler_by_index(target_index).current_hp - 1
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(target_index) + " endured\nthe hit!"
							queue.push(action)
					if raw_damage != 0:
						# Perform the damage to battler
						remove_hp(target_index, raw_damage)
						turn_damage_taken[target_index] = {"amount": raw_damage, "from": battler_index, "style": move.style}
						# Contact abilities strike back at physical attackers
						if move.style == MoveStyle.PHYSICAL and target_index != battler_index:
							var cab = get_ability(target_index)
							var contact_status = {"Static": MajorAilment.PARALYSIS, "Poison Point": MajorAilment.POISON, "Flame Body": MajorAilment.BURN}
							if contact_status.has(cab) and Global.rng.randi_range(0, 99) < 30 \
									and get_battler_by_index(battler_index).major_ailment == null:
								set_major_ailment(battler_index, contact_status[cab])
								action = BattleQueueAction.new()
								action.type = action.UPDATE_MAJOR_AILMENT
								action.damage_target_index = battler_index
								queue.push(action)
							elif cab == "Rough Skin":
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = get_battler_title_by_index(battler_index) + " was hurt\nby Rough Skin!"
								queue.push(action)
								remove_hp(battler_index, maxi(1, get_battler_by_index(battler_index).hp / 8))
								action = BattleQueueAction.new()
								action.type = action.DAMAGE
								action.damage_target_index = battler_index
								action.damage_effectiveness = 1.0
								queue.push(action)
								if post_damage_checks(battler_index):
									return queue
						# Binding moves (0x0CF): 4-5 turns of chip damage; Ghost-types are immune
						if move.mechanic != null and move.mechanic.get("kind") == "bind":
							var tgt_b = get_battler_by_index(target_index)
							if tgt_b.current_hp > 0 and tgt_b.type1 != Type.GHOST and tgt_b.type2 != Type.GHOST \
									and not does_index_has_effect(target_index, BattleEffect.effects.BOUND):
								var bfx = BattleEffect.new()
								bfx.effect = BattleEffect.effects.BOUND
								bfx.turn_count = 4 + Global.rng.randi_range(0, 1)
								bfx.bound_move_name = move.name
								get_effects_by_index(target_index).append(bfx)
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = get_battler_title_by_index(target_index) + " was trapped\nby " + move.name + "!"
								queue.push(action)
						# Self-KO (0x0E0 Explosion/Self-Destruct): the user faints after dealing damage
						if move.mechanic != null and move.mechanic.get("kind") == "self_ko":
							var me_ko = get_battler_by_index(battler_index)
							remove_hp(battler_index, me_ko.current_hp)
							action = BattleQueueAction.new()
							action.type = action.DAMAGE
							action.damage_target_index = battler_index
							action.damage_effectiveness = 1.0
							queue.push(action)
							if post_damage_checks(battler_index):
								return queue
						# Rampage (0x0D2): lock the user for 2-3 attacks, then fatigue confusion
						if move.mechanic != null and move.mechanic.get("kind") == "rampage" \
								and get_effect_from_effects(BattleEffect.effects.RAMPAGE, battler_index) == null:
							var rfx = BattleEffect.new()
							rfx.effect = BattleEffect.effects.RAMPAGE
							rfx.turn_count = 1 + Global.rng.randi_range(0, 1)
							rfx.rampage_move_name = move.name
							get_effects_by_index(battler_index).append(rfx)
						
						# Add in the battle actions
						action = BattleQueueAction.new()
						action.type = action.DAMAGE
						action.damage_target_index = target_index
						action.damage_effectiveness = type_modifer

						print("type_modifer: " + str(type_modifer))

						queue.push(action)

						if hit_count > 1:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = "Hit " + str(hit_count) + " times!"
							queue.push(action)

						# Mechanics: drain heals the attacker, recoil hurts it
						if move.mechanic != null:
							match move.mechanic.get("kind"):
								"drain":
									var healed = maxi(int(raw_damage * move.mechanic.get("fraction", 0.5)), 1)
									var me = get_battler_by_index(battler_index)
									me.current_hp = mini(me.current_hp + healed, me.hp)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = get_battler_title_by_index(target_index) + " had its\nenergy drained!"
									queue.push(action)
								"flinch":
									if percent_chance(move.mechanic.get("chance", 0.3)) and get_battler_by_index(target_index).hp != 0:
										var already = false
										for fx in get_effects_by_index(target_index):
											if fx.effect == BattleEffect.effects.FLINCH:
												already = true
										if not already:
											var fl = BattleEffect.new()
											fl.effect = BattleEffect.effects.FLINCH
											get_effects_by_index(target_index).append(fl)
								"confuse":
									if percent_chance(move.mechanic.get("chance", 0.1)) and get_battler_by_index(target_index).hp != 0:
										var already_c = false
										for fx in get_effects_by_index(target_index):
											if fx.effect == BattleEffect.effects.CONFUSED:
												already_c = true
										if not already_c:
											var ce = BattleEffect.new()
											ce.effect = BattleEffect.effects.CONFUSED
											ce.turn_count = Global.rng.randi_range(2, 5)
											get_effects_by_index(target_index).append(ce)
											action = BattleQueueAction.new()
											action.type = action.BATTLE_TEXT
											action.battle_text = get_battler_title_by_index(target_index) + " became\nconfused!"
											queue.push(action)
								"recoil":
									var recoil = maxi(int(raw_damage * move.mechanic.get("fraction", 0.25)), 1)
									remove_hp(battler_index, recoil)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = get_battler_title_by_index(battler_index) + " is damaged\nby recoil!"
									queue.push(action)
									if post_damage_checks(battler_index):
										return queue

						if did_crit:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("A critical hit!", [])
							queue.push(action)
						# Add in the effective damage message
						if type_modifer > 1.0:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("It's super effective!")
							queue.push(action)
						if type_modifer < 1.0:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = bt("It's not very effective...")
							queue.push(action)
							
						if post_damage_checks(target_index):
							return queue

						#Secondary effect
						if move.secondary_effect != null:
							var sec_chance = move.secondary_effect_chance
							if sec_chance != null and get_ability(battler_index) == "Serene Grace":
								sec_chance = minf(1.0, sec_chance * 2.0)
							if percent_chance(sec_chance) && get_battler_by_index(target_index).hp != 0:
								set_major_ailment(target_index, move.secondary_effect)

					else:
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("It doesn't affect\n{1}...", [get_battler_title_by_index(target_index)])
						queue.push(action)

				else: # Move is not a direct attack move

					# Pure status ailment moves (Sing, Hypnosis, Toxic, Glare...): apply the ailment
					if move.secondary_effect != null and target_index != battler_index \
							and does_index_has_effect(target_index, BattleEffect.effects.SAFEGUARD):
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(target_index) + " is protected\nby Safeguard!"
						queue.push(action)
					elif move.secondary_effect != null and get_battler_by_index(target_index).major_ailment == null:
						set_major_ailment(target_index, move.secondary_effect)
						action = BattleQueueAction.new()
						action.type = action.UPDATE_MAJOR_AILMENT
						action.damage_target_index = target_index
						queue.push(action)

					# Rest (0x0D9): full heal + sleep, fails at full HP
					if move.mechanic != null and move.mechanic.get("kind") == "rest":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						var me_b = get_battler_by_index(battler_index)
						if me_b.current_hp == me_b.hp:
							action.battle_text = get_battler_title_by_index(battler_index) + "'s HP is full!"
							queue.push(action)
						else:
							me_b.current_hp = me_b.hp
							me_b.major_ailment = MajorAilment.SLEEP
							var slfx = BattleEffect.new()
							slfx.effect = BattleEffect.effects.SLEEP_COUNTER
							slfx.turn_count = 3
							get_effects_by_index(battler_index).append(slfx)
							action.battle_text = get_battler_title_by_index(battler_index) + " slept and\nbecame healthy!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.HEAL
							action.damage_target_index = battler_index
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.UPDATE_MAJOR_AILMENT
							action.damage_target_index = battler_index
							queue.push(action)

					# Endure (0x0E8): shares the protect rate; survive any hit at 1 HP this turn
					if move.mechanic != null and move.mechanic.get("kind") == "endure":
						var erate = protect_rates.get(battler_index, 1)
						var endure_ok = Global.rng.randi_range(0, 65535) <= int(65536.0 / erate)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if endure_ok:
							protect_rates[battler_index] = erate * 2
							var efx = BattleEffect.new()
							efx.effect = BattleEffect.effects.ENDURING
							get_effects_by_index(battler_index).append(efx)
							action.battle_text = get_battler_title_by_index(battler_index) + " braced\nitself!"
						else:
							protect_rates[battler_index] = 1
							action.battle_text = bt("But it failed!")
						queue.push(action)

					# Wish (0x0D7): heals half max HP at the end of the next turn
					if move.mechanic != null and move.mechanic.get("kind") == "wish":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if does_index_has_effect(battler_index, BattleEffect.effects.WISH):
							action.battle_text = bt("But it failed!")
						else:
							var wfx = BattleEffect.new()
							wfx.effect = BattleEffect.effects.WISH
							wfx.turn_count = 2
							get_effects_by_index(battler_index).append(wfx)
							action.battle_text = get_battler_title_by_index(battler_index) + " made\na wish!"
						queue.push(action)

					# Substitute (0x10C): costs 1/4 max HP, the doll soaks damage
					if move.mechanic != null and move.mechanic.get("kind") == "substitute":
						var me_s = get_battler_by_index(battler_index)
						var sublife = maxi(1, me_s.hp / 4)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if does_index_has_effect(battler_index, BattleEffect.effects.SUBSTITUTE):
							action.battle_text = get_battler_title_by_index(battler_index) + " already\nhas a substitute!"
							queue.push(action)
						elif me_s.current_hp <= sublife:
							action.battle_text = bt("It was too weak to make a substitute!", [])
							queue.push(action)
						else:
							remove_hp(battler_index, sublife)
							var sfx2 = BattleEffect.new()
							sfx2.effect = BattleEffect.effects.SUBSTITUTE
							sfx2.turn_count = sublife
							get_effects_by_index(battler_index).append(sfx2)
							action.battle_text = get_battler_title_by_index(battler_index) + " put in\na substitute!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.DAMAGE
							action.damage_target_index = battler_index
							action.damage_effectiveness = 1.0
							queue.push(action)

					# Teleport (0x0EA): flee from a wild battle
					if move.mechanic != null and move.mechanic.get("kind") == "teleport":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if battle_instance.battle_type == battle_instance.BattleType.SINGLE_WILD:
							action.battle_text = get_battler_title_by_index(battler_index) + " teleported\naway from battle!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.BATTLE_END
							action.winner = action.PLAYER_WIN
							action.run_away = true
							queue.push(action)
							return queue
						else:
							action.battle_text = bt("But it failed!")
							queue.push(action)

					# Refresh (0x018): cures the user's own status
					if move.mechanic != null and move.mechanic.get("kind") == "cure_self_status":
						var me_r = get_battler_by_index(battler_index)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if me_r.major_ailment == null:
							action.battle_text = bt("But it failed!")
							queue.push(action)
						else:
							me_r.major_ailment = null
							action.battle_text = get_battler_title_by_index(battler_index) + " became\nhealthy!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.UPDATE_MAJOR_AILMENT
							action.damage_target_index = battler_index
							queue.push(action)

					# Acupressure (0x037): a random stat rises sharply (+2)
					if move.mechanic != null and move.mechanic.get("kind") == "random_stat_up2":
						var st_a = get_stage_stat_by_index(battler_index)
						var choices = ["attack", "defense", "speed", "sp_attack", "sp_defense", "accuracy", "evasion"]
						var pick = choices[Global.rng.randi_range(0, choices.size() - 1)]
						st_a.set(pick, clampi(st_a.get(pick) + 2, -6, 6))
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(battler_index) + "'s " + pick.capitalize().replace("_", ". ") + "\nsharply rose!"
						queue.push(action)

					# Stockpile (0x112): up to 3 charges
					if move.mechanic != null and move.mechanic.get("kind") == "stockpile":
						var spx = get_effect_from_effects(BattleEffect.effects.STOCKPILE, battler_index)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if spx != null and spx.turn_count >= 3:
							action.battle_text = get_battler_title_by_index(battler_index) + " can't\nstockpile any more!"
						else:
							if spx == null:
								spx = BattleEffect.new()
								spx.effect = BattleEffect.effects.STOCKPILE
								spx.turn_count = 0
								get_effects_by_index(battler_index).append(spx)
							spx.turn_count += 1
							action.battle_text = get_battler_title_by_index(battler_index) + " stockpiled " + str(spx.turn_count) + "!"
						queue.push(action)

					# Swallow (0x114): heals 1/4, 1/2 or all max HP per stockpile count
					if move.mechanic != null and move.mechanic.get("kind") == "swallow":
						var swx = get_effect_from_effects(BattleEffect.effects.STOCKPILE, battler_index)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if swx == null or swx.turn_count == 0:
							action.battle_text = "But it failed to\nswallow a thing!"
							queue.push(action)
						else:
							var me_w = get_battler_by_index(battler_index)
							var gain = me_w.hp / 4 if swx.turn_count == 1 else (me_w.hp / 2 if swx.turn_count == 2 else me_w.hp)
							me_w.current_hp = mini(me_w.hp, me_w.current_hp + gain)
							remove_effect(battler_index, BattleEffect.effects.STOCKPILE)
							action.battle_text = get_battler_title_by_index(battler_index) + "'s HP\nwas restored!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.HEAL
							action.damage_target_index = battler_index
							queue.push(action)

					# Nightmare (0x10F): only on a sleeping target; chips 1/4 while it sleeps
					if move.mechanic != null and move.mechanic.get("kind") == "nightmare":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if get_battler_by_index(target_index).major_ailment != MajorAilment.SLEEP \
								or does_index_has_effect(target_index, BattleEffect.effects.NIGHTMARE) \
								or does_index_has_effect(target_index, BattleEffect.effects.SUBSTITUTE):
							action.battle_text = bt("But it failed!")
						else:
							var nfx = BattleEffect.new()
							nfx.effect = BattleEffect.effects.NIGHTMARE
							get_effects_by_index(target_index).append(nfx)
							action.battle_text = get_battler_title_by_index(target_index) + " began\nhaving a nightmare!"
						queue.push(action)

					# Curse (0x10D): Ghost pays half HP to curse; others get +1 Atk/+1 Def/-1 Spe
					if move.mechanic != null and move.mechanic.get("kind") == "curse":
						var me_c = get_battler_by_index(battler_index)
						if me_c.type1 == Type.GHOST or me_c.type2 == Type.GHOST:
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							if does_index_has_effect(target_index, BattleEffect.effects.CURSED):
								action.battle_text = bt("But it failed!")
								queue.push(action)
							else:
								remove_hp(battler_index, maxi(1, me_c.hp / 2))
								var cufx = BattleEffect.new()
								cufx.effect = BattleEffect.effects.CURSED
								get_effects_by_index(target_index).append(cufx)
								action.battle_text = get_battler_title_by_index(battler_index) + " cut its own HP\nand laid a curse!"
								queue.push(action)
								action = BattleQueueAction.new()
								action.type = action.DAMAGE
								action.damage_target_index = battler_index
								action.damage_effectiveness = 1.0
								queue.push(action)
								if post_damage_checks(battler_index):
									return queue
						else:
							var st_c = get_stage_stat_by_index(battler_index)
							st_c.attack = clampi(st_c.attack + 1, -6, 6)
							st_c.defense = clampi(st_c.defense + 1, -6, 6)
							st_c.speed = clampi(st_c.speed - 1, -6, 6)
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(battler_index) + "'s Attack and Defense\nrose but Speed fell!"
							queue.push(action)

					# Perish Song (0x0E5): everyone who hears it faints in 3 turns
					if move.mechanic != null and move.mechanic.get("kind") == "perish_song":
						var sung = false
						for pi in [1, 2]:
							if get_effect_from_effects(BattleEffect.effects.PERISH, pi) == null:
								var pfx2 = BattleEffect.new()
								pfx2.effect = BattleEffect.effects.PERISH
								pfx2.turn_count = 3
								get_effects_by_index(pi).append(pfx2)
								sung = true
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = "All Pokémon that heard\nthe song will faint in three turns!" if sung else "But it failed!"
						queue.push(action)

					# Pain Split (0x05A): averages the user's and target's HP
					if move.mechanic != null and move.mechanic.get("kind") == "pain_split":
						var me_p = get_battler_by_index(battler_index)
						var tgt_p = get_battler_by_index(target_index)
						var avg = (me_p.current_hp + tgt_p.current_hp) / 2
						me_p.current_hp = mini(me_p.hp, avg)
						tgt_p.current_hp = mini(tgt_p.hp, avg)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("The battlers shared their pain!", [])
						queue.push(action)
						for pi2 in [battler_index, target_index]:
							action = BattleQueueAction.new()
							action.type = action.HEAL
							action.damage_target_index = pi2
							queue.push(action)

					# Mist (0x056) / Safeguard: 5-turn team veils
					if move.mechanic != null and (move.mechanic.get("kind") == "mist" or move.mechanic.get("kind") == "safeguard"):
						var veil = BattleEffect.effects.MIST if move.mechanic.get("kind") == "mist" else BattleEffect.effects.SAFEGUARD
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if does_index_has_effect(battler_index, veil):
							action.battle_text = bt("But it failed!")
						else:
							var vfx = BattleEffect.new()
							vfx.effect = veil
							vfx.turn_count = 5
							get_effects_by_index(battler_index).append(vfx)
							if veil == BattleEffect.effects.MIST:
								action.battle_text = get_battler_title_by_index(battler_index) + " became\nshrouded in mist!"
							else:
								action.battle_text = get_battler_title_by_index(battler_index) + " is protected\nby Safeguard!"
						queue.push(action)

					# Splash (0x0B1)
					if move.mechanic != null and move.mechanic.get("kind") == "splash":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("But nothing happened!", [])
						queue.push(action)

					# Roar/Whirlwind (0x0EB): blows the wild Pokémon away, ending the battle
					if move.mechanic != null and move.mechanic.get("kind") == "roar":
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if battle_instance.battle_type == battle_instance.BattleType.SINGLE_WILD:
							action.battle_text = get_battler_title_by_index(target_index) + " was\nblown away!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.BATTLE_END
							action.winner = action.PLAYER_WIN
							action.run_away = true
							queue.push(action)
							return queue
						else:
							action.battle_text = bt("But it failed!")
							queue.push(action)

					# Haze (0x051): reset every stat stage on both sides
					if move.mechanic != null and move.mechanic.get("kind") == "haze":
						for hz in [1, 2]:
							var st = get_stage_stat_by_index(hz)
							st.attack = 0; st.defense = 0; st.speed = 0
							st.sp_attack = 0; st.sp_defense = 0
							st.accuracy = 0; st.evasion = 0
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("All stat changes were eliminated!", [])
						queue.push(action)

					if move.mechanic != null and move.mechanic.get("kind") == "screen":
						var scr = BattleEffect.effects.REFLECT if move.mechanic.get("stat") == "def" else BattleEffect.effects.LIGHT_SCREEN
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if does_index_has_effect(battler_index, scr):
							action.battle_text = bt("But it failed!")
						else:
							var sfx = BattleEffect.new()
							sfx.effect = scr
							sfx.turn_count = 5
							get_effects_by_index(battler_index).append(sfx)
							if scr == BattleEffect.effects.REFLECT:
								action.battle_text = get_battler_title_by_index(battler_index) + " is protected\nby Reflect!"
							else:
								action.battle_text = get_battler_title_by_index(battler_index) + " is protected\nby Light Screen!"
						queue.push(action)

					if move.mechanic != null and move.mechanic.get("kind") == "weather":
						var w = move.mechanic.get("weather")
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if weather == w:
							action.battle_text = bt("But it failed!")
						else:
							weather = w
							weather_turns = 5
							match w:
								"sun": action.battle_text = bt("The sunlight turned harsh!", [])
								"rain": action.battle_text = bt("It started to rain!", [])
								"sandstorm": action.battle_text = bt("A sandstorm kicked up!", [])
								"hail": action.battle_text = bt("It started to hail!", [])
						queue.push(action)

					if move.mechanic != null and move.mechanic.get("kind") == "protect":
						# Original 0x0AA: fails if the user acts last; success = rng(65536) <= 65536/rate; rate doubles
						var prate = protect_rates.get(battler_index, 1)
						var protect_ok = acted_this_round < 2 and Global.rng.randi_range(0, 65535) <= int(65536.0 / prate)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						if protect_ok:
							protect_rates[battler_index] = prate * 2
							var pfx = BattleEffect.new()
							pfx.effect = BattleEffect.effects.PROTECTED
							get_effects_by_index(battler_index).append(pfx)
							action.battle_text = get_battler_title_by_index(battler_index) + "\nprotected itself!"
						else:
							protect_rates[battler_index] = 1
							action.battle_text = bt("But it failed!")
						queue.push(action)

					if move.mechanic != null and move.mechanic.get("kind") == "heal":
						var me2 = get_battler_by_index(battler_index)
						var heal_amt = maxi(int(me2.hp * move.mechanic.get("fraction", 0.5)), 1)
						me2.current_hp = mini(me2.current_hp + heal_amt, me2.hp)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("{1} regained\nhealth!", [get_battler_title_by_index(battler_index)])
						queue.push(action)

					if move.main_status_effect != null and target_index != battler_index \
							and does_index_has_effect(target_index, BattleEffect.effects.MIST):
						# Mist (0x056): the opponent's stat reductions are blocked
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(target_index) + " is\nprotected by mist!"
						queue.push(action)
					elif move.main_status_effect != null and (move.get("stat_effect_chance") == null or percent_chance(move.stat_effect_chance * 100)): # Move effect stats (chance-gated per original addl%)
						var stat_effect = get_status_effect_by_move_name(move.name)
						var stats_changed = get_stage_stat_by_index(target_index).apply_stat_effect(stat_effect) # This changes stats of target
							
						# For all stats changed
						for stat in stats_changed:
							var over_limit = false
							if stat.stat_over_limit:
								over_limit = true
							else:
								action = BattleQueueAction.new()
								action.type = action.STAT_CHANGE_ANIMATION
								action.damage_target_index = target_index
								if stat.stat_change > 0: # Increase
									action.stat_change_increase = true
								queue.push(action)

							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							var stat_effected_name
							match stat.stat_type:
								BattleStatStage.ATTACK:
									stat_effected_name = "Attack"
								BattleStatStage.DEFENSE:
									stat_effected_name = "Defense"
								BattleStatStage.SP_ATTACK:
									stat_effected_name = "Sp. Attack"
								BattleStatStage.SP_DEFENSE:
									stat_effected_name = "Sp. Defense"
								BattleStatStage.SPEED:
									stat_effected_name = "Speed"
								BattleStatStage.ACCURACY:
									stat_effected_name = "Accuracy"
								BattleStatStage.EVASION:
									stat_effected_name = "Evasion"

							var _sfx = ""
							if !over_limit:
								match stat.stat_change:
									1:
										_sfx = " rose!"
									2:
										_sfx = " sharply rose!"
									3, 4, 5, 6:
										_sfx = " rose drastically!"
									-1:
										_sfx = " fell!"
									-2:
										_sfx = " harshly fell!"
									-3, -4, -5, -6:
										_sfx = " severely fell!"
							else:
								match stat.stat_change:
									1,2,3,4,5,6:
										_sfx = " won't go any higher!"
									-1,-2,-3,-4,-5,-6:
										_sfx = " won't go any lower!"
							action.battle_text = bt("{1}'s " + str(stat_effected_name) + _sfx, [get_battler_title_by_index(target_index)])
							queue.push(action)
					else: # Move is something else (Leech Seed, etc.)
						match move.name:
							"Leech Seed":
								# Check if target is already seeded
								var already_seeded = false
								var target = get_battler_by_index(target_index)
								for effects in get_effects_by_index(target_index):
									if effects.effect == BattleEffect.effects.SEEDED:
										already_seeded = true

								# Check if target is grass type
								if target.type1 == Type.GRASS || target.type2 == Type.GRASS:
									# No effect
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("It doesn't affect\n{1}...", [get_battler_title_by_index(target_index)])
									queue.push(action)
								elif already_seeded: # Check if target is already seeded
									# Fail
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = "But " + get_battler_title_by_index(target_index) + " is already seeded."
									queue.push(action)
								# set seeded flag to target battler
								else:
									var effect = BattleEffect.new()
									effect.effect = BattleEffect.effects.SEEDED
									effect.seeded_heal_target_index = battler_index
									get_effects_by_index(target_index).append(effect)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = get_battler_title_by_index(target_index) + " was seeded!"
									queue.push(action)
							"Foresight":
								# Check if foresight was already used
								if get_effect_from_effects(BattleEffect.effects.FORESIGHT, target_index) == null:
									var effect = BattleEffect.new()
									effect.effect = BattleEffect.effects.FORESIGHT
									get_effects_by_index(target_index).append(effect)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = get_battler_by_index(target_index).name + " was identified!"
									queue.push(action)
								else:
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("But it failed!")
									queue.push(action)
								pass
							"Supersonic":
								# Check if target is already confused
								var already_confused = false
								var target = get_battler_by_index(target_index)
								for effects in get_effects_by_index(target_index):
									if effects.effect == BattleEffect.effects.CONFUSED:
										action = BattleQueueAction.new()
										action.type = action.BATTLE_TEXT
										action.battle_text = get_battler_title_by_index(target_index) + " is already confused!"
										queue.push(action)
									else:
										# Apply confusion effect
										var effect = BattleEffect.new()
										effect.effect = BattleEffect.effects.CONFUSED
										effect.turn_count = Global.rng.randi_range(2,5)
										get_effects_by_index(target_index).append(effect)
							"Poison Gas":
								# Apply Poison
								get_battler_by_index(target_index).major_ailment = MajorAilment.POISON
								action = BattleQueueAction.new()
								action.type = action.BATTLE_TEXT
								action.battle_text = bt("{1} was poisoned!", [get_battler_title_by_index(target_index)])
								queue.push(action)

								action = BattleQueueAction.new()
								action.type = action.UPDATE_MAJOR_AILMENT
								action.damage_target_index = target_index
								queue.push(action)
							"Yawn":
								if get_effect_from_effects(BattleEffect.effects.DROWSY, target_index) == null:
									var effect = BattleEffect.new()
									effect.effect = BattleEffect.effects.DROWSY
									effect.turn_count = 1
									get_effects_by_index(target_index).append(effect)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = get_battler_title_by_index(battler_index) + " made " + get_battler_title_by_index(target_index) + " drowsy!"
									queue.push(action)
								else:
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("But it failed!")
									queue.push(action)
								pass
							"Focus Energy":
								# Check if Focus Energy was already used
								if get_effect_from_effects(BattleEffect.effects.FOCUS_ENERGY, battler) == null:
									var effect = BattleEffect.new()
									effect.effect = BattleEffect.effects.FOCUS_ENERGY
									get_effects_by_index(battler_index).append(effect)
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = battler.name + " is getting pumped!"
									queue.push(action)
								else:
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("But it failed!")
									queue.push(action)
							"Encore":
								if get_effect_from_effects(BattleEffect.effects.ENCORE, target_index) == null:
									var effect = BattleEffect.new()
									effect.effect = BattleEffect.effects.ENCORE
									effect.turn_count = 3
									get_effects_by_index(target_index).append(effect)
								else:
									action = BattleQueueAction.new()
									action.type = action.BATTLE_TEXT
									action.battle_text = bt("But it failed!")
									queue.push(action)
				# Add move to past_moves
				get_past_moves_by_index(battler_index).append(move.name)

			else: # Add missed mesage.
				action = BattleQueueAction.new()
				action.type = action.BATTLE_TEXT
				action.battle_text = get_battler_title_by_index(battler_index) + "'s\nattack missed!"
				queue.push(action)



	# After round actions
	acted_this_round = 0
	turn_damage_taken.clear()
	# End-of-turn abilities
	for abi in [1, 2]:
		var ab_b = get_battler_by_index(abi)
		if ab_b == null or ab_b.current_hp <= 0:
			continue
		if get_ability(abi) == "Shed Skin" and ab_b.major_ailment != null and Global.rng.randi_range(0, 2) == 0:
			ab_b.major_ailment = null
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = get_battler_title_by_index(abi) + " shed its skin\nand became healthy!"
			queue.push(action)
			action = BattleQueueAction.new()
			action.type = action.UPDATE_MAJOR_AILMENT
			action.damage_target_index = abi
			queue.push(action)
		elif get_ability(abi) == "Speed Boost":
			var st_sb = get_stage_stat_by_index(abi)
			if st_sb.speed < 6:
				st_sb.speed += 1
				action = BattleQueueAction.new()
				action.type = action.BATTLE_TEXT
				action.battle_text = get_battler_title_by_index(abi) + "'s Speed Boost\nraised its Speed!"
				queue.push(action)
	# Weather: message, chip (hail/sandstorm 1/16, immune types), 5-turn expiry
	if weather != "":
		match weather:
			"hail":
				action.type = action.BATTLE_TEXT
				action.battle_text = bt("Hail continues to fall.", [])
				queue.push(action)
			"sandstorm":
				action.type = action.BATTLE_TEXT
				action.battle_text = bt("The sandstorm rages.", [])
				queue.push(action)
		if weather == "hail" or weather == "sandstorm":
			for wi in [1, 2]:
				var wb = get_battler_by_index(wi)
				if wb == null or wb.current_hp <= 0:
					continue
				var immune = false
				if weather == "hail":
					immune = wb.type1 == Type.ICE or wb.type2 == Type.ICE
				else:
					immune = wb.type1 == Type.ROCK or wb.type2 == Type.ROCK \
						or wb.type1 == Type.GROUND or wb.type2 == Type.GROUND \
						or wb.type1 == Type.STEEL or wb.type2 == Type.STEEL
				if immune:
					continue
				action = BattleQueueAction.new()
				action.type = action.BATTLE_TEXT
				action.battle_text = get_battler_title_by_index(wi) + " is buffeted\nby the " + ("hail" if weather == "hail" else "sandstorm") + "!"
				queue.push(action)
				var wdmg = maxi(1, wb.hp / 16)
				remove_hp(wi, wdmg)
				action = BattleQueueAction.new()
				action.type = action.DAMAGE
				action.damage_target_index = wi
				action.damage_effectiveness = 1.0
				queue.push(action)
				if post_damage_checks(wi):
					return queue
		weather_turns -= 1
		if weather_turns <= 0:
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			match weather:
				"sun": action.battle_text = bt("The sunlight faded.", [])
				"rain": action.battle_text = bt("The rain stopped.", [])
				"sandstorm": action.battle_text = "The sandstorm subsided."
				"hail": action.battle_text = "The hail stopped."
			queue.push(action)
			weather = ""
	for battler_effects_index in range(1,5):
		var battler_by_index = get_battler_by_index(battler_effects_index)
		# Flinch and Protect never carry over to the next turn
		var fx_list = get_effects_by_index(battler_effects_index)
		for i in range(fx_list.size() - 1, -1, -1):
			if fx_list[i].effect == BattleEffect.effects.FLINCH or fx_list[i].effect == BattleEffect.effects.PROTECTED or fx_list[i].effect == BattleEffect.effects.ENDURING:
				fx_list.remove_at(i)
		# Effects
		for effect in get_effects_by_index(battler_effects_index):
			match effect.effect:
				BattleEffect.effects.SEEDED:
					action.type = action.BATTLE_TEXT
					action.battle_text = get_battler_title_by_index(battler_effects_index) + " is seeded!"
					queue.push(action)

					var damage = battler_by_index.hp / 16
					if damage < 1:
						damage = 1
					remove_hp(battler_effects_index, damage)
					
					# Heal
					var current_hp = get_battler_by_index(effect.seeded_heal_target_index).current_hp
					if current_hp + damage >= get_battler_by_index(effect.seeded_heal_target_index).hp:
						get_battler_by_index(effect.seeded_heal_target_index).current_hp = get_battler_by_index(effect.seeded_heal_target_index).hp
					else:
						get_battler_by_index(effect.seeded_heal_target_index).current_hp += damage

					action = BattleQueueAction.new()
					action.type = action.DAMAGE
					action.damage_target_index = battler_effects_index
					action.damage_effectiveness = 1.0
					queue.push(action)

					action = BattleQueueAction.new()
					action.type = action.HEAL
					action.damage_target_index = effect.seeded_heal_target_index
					queue.push(action)

					if post_damage_checks(battler_effects_index):
						return queue
				BattleEffect.effects.PERISH:
					effect.turn_count -= 1
					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = get_battler_title_by_index(battler_effects_index) + "'s perish count\nfell to " + str(effect.turn_count) + "!"
					queue.push(action)
					if effect.turn_count <= 0:
						remove_hp(battler_effects_index, battler_by_index.current_hp)
						action = BattleQueueAction.new()
						action.type = action.DAMAGE
						action.damage_target_index = battler_effects_index
						action.damage_effectiveness = 1.0
						queue.push(action)
						if post_damage_checks(battler_effects_index):
							return queue
				BattleEffect.effects.MIST:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.MIST)
				BattleEffect.effects.SAFEGUARD:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.SAFEGUARD)
				BattleEffect.effects.NIGHTMARE:
					if battler_by_index.major_ailment != MajorAilment.SLEEP:
						remove_effect(battler_effects_index, BattleEffect.effects.NIGHTMARE)
					else:
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(battler_effects_index) + " is locked\nin a nightmare!"
						queue.push(action)
						remove_hp(battler_effects_index, maxi(1, battler_by_index.hp / 4))
						action = BattleQueueAction.new()
						action.type = action.DAMAGE
						action.damage_target_index = battler_effects_index
						action.damage_effectiveness = 1.0
						queue.push(action)
						if post_damage_checks(battler_effects_index):
							return queue
				BattleEffect.effects.CURSED:
					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = get_battler_title_by_index(battler_effects_index) + " is afflicted\nby the curse!"
					queue.push(action)
					remove_hp(battler_effects_index, maxi(1, battler_by_index.hp / 4))
					action = BattleQueueAction.new()
					action.type = action.DAMAGE
					action.damage_target_index = battler_effects_index
					action.damage_effectiveness = 1.0
					queue.push(action)
					if post_damage_checks(battler_effects_index):
						return queue
				BattleEffect.effects.WISH:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.WISH)
						var wb2 = get_battler_by_index(battler_effects_index)
						if wb2.current_hp > 0 and wb2.current_hp < wb2.hp:
							wb2.current_hp = mini(wb2.hp, wb2.current_hp + wb2.hp / 2)
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(battler_effects_index) + "'s wish\ncame true!"
							queue.push(action)
							action = BattleQueueAction.new()
							action.type = action.HEAL
							action.damage_target_index = battler_effects_index
							queue.push(action)
				BattleEffect.effects.RAMPAGE:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.RAMPAGE)
						# Original 0x0D2: confusion at the end of the rampage
						if get_effect_from_effects(BattleEffect.effects.CONFUSED, battler_effects_index) == null:
							var cfx = BattleEffect.new()
							cfx.effect = BattleEffect.effects.CONFUSED
							cfx.turn_count = Global.rng.randi_range(2, 5)
							get_effects_by_index(battler_effects_index).append(cfx)
							action = BattleQueueAction.new()
							action.type = action.BATTLE_TEXT
							action.battle_text = get_battler_title_by_index(battler_effects_index) + " became confused\ndue to fatigue!"
							queue.push(action)
				BattleEffect.effects.REFLECT:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.REFLECT)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(battler_effects_index) + "'s Reflect\nwore off!"
						queue.push(action)
				BattleEffect.effects.LIGHT_SCREEN:
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						remove_effect(battler_effects_index, BattleEffect.effects.LIGHT_SCREEN)
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(battler_effects_index) + "'s Light Screen\nwore off!"
						queue.push(action)
				BattleEffect.effects.BOUND:
					# Original end-of-round MultiTurn: chip totalhp/16, expire at 0 turns
					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = bt("{1} is hurt by {2}!", [get_battler_title_by_index(battler_effects_index), tr(effect.bound_move_name)])
					queue.push(action)
					var bind_damage = battler_by_index.hp / 16
					if bind_damage < 1:
						bind_damage = 1
					remove_hp(battler_effects_index, bind_damage)
					action = BattleQueueAction.new()
					action.type = action.DAMAGE
					action.damage_target_index = battler_effects_index
					action.damage_effectiveness = 1.0
					queue.push(action)
					effect.turn_count -= 1
					if effect.turn_count <= 0:
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = get_battler_title_by_index(battler_effects_index) + " was freed\nfrom " + effect.bound_move_name + "!"
						queue.push(action)
						remove_effect(battler_effects_index, BattleEffect.effects.BOUND)
					if post_damage_checks(battler_effects_index):
						return queue
				BattleEffect.effects.SLEEP_COUNTER:
					effect.turn_count -= 1
				BattleEffect.effects.DROWSY:
					if effect.turn_count == 0:
						# Set sleep
						action = BattleQueueAction.new()
						action.type = action.BATTLE_TEXT
						action.battle_text = bt("{1} fell asleep!", [get_battler_title_by_index(battler_effects_index)])
						queue.push(action)
						battler_by_index.major_ailment = MajorAilment.SLEEP
						action = BattleQueueAction.new()
						action.type = action.UPDATE_MAJOR_AILMENT
						action.damage_target_index = battler_effects_index
						queue.push(action)

						# Remove Drowsey and add sleep_counter
						remove_effect(battler_effects_index, BattleEffect.effects.DROWSY)
						var new_effect = BattleEffect.new()
						new_effect.effect = BattleEffect.effects.SLEEP_COUNTER
						new_effect.turn_count = Global.rng.randi_range(1,3)
						new_effect.turn_count += 1 # Add one due to being decremented on the next loop
						get_effects_by_index(battler_effects_index).append(new_effect)
					else:
						effect.turn_count -= 1
				BattleEffect.effects.ENCORE:
					effect.turn_count -= 1
					if effect.turn_count == 0:
						remove_effect(battler_effects_index, BattleEffect.effects.ENCORE)



	
	# Post-Turn Major Ailments
	for battler_ailment_index in range(1,5):
		var battler_ailment = get_battler_by_index(battler_ailment_index)
		if battler_ailment != null && battler_ailment.major_ailment != null:
			match battler_ailment.major_ailment:
				MajorAilment.BURN:
					var damage = battler_ailment.hp / 8

					if damage < 1:
						damage = 1

					remove_hp(battler_ailment_index, damage)
					action = BattleQueueAction.new()
					action.type = action.DAMAGE
					action.damage_target_index = battler_ailment_index
					action.damage_effectiveness = 1.0
					queue.push(action)

					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = bt("{1} is hurt by its burn!", [get_battler_title_by_index(battler_ailment_index)])
					queue.push(action)

					if post_damage_checks(battler_ailment_index):
						return queue
				MajorAilment.POISON: # Note Badly poison mechanic is not implemented
					var damage = battler_ailment.hp / 8

					if damage < 1:
						damage = 1
					remove_hp(battler_ailment_index, damage)
				
					action = BattleQueueAction.new()
					action.type = action.DAMAGE
					action.damage_target_index = battler_ailment_index
					action.damage_effectiveness = 1.0
					queue.push(action)

					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = bt("{1} is hurt by poison!", [get_battler_title_by_index(battler_ailment_index)])
					queue.push(action)

					if post_damage_checks(battler_ailment_index):
						return queue

	# Print out the action queue for debug
	if battle_debug:
		print("Action queue size: " + str(queue.queue.size()))
		var action_index = 0
		for actions in queue.queue:
			print("Action #" + str(action_index) + ". Type: " + actions.get_type_name())# + ". Battler:" + str(action.)
			action_index = action_index + 1

		print("Battler 2 hp: " + str(battler2.current_hp) + "/" + str(battler2.hp))
	return queue
func get_turn_order(player_command : BattleCommand, foe_command : BattleCommand): # For single battles
	# Find out which comand goes in which order.
			# General turn order:
			# 1. Item use/Runing
			# 2. Switching
			# 3. Megaevolution
			# 4. Higher priority attack moves
			# 5. Higher speed
			# 6. Random
			
	# Calculate turn_order
	if player_command.command_type == player_command.RUN:
		can_escape = false

		if battler1.speed > battler2.speed:
			can_escape = true
		else:
			escape_attempts += 1
			#warning-ignore:INTEGER_DIVISION
			var f = ( (battler1.speed * 128) / battler2.speed ) + 30 * escape_attempts
			f = posmod(int(f), 256)
			if Global.rng.randi_range(0,255) < f:
				can_escape = true
		if !can_escape:
			var action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			action.battle_text = bt("Can't escape!", [])
			queue.push(action)
			turn_order.push_back(B2)
			return
	if player_command.command_type == player_command.USE_BAG_ITEM || player_command.command_type == player_command.SWITCH_POKE:
		turn_order.push_back(B2)
		return

	if player_command.command_type == player_command.ATTACK && foe_command.command_type == foe_command.ATTACK:
		
		print("Proccessing turn order logic for if both commands are attacks")
		
		# Clear out turn array
		turn_order.clear()
		
		# Higher priority attack moves
		# Match attack comand to move.
		var move_b1 = get_poke_move_by_name(battler1, player_command.attack_move)
		var move_b2 = get_poke_move_by_name(battler2, foe_command.attack_move)
		if move_b1.priority > move_b2.priority:
			turn_order.push_back(B1)
			turn_order.push_back(B2)
		elif move_b1.priority < move_b2.priority:
			turn_order.push_back(B2)
			turn_order.push_back(B1)
		else: # If move priority is the same, faster in-battle speed attack moves.
			# Calculate effective in-battle speed
			var b1_speed = battler1.speed
			var b2_speed = battler2.speed
			b1_speed = b1_speed * BattleStatStage.get_multiplier(battler1_stat_stage.speed)
			b2_speed = b2_speed * BattleStatStage.get_multiplier(battler2_stat_stage.speed)
			if battler1.major_ailment == MajorAilment.PARALYSIS:
				b1_speed = b1_speed / 2.0
			if battler2.major_ailment == MajorAilment.PARALYSIS:
				b2_speed = b2_speed / 2.0
			# Weather speed abilities
			if (get_ability(1) == "Swift Swim" and weather == "rain") or (get_ability(1) == "Chlorophyll" and weather == "sun"):
				b1_speed *= 2.0
			if (get_ability(2) == "Swift Swim" and weather == "rain") or (get_ability(2) == "Chlorophyll" and weather == "sun"):
				b2_speed *= 2.0
			# Check who has higher speed
			if b1_speed > b2_speed:
				turn_order.push_back(B1)
				turn_order.push_back(B2)
			elif b1_speed < b2_speed:
				turn_order.push_back(B2)
				turn_order.push_back(B1)
			else: # Random
				if Global.rng.randi_range(0,1) == 1:
					turn_order.push_back(B1)
					turn_order.push_back(B2)
				else:
					turn_order.push_back(B2)
					turn_order.push_back(B1)
		#print("Turn order size: " + str(turn_order.size()))
func does_attack_hit(move : Move, target_index : int, attaker_index : int):
	if target_index == attaker_index: # Moves that effects self
		return true

	match move.name:
		"Yawn":
			return true

	if move.mechanic != null and move.mechanic.get("kind") == "never_miss":
		return true

	# Two-turn moves (0x0CA Dig family): charge turn sets the effect and the move doesn't resolve;
	# while charging, incoming attacks miss; the release turn removes the effect and resolves normally.
	if move.mechanic != null and move.mechanic.get("kind") == "two_turn":
		var ch = get_effect_from_effects(BattleEffect.effects.CHARGING, attaker_index)
		if ch == null:
			var cfx2 = BattleEffect.new()
			cfx2.effect = BattleEffect.effects.CHARGING
			cfx2.rampage_move_name = move.name
			get_effects_by_index(attaker_index).append(cfx2)
			var cact = BattleQueueAction.new()
			cact.type = cact.BATTLE_TEXT
			cact.battle_text = get_battler_title_by_index(attaker_index) + move.mechanic.get("charge_text", " is charging power!")
			queue.push(cact)
			return false
		else:
			remove_effect(attaker_index, BattleEffect.effects.CHARGING)
	if target_index != attaker_index and does_index_has_effect(target_index, BattleEffect.effects.CHARGING):
		return false

	# Sand Veil: the defender is harder to hit in a sandstorm
	if weather == "sandstorm" and target_index != attaker_index and get_ability(target_index) == "Sand Veil":
		if Global.rng.randi_range(0, 99) >= 80:
			return false

	# Hurricane (0x015): perfect accuracy in rain, 50 in harsh sun
	if move.mechanic != null and move.mechanic.get("kind") == "acc_rain_perfect":
		if weather == "rain":
			return true
		if weather == "sun":
			return Global.rng.randi_range(0, 99) < 50

	# OHKO accuracy (original 0x070): fails vs higher level; acc = base + (userLv - targetLv)
	if move.mechanic != null and move.mechanic.get("kind") == "ohko":
		var atk_b = get_battler_by_index(attaker_index)
		var tgt_b = get_battler_by_index(target_index)
		if tgt_b.level > atk_b.level:
			return false
		return Global.rng.randi_range(0, 99) < move.accuracy + atk_b.level - tgt_b.level

	var target_stage = get_stage_stat_by_index(target_index)
	var attacker_stage = get_stage_stat_by_index(attaker_index)
	
	var accuracy

	# Check if target has been foresighted
	if does_index_has_effect(target_index, BattleEffect.effects.FORESIGHT) && target_stage.evasion > 0:
		accuracy = move.accuracy * BattleStatStage.get_multiplier(attacker_stage.accuracy)
	else:
		accuracy = move.accuracy * BattleStatStage.get_multiplier(attacker_stage.accuracy - target_stage.evasion)
	
	if accuracy > 100:
		accuracy = 100
	var value = Global.rng.randi_range(0, 99)

	#print("Accuracy is: " + str(accuracy) + ", rng is: " + str(value))

	if accuracy > value:
		return true
	else:
		return false
func get_battler_by_index(index: int):
	match index:
		1:
			return battler1
		2:
			return battler2
		3:
			return battler3
		4:
			return battler4
		_:
			print("Battle Error: invalid index was given returned null")
func get_stage_stat_by_index(index: int):
	match index:
		1:
			return battler1_stat_stage
		2:
			return battler2_stat_stage
		3:
			return battler3_stat_stage
		4:
			return battler4_stat_stage
func get_effects_by_index(index: int):
	match index:
		1:
			return battler1_effects
		2:
			return battler2_effects
		3:
			return battler3_effects
		4:
			return battler4_effects
func get_poke_move_by_name(poke, move_name):
	if poke.move_1 != null:
		if poke.move_1.name == move_name:
			return poke.move_1
	if poke.move_2 != null:
		if poke.move_2.name == move_name:
				return poke.move_2
	if poke.move_3 != null:
		if poke.move_3.name == move_name:
			return poke.move_3
	if poke.move_4 != null:
		if poke.move_4.name == move_name:
			return poke.move_4
func calculate_exp(defeated_poke : Pokemon) -> int:
	var experience : int
	
	var a = 1.0 # Trainer bonus. 1.0 if wild. 1.5 if Trainer.
	var t = 1.0 # Owner bonus. 1.0 if winning pokemon is original owner. 1.5 if traded. TODO: add support
	var b = 0 # Base exp yield of defeated pokemon.
	var e = 1.0 # Lucky Egg bounus. 1.5 if holding Lucky Egg.
	var f = 1.0 # Affection bounus. Not used in Uranium
	var L = 0 # Level of fainted/caught pokemon.
	var p = 1 # Exp Point Power. Not used in Uranium
	var s = 1 # EXP All modifier. TODO: Add support
	var v = 1 # Evolve modifier. Not used in Uranium

	b = defeated_poke.get_exp_yield()

	if battle_instance.battle_type != battle_instance.BattleType.SINGLE_WILD && battle_instance.battle_type != battle_instance.BattleType.DOUBLE_WILD:
		a = 1.5
	L = defeated_poke.level
	experience = int((a * t * b * e * L * p * f * v) / (7 * s))
	return experience
func check_player_out_of_poke() -> bool:
	var result = true
	for poke in Global.pokemon_group:
		if poke.current_hp != 0:
			result = false
	return result
func check_foe_out_of_poke() -> bool:
	var result = true
	for poke in battle_instance.opponent.pokemon_group:
		if poke.current_hp != 0:
			result = false
	return result
func does_crit(crit : int) -> bool: # Gen 6 ladder: 1/16, 1/8, 1/2, always
	if crit <= 1:
		return Global.rng.randi_range(1, 16) == 1
	elif crit == 2:
		return Global.rng.randi_range(1, 8) == 1
	elif crit == 3:
		return Global.rng.randi_range(1, 2) == 1
	return true
func one_in_n_chance(n : int) -> bool:
	var rng = Global.rng
	var value = rng.randi_range(1,n)
	if value == 1:
		return true
	return false
func percent_chance(n : float) -> bool:
	#warning-ignore:NARROWING_CONVERSION
	if one_in_n_chance(1/n):
		return true
	return false
func post_damage_checks(battler_index: int) -> bool: # Checks for when any damage is done to battlers. Returns true if the battle is over or if player or foe needs to send out new poke.
	# Check if target faints.
	if get_battler_by_index(battler_index).current_hp == 0:
		# Faint actions
		var action = BattleQueueAction.new()
		action.type = action.FAINT
		action.damage_target_index = battler_index
		queue.push(action)

		action = BattleQueueAction.new()
		action.type = action.BATTLE_TEXT
		var get_exp = false
		if battler_index == 2 || battler_index == 4:
			action.battle_text = bt("{1} fainted!", [bt("The foe {1}", [tr(get_battler_by_index(battler_index).name)])])
			get_exp = true
		if battler_index == 1 || battler_index == 3:
			action.battle_text = bt("{1} fainted!", [tr(get_battler_by_index(battler_index).name)])
		queue.push(action)

		get_battler_by_index(battler_index).major_ailment = null
		
		# If foe faint add exp to player pokemon. For now just only apply to current player pokemon
		if get_exp:
			action = BattleQueueAction.new()
			action.type = action.BATTLE_TEXT
			var exp_gained : int = calculate_exp(get_battler_by_index(battler_index))
			action.battle_text = bt("{1} gained {2} Exp. Points!", [tr(battler1.name), exp_gained])
			queue.push(action)
			
			# Add exp to pokemon
			battler1.experience += exp_gained

			# TODO: Add leveling up
			# TODO: Add multiple exp_gain actions if leveling more that 1 time.
			var levelUptimes = battler1.get_level_up_times()
			if levelUptimes == 0: # Did not level up. Just add exp
				#print("Did not level up.")
				action = BattleQueueAction.new()
				action.type = action.EXP_GAIN
				action.exp_gain_percent = battler1.get_exp_bar_percent()
				queue.push(action)
			else:
				for i in range(levelUptimes): # For each time you level up
					#print("Level up.")
					action = BattleQueueAction.new()
					action.type = action.EXP_GAIN
					action.exp_gain_percent = 1.0
					queue.push(action)
					
					action = BattleQueueAction.new()
					action.type = action.LEVEL_UP_SE
					action.level = battler1.level + i + 1
					var new_level = action.level
					queue.push(action)

					action = BattleQueueAction.new()
					action.type = action.BATTLE_TEXT
					action.battle_text = get_battler_title_by_index(1) + " grew to Lv. " + str(new_level) + "!"
					action.press_to_continue = true
					queue.push(action)

					action = BattleQueueAction.new()
					action.type = action.LEVEL_UP
					# Apply Level Up changes to pokemon here:
					battler1.level += 1
					var changes = battler1.update_stats()
					action.level_stat_changes = changes
					
					queue.push(action)
				# Residual exp
				action = BattleQueueAction.new()
				action.type = action.EXP_GAIN
				action.exp_gain_percent = battler1.get_exp_bar_percent()
				queue.push(action)


			# Adding effort values
			battler1.add_ev(get_battler_by_index(battler_index))
			
		# Check if player or foe runs out of pokemon
		var player_defeated = check_player_out_of_poke()
		var foe_defeated = check_foe_out_of_poke()
		if player_defeated || foe_defeated:
			action = BattleQueueAction.new()
			action.type = action.BATTLE_END

			if player_defeated == false && foe_defeated == true:
				action.winner = action.PLAYER_WIN
			if player_defeated == true && foe_defeated == false:
				action.winner = action.FOE_WIN
			queue.push(action)
			return true

		# Add new poke action
		action = BattleQueueAction.new()
		action.type = action.NEXT_POKE
		action.damage_target_index = battler_index
		queue.push(action)
		return true

	return false
func get_battler_title_by_index(battler_index: int) -> String:
	var _nm = tr(get_battler_by_index(battler_index).name)
	if battler_index == 2 || battler_index == 4:
		if battle_instance.battle_type == BattleInstanceData.BattleType.SINGLE_WILD:
			return bt("The wild {1}", [_nm])
		return bt("The foe {1}", [_nm])
	return _nm
# Battle weather: "" / "sun" / "rain" / "sandstorm" / "hail" (original: 5 turns)
var weather := ""
var weather_turns := 0

# Round-scoped state for move mechanics (protect, revenge...)
var acted_this_round := 0
var turn_damage_taken := {}
var protect_rates := {}
var fury_counts := {}
var _intro_abilities_done := false

func remove_hp(index: int, damage: int): # Still need to call post_damage_checks mannually after this!
	var target = get_battler_by_index(index)
	var current_hp = target.current_hp
	if current_hp - damage < 0:
		target.current_hp = 0
	else:
		target.current_hp = current_hp - damage
func get_effect_from_effects(effect_enum: int, battler_index : int): # Returns the specified BattleEffect, else null
	for effect in get_effects_by_index(battler_index):
		if effect.effect == effect_enum:
			return effect
	return null
func set_major_ailment(index: int, ailment_code: int, turns: int = -1): # Sets the MajorAilment and coresponding actions
	var action = BattleQueueAction.new()
	action.type = action.BATTLE_TEXT

	var st_ab = ""
	var b_ail = get_battler_by_index(index)
	if b_ail != null and b_ail.ability != null:
		st_ab = str(b_ail.ability)
	if (st_ab == "Limber" and ailment_code == MajorAilment.PARALYSIS) \
			or (st_ab in ["Insomnia", "Vital Spirit"] and ailment_code == MajorAilment.SLEEP) \
			or (st_ab == "Immunity" and ailment_code == MajorAilment.POISON) \
			or (st_ab == "Water Veil" and ailment_code == MajorAilment.BURN) \
			or (st_ab == "Magma Armor" and ailment_code == MajorAilment.FROZEN):
		action.battle_text = get_battler_title_by_index(index) + "'s " + st_ab + "\nprevents the status!"
		queue.push(action)
		return
	if get_battler_by_index(index).major_ailment == null:
		match ailment_code:
			MajorAilment.BURN:
				action.battle_text = bt("{1} was burned!", [get_battler_title_by_index(index)])
			MajorAilment.FROZEN:
				action.battle_text = bt("{1} was frozen solid!", [get_battler_title_by_index(index)])
			MajorAilment.POISON:
				action.battle_text = bt("{1} was poisoned!", [get_battler_title_by_index(index)])
			MajorAilment.SLEEP:
				action.battle_text = bt("{1} fell asleep!", [get_battler_title_by_index(index)])
			MajorAilment.PARALYSIS:
				action.battle_text = bt("{1} is paralyzed! It may be unable to move!", [get_battler_title_by_index(index)])
		queue.push(action)

		get_battler_by_index(index).major_ailment = ailment_code
		if get_battler_by_index(index).major_ailment == MajorAilment.SLEEP:
			var effect = BattleEffect.new()
			effect.effect = BattleEffect.effects.SLEEP_COUNTER
			if turns == -1:
				effect.turn_count = Global.rng.randi_range(1, 3)
			else:
				effect.turn_count = turns
			get_effects_by_index(index).append(effect)
		action = BattleQueueAction.new()
		action.type = action.UPDATE_MAJOR_AILMENT
		action.damage_target_index = index
		queue.push(action)
	else:
		action.battle_text = bt("But it failed!")
		queue.push(action)
func get_ball_catch_rate(ball_id: int) -> float:
	var rate : float = 1.0
	match ball_id:
		211: # Poke Ball
			rate = 1.0
		210: # Great Ball
			rate = 1.5
		209: # Ultra Ball:
			rate = 2.0
		208: # Master Ball:
			rate = 255.0
		_:
			print("Battle Error: ball_id did not match any listed. Using default value.")
	return rate
func get_status_effect_by_move_name(name: String):
	return MoveDataBase.get_move_by_name(name).main_status_effect
func get_past_moves_by_index(index):
	match index:
		1:
			return battler1_past_moves
		2:
			return battler1_past_moves
		3:
			return battler1_past_moves
		4:
			return battler1_past_moves
func does_index_has_effect(index, effect_enum) -> bool:
	if get_effect_from_effects(effect_enum, index) != null:
		return true
	return false
func check_if_battle_is_over() -> bool:
	# Check if player or foe runs out of pokemon
	var player_defeated = check_player_out_of_poke()
	var foe_defeated = check_foe_out_of_poke()
	if player_defeated || foe_defeated:
		var action = BattleQueueAction.new()
		action.type = action.BATTLE_END

		if player_defeated == false && foe_defeated == true:
			action.winner = action.PLAYER_WIN
		if player_defeated == true && foe_defeated == false:
			action.winner = action.FOE_WIN
		queue.push(action)
		return true
	return false
func get_move_from_name_from_battler(move_name, battler_index) -> Move: # Returns the move of the battler by the move's name
	var poke = get_battler_by_index(battler_index)
	if poke.move_1 != null && poke.move_1.name == move_name:
		return poke.move_1
	if poke.move_2 != null && poke.move_2.name == move_name:
		return poke.move_2
	if poke.move_3 != null && poke.move_3.name == move_name:
		return poke.move_3
	if poke.move_4 != null && poke.move_4.name == move_name:
		return poke.move_4
	return null
func remove_effect(battler_index, effect_enum):
	var index = 0
	for eff in get_effects_by_index(battler_index):
		if eff.effect == effect_enum:
			break
		else:
			index += 1
	
	get_effects_by_index(battler_index).remove_at(index)


func _emit_protected_text(target_index: int) -> bool:
	var action = BattleQueueAction.new()
	action.type = action.BATTLE_TEXT
	action.battle_text = get_battler_title_by_index(target_index) + "\nprotected itself!"
	queue.push(action)
	return true


func get_ability(index: int) -> String:
	var b = get_battler_by_index(index)
	if b == null or b.ability == null:
		return ""
	return str(b.ability)


func bt(pattern: String, args: Array = []) -> String:
	var s = tr(pattern)
	for i in range(args.size()):
		s = s.replace("{" + str(i + 1) + "}", str(args[i]))
	return s
