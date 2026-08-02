extends Node2D # gen_map.py Map044

var map_name = "Nowtoch City(Metro)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(400, 272):
		Global.game.play_dialogue("MAP044_NPC_1")
	if check_pos == Vector2(304, 144):
		Global.game.open_shop(['TURTICKET'])
	return null
