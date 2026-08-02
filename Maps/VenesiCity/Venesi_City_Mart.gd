extends Node2D # gen_map.py Map079

var map_name = "Venesi City(Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 208):
		Global.game.play_dialogue("MAP079_NPC_1")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'ULTRABALL', 'SUPERPOTION', 'HYPERPOTION', 'REVIVE', 'PARLYZHEAL', 'ANTIDOTE', 'FULLHEAL', 'REPEL', 'SUPERREPEL', 'ESCAPEROPE'])
	return null
