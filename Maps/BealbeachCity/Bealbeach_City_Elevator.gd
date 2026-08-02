extends Node2D # gen_map.py Map058

var map_name = "Bealbeach City(Elevator)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(48, 208):
		Global.game.play_dialogue("MAP058_NPC_1")
	return null
