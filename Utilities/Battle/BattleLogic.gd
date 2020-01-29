extends Object
class_name BattleLogic

var turn_order = []
enum {B1, B2, B3, B4} # Used for turn order and indicating which poke in battle

var battler1 : Pokemon # Player's pokemon
var battler2 : Pokemon # Foe's pokemon
var battler3 : Pokemon # Player's second pokemon in double battles
var battler4 : Pokemon # Foe's second pokemonin double battles

var battler1_stat_stage : BattleStatStage
var battler2_stat_stage : BattleStatStage
var battler3_stat_stage : BattleStatStage
var battler4_stat_stage : BattleStatStage

var battle_instance : BattleInstanceData

func _init(b1, b2 , bid):
    battler1 = b1
    battler2 = b2
    battler1_stat_stage = load("res://Utilities/Battle/Classes/BattleStatStage.gd").new()
    battler2_stat_stage = load("res://Utilities/Battle/Classes/BattleStatStage.gd").new()
    battle_instance = bid
    pass
func generate_action_queue(player_command : BattleCommand, foe_command : BattleCommand):
    var queue = BattleQueue.new()
    get_turn_order(player_command, foe_command)
    # Arrange Battle actions once turn orders are calculated
    
    var battler
    var battler_index
    var command
    while !turn_order.empty():
        var action = BattleQueueAction.new()
        action.type = action.BATTLE_TEXT
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
            action.battle_text = battler.name + " used\n" + command.attack_move + "!"
            queue.push(action)
            # Decrement move PP, PP should be at least 1 at this point.
            move.remaining_pp = move.remaining_pp - 1
            # Calculate if move hits or not
            
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
            if does_attack_hit(move, target_index, battler_index):
                
                match move.style:
                    MoveStyle.PHYSICAL, MoveStyle.SPECIAL:
                        # If move can crit calculate if crit or not.
                        var crit = 0
                        var did_crit = false
                        match crit:
                            0: # 1/16
                                var rng = RandomNumberGenerator.new()
                                rng.randomize()
                                var value = rng.randi_range(1,16)
                                if value == 1:
                                    did_crit = true
                            1: # 1/8
                                var rng = RandomNumberGenerator.new()
                                rng.randomize()
                                var value = rng.randi_range(1,8)
                                if value == 1:
                                    did_crit = true
                            2: # 1/4
                                var rng = RandomNumberGenerator.new()
                                rng.randomize()
                                var value = rng.randi_range(1,4)
                                if value == 1:
                                    did_crit = true
                            3: # 1/3
                                var rng = RandomNumberGenerator.new()
                                rng.randomize()
                                var value = rng.randi_range(1,3)
                                if value == 1:
                                    did_crit = true
                            _: # 1/2
                                var rng = RandomNumberGenerator.new()
                                rng.randomize()
                                var value = rng.randi_range(1,2)
                                if value == 1:
                                    did_crit = true
                        
                        # Calculate damage done.
                        var raw_damage: int = 0
                        var base_damage: int = 0
                        var total_damage_modifier: float = 1.0
                        var target_modifier: float = 1.0
                        var weather_modifier: float = 1.0
                        var critical_modifier: float = 1.0
                        var STAB_modifier: float = 1.0
                        var random_modifier: float = 1.0
                        var type_modifer: float = 1.0
                        var other_modifer: float = 1.0

                        var effective_attacker_stat = BattleStatStage.get_multiplier(get_stage_stat_by_index(battler_index).attack) * battler.attack



                        var effective_defender_stat = BattleStatStage.get_multiplier(get_stage_stat_by_index(target_index).defense) * get_battler_by_index(target_index).defense
                        
                        base_damage = int(
                            ( ( (2 * battler.level) / 5 ) + 2 ) * move.base_power * (effective_attacker_stat / effective_defender_stat)
                        )
                        base_damage = (base_damage / 50) + 2
                        
                        if did_crit:
                            critical_modifier = 2.0
                        if move.type == battler.type1 || move.type == battler.type2:
                            STAB_modifier = 1.5
                        var rng = RandomNumberGenerator.new()
                        rng.randomize()
                        random_modifier = rng.randf_range(0.85,1.0)
                        
                        type_modifer = Type.type_advantage_multiplier(move.type, get_battler_by_index(target_index))
                        total_damage_modifier = target_modifier * weather_modifier * critical_modifier * STAB_modifier * random_modifier * type_modifer * other_modifer
                        raw_damage = base_damage * total_damage_modifier

                        print("Raw Damage: " + str(raw_damage) + " , To battler: " + str(target_index))

                        # Perform the damage to battler
                        var current_hp = get_battler_by_index(target_index).current_hp
                        if (raw_damage >= current_hp): # Target runs out of hp and faints
                            raw_damage = current_hp
                            get_battler_by_index(target_index).current_hp = 0
                        else:
                            get_battler_by_index(target_index).current_hp = current_hp - raw_damage
                        
                        # Add in the battle actions
                        action = BattleQueueAction.new()
                        action.type = action.DAMAGE
                        action.damage_target_index = target_index
                        action.damage_amount = raw_damage
                        action.damage_effectiveness = type_modifer
                        queue.push(action)

                        if critical_modifier == 2.0:
                            action = BattleQueueAction.new()
                            action.type = action.BATTLE_TEXT
                            action.battle_text = "Critical Hit!"
                            queue.push(action)
                        # Add in the effective damage message
                        if type_modifer > 1.0:
                            action = BattleQueueAction.new()
                            action.type = action.BATTLE_TEXT
                            action.battle_text = "It's super effective!"
                            queue.push(action)
                        if type_modifer < 1.0:
                            action = BattleQueueAction.new()
                            action.type = action.BATTLE_TEXT
                            action.battle_text = "It's not very effective..."
                            queue.push(action)
                            
                        # Check if target faints.
                        if get_battler_by_index(target_index).current_hp == 0:
                            # Faint actions
                            action = BattleQueueAction.new()
                            action.type = action.FAINT
                            action.damage_target_index = target_index
                            queue.push(action)

                            action = BattleQueueAction.new()
                            action.type = action.BATTLE_TEXT
                            var get_exp = false
                            if target_index == 2 || target_index == 4:
                                action.battle_text = "The foe " + get_battler_by_index(target_index).name + " fainted!"
                                get_exp = true
                            if target_index == 1 || target_index == 3:
                                action.battle_text = get_battler_by_index(target_index).name + " fainted!"
                            queue.push(action)
                            
                            # If foe faint add exp to player pokemon. For now just only apply to current player pokemon
                            # Also add effort values
                            if get_exp:
                                action = BattleQueueAction.new()
                                action.type = action.BATTLE_TEXT
                                var exp_gained : int = calculate_exp(get_battler_by_index(target_index))
                                action.battle_text = battler.name + " gained\n" + str(exp_gained) + " EXP. Points!"
                                queue.push(action)
                                
                                # Add exp to pokemon
                                battler.experience += exp_gained

                                
                                # TODO: Add multiple exp_gain actions if leveling more that 1 time.
                                action = BattleQueueAction.new()
                                action.type = action.EXP_GAIN
                                action.exp_gain_percent = battler.get_exp_bar_percent()
                                queue.push(action)

                                # Adding effort values
                                battler.add_ev(get_battler_by_index(target_index))


                            # TODO: Add leveling up


                            


                            # Check if foe or player ran out of pokemon, if yes end battle
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
                                return queue
                        pass
                    MoveStyle.STATUS:
                        var stat_effect = move.main_status_effect
                        if get_stage_stat_by_index(battler).apply_stat_effect(stat_effect) != true:


                            pass
                        else:



                            pass
                    
                        pass




                


            else:
                # Add missed mesage.
                action = BattleQueueAction.new()
                action.type = action.BATTLE_TEXT
                action.battle_text = battler.name + "'s\nattack missed!"
                queue.push(action)

    # Print out the action queue for debug
    print("Action queue size: " + str(queue.queue.size()))
    
    var action_index = 0
    for action in queue.queue:
        print("Action #" + str(action_index) + ". Type: " + str (action.type))# + ". Battler:" + str(action.)
        action_index = action_index + 1
    return queue
func get_turn_order(player_command : BattleCommand, foe_command : BattleCommand): # For singal battles
    # Find out which comand goes in which order.
			# General turn order:
			# 1. Item use/Runing
			# 2. Switching
			# 3. Megaevolution
			# 4. Higher priority attack moves
			# 5. Higher speed
			# 6. Random
			
	# For now only attack moves are avaliable
    # Calculate turn_order


    if player_command.command_type == player_command.ATTACK && foe_command.command_type == foe_command.ATTACK:
        
        print("Proccessing logic for if both commands are attacks")
        
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
            if battler1.major_ailment == StatusAilment.Major.PARALYSIS:
                b1_speed = b1_speed / 2.0
            if battler2.major_ailment == StatusAilment.Major.PARALYSIS:
                b2_speed = b2_speed / 2.0
            # Check who has higher speed
            if b1_speed > b2_speed:
                turn_order.push_back(B1)
                turn_order.push_back(B2)
            elif b1_speed < b2_speed:
                turn_order.push_back(B2)
                turn_order.push_back(B1)
            else: # Random
                var rng = RandomNumberGenerator.new()
                rng.randomize()
                if rng.randi_range(0,1) == 1:
                    turn_order.push_back(B1)
                    turn_order.push_back(B2)
                else:
                    turn_order.push_back(B2)
                    turn_order.push_back(B1)
        print("Turn order size: " + str(turn_order.size()))
func does_attack_hit(move : Move, target_index : int, attaker_index : int):
    if target_index == attaker_index: # Moves that efect self
        return true

    var target_stage = get_stage_stat_by_index(target_index)
    var attacker_stage = get_stage_stat_by_index(attaker_index)
    var accuracy = move.accuracy * BattleStatStage.get_multiplier(attacker_stage.accuracy - target_stage.evasion)
    
    if accuracy > 100:
        accuracy = 100
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var value = rng.randi_range(0, 99)

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