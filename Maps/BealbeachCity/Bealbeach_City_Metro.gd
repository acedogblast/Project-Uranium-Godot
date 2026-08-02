extends Node2D # gen_map.py Map003

var map_name = "Bealbeach City(Metro)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 240):
		Global.game.play_dialogue("MAP003_NPC_1")
	if check_pos == Vector2(272, 112):
		Global.game.open_shop(['TURTICKET'])
	return null
