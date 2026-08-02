extends Node2D # gen_map.py Map158

var map_name = "Vinoville Town(Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 208):
		Global.game.play_dialogue("MAP158_NPC_1")
	if check_pos == Vector2(464, 240):
		Global.game.play_dialogue("MAP158_NPC_2")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'SUPERPOTION', 'POTION', 'ANTIDOTE', 'REPEL', 'SUPERREPEL', 'PARLYZHEAL', 'FULLHEAL'])
	return null
