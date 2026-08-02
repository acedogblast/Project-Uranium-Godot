extends Node2D # gen_map.py Map067

var map_name = "Kevlar Town(Pokemart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(400, 144):
		Global.game.play_dialogue("MAP067_SIGN_1")
	if check_pos == Vector2(432, 144):
		Global.game.play_dialogue("MAP067_SIGN_2")
	if check_pos == Vector2(176, 112):
		Global.game.play_dialogue("MAP067_SIGN_3")
	if check_pos == Vector2(240, 144):
		Global.game.play_dialogue("MAP067_NPC_1")
	if check_pos == Vector2(336, 240):
		Global.game.open_shop(['POKeBALL', 'POTION', 'ANTIDOTE', 'ICEHEAL', 'PARLYZHEAL', 'REPEL', 'ESCAPEROPE'])
	return null
