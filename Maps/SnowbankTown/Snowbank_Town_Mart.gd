extends Node2D # gen_map.py Map086

var map_name = "Snowbank Town(Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 208):
		Global.game.play_dialogue("MAP086_NPC_1")
	if check_pos == Vector2(464, 272):
		Global.game.play_dialogue("MAP086_NPC_2")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'ULTRABALL', 'SUPERPOTION', 'HYPERPOTION', 'MAXPOTION', 'REVIVE', 'PARLYZHEAL', 'ANTIDOTE', 'FULLHEAL', 'SUPERREPEL', 'MAXREPEL', 'ESCAPEROPE'])
	return null
