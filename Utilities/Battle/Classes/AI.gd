extends Object
class_name AI

enum {WILD , TESTING_1}
var AI_Behavior
func get_command(snapshot : BattleSnapshot) -> BattleCommand:
	var command = load("res://Utilities/Battle/Classes/BattleCommand.gd").new()
	match AI_Behavior:
		TESTING_1:
			command.command_type = command.ATTACK
			print("made a broken command by AI.")
			command.attack_move = "Leech Seed"
			command.attack_target = command.B1
		WILD:
			# Pick a random attack move
			command.command_type = command.ATTACK
			command.attack_target = command.B1
			var move_index = Global.rng.randi() % snapshot.poke_move_list.size()
			command.attack_move = snapshot.poke_move_list[move_index]
	return command
func get_next_poke(snapshot : BattleSnapshot):
	return null # Let battle.gd figure it out