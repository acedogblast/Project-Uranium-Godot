extends Node2D # gen_map.py Map126

var map_name = "Bealbeach City"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(112, 240):
		Global.game.play_dialogue("MAP126_NPC_1")
	if check_pos == Vector2(1072, 336):
		Global.game.play_dialogue("MAP126_NPC_2")
	if check_pos == Vector2(1136, 208):
		Global.game.play_dialogue("MAP126_NPC_3")
	return null
