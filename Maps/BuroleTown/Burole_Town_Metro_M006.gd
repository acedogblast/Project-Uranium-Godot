extends Node2D # gen_map.py Map006

var map_name = "Burole Town(Metro)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(464, 272):
		Global.game.play_dialogue("MAP006_NPC_1")
	return null
