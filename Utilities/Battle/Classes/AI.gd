extends Object
class_name AI

enum {WILD , TESTING_1}
var AI_Behavior
func get_command(snapshot : BattleSnapshot) -> BattleCommand:
    var command = load("res://Utilities/Battle/Classes/BattleCommand.gd").new()
    if AI_Behavior == TESTING_1:
        # Pick a random attack move
        command.command_type = command.ATTACK
        print("made a broken command by AI.")
        command.attack_move = "Scratch"
        command.attack_target = command.B1
    pass
    return command