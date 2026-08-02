extends Node2D # gen_map.py Map082

var map_name = "Silverport Town(Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(176, 208):
		Global.game.play_dialogue("MAP082_NPC_1")
	if check_pos == Vector2(304, 144):
		Global.game.play_dialogue("MAP082_NPC_2")
	if check_pos == Vector2(464, 272):
		Global.game.play_dialogue("MAP082_NPC_3")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'ULTRABALL', 'SUPERPOTION', 'HYPERPOTION', 'REVIVE', 'PARLYZHEAL', 'ANTIDOTE', 'REPEL', 'SUPERREPEL', 'ESCAPEROPE', 'FULLHEAL'])
	return null
