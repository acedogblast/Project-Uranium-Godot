extends Node2D # gen_map.py Map129

var map_name = "Legen Town(Metro)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(208, 272):
		Global.game.play_dialogue("MAP129_NPC_1")
	if check_pos == Vector2(464, 272):
		Global.game.play_dialogue("MAP129_NPC_2")
	if check_pos == Vector2(304, 144):
		Global.game.open_shop(['TURTICKET'])
	return null
