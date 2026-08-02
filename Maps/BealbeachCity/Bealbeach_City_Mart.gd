extends Node2D # gen_map.py Map108

var map_name = "Bealbeach City(Mart)"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(336, 272):
		Global.game.play_dialogue("MAP108_NPC_1")
	if check_pos == Vector2(240, 144):
		Global.game.play_dialogue("MAP108_NPC_2")
	if check_pos == Vector2(464, 240):
		Global.game.play_dialogue("MAP108_NPC_3")
	if check_pos == Vector2(496, 112):
		Global.game.play_dialogue("MAP108_NPC_4")
	if check_pos == Vector2(528, 112):
		Global.game.play_dialogue("MAP108_NPC_5")
	if check_pos == Vector2(1328, 112):
		Global.game.play_dialogue("MAP108_NPC_6")
	if check_pos == Vector2(1136, 240):
		Global.game.play_dialogue("MAP108_NPC_7")
	if check_pos == Vector2(1488, 240):
		Global.game.play_dialogue("MAP108_NPC_8")
	if check_pos == Vector2(2416, 144):
		Global.game.play_dialogue("MAP108_NPC_9")
	if check_pos == Vector2(2384, 272):
		Global.game.play_dialogue("MAP108_NPC_10")
	if check_pos == Vector2(2512, 208):
		Global.game.play_dialogue("MAP108_NPC_11")
	if check_pos == Vector2(3632, 144):
		Global.game.play_dialogue("MAP108_NPC_12")
	if check_pos == Vector2(3376, 240):
		Global.game.play_dialogue("MAP108_NPC_13")
	if check_pos == Vector2(4592, 176):
		Global.game.play_dialogue("MAP108_NPC_14")
	if check_pos == Vector2(4336, 304):
		Global.game.play_dialogue("MAP108_NPC_15")
	if check_pos == Vector2(1424, 144):
		Global.game.open_shop(['POTION', 'SUPERPOTION', 'HYPERPOTION', 'MAXPOTION', 'FULLRESTORE', 'ANTIDOTE', 'PARLYZHEAL', 'ICEHEAL', 'BURNHEAL', 'AWAKENING', 'FULLHEAL', 'REVIVE', 'REPEL', 'SUPERREPEL', 'MAXREPEL', 'ESCAPEROPE', 'POKEDOLL'])
	if check_pos == Vector2(1488, 144):
		Global.game.open_shop(['POKeBALL', 'GREATBALL', 'ULTRABALL', 'DIVEBALL', 'DUSKBALL', 'QUICKBALL', 'HEALBALL', 'NETBALL', 'TIMERBALL', 'LUXURYBALL', 'PREMIERBALL'])
	if check_pos == Vector2(2160, 304):
		Global.game.open_shop(['FIRESTONE', 'LEAFSTONE', 'WATERSTONE', 'THUNDERSTONE', 'HARDSTONE', 'EVERSTONE'])
	if check_pos == Vector2(2160, 272):
		Global.game.open_shop(['TM14', 'TM15', 'TM16', 'TM17', 'TM20', 'TM25', 'TM33', 'TM38', 'TM52', 'TM54', 'TM68', 'TM70', 'TM83'])
	if check_pos == Vector2(3440, 144):
		Global.game.open_shop(['XSPEED', 'XATTACK', 'XSPECIAL', 'XDEFEND', 'XSPDEF', 'XACCURACY', 'DIREHIT', 'GUARDSPEC'])
	if check_pos == Vector2(3472, 144):
		Global.game.open_shop(['CARBOS', 'PROTEIN', 'CALCIUM', 'ZINC', 'IRON', 'HPUP'])
	if check_pos == Vector2(2192, 304):
		Global.game.open_shop(['FIRESTONE', 'LEAFSTONE', 'WATERSTONE', 'THUNDERSTONE', 'HARDSTONE', 'EVERSTONE'])
	if check_pos == Vector2(4464, 144):
		Global.game.open_shop(['ETHER', 'MOONSTONE', 'SOFTSAND', 'ARCHILLESITE'])
	return null
