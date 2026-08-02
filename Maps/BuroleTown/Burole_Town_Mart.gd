extends Node2D # gen_map.py Map004

var map_name = "Burole Town (Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(464, 208):
		Global.game.play_dialogue("MAP004_NPC_1")
	if check_pos == Vector2(240, 144):
		Global.game.play_dialogue("MAP004_NPC_2")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'SUPERPOTION', 'POTION', 'ANTIDOTE', 'ICEHEAL', 'PARLYZHEAL', 'REPEL', 'ESCAPEROPE'])
	return null
