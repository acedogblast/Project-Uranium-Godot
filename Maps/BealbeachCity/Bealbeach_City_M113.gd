extends Node2D # gen_map.py Map113

var map_name = "Bealbeach City"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(368, 272):
		Global.game.play_dialogue("MAP113_NPC_1")
	if check_pos == Vector2(1008, 272):
		Global.game.play_dialogue("MAP113_NPC_2")
	return null
