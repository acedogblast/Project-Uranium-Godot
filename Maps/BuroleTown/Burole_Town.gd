extends Node2D # gen_map.py Map060

var map_name = "Burole Town"

func interaction(check_pos : Vector2, _direction):
	if check_pos == Vector2(1200, 272):
		Global.game.play_dialogue("MAP060_SIGN_1")
	if check_pos == Vector2(432, 1328):
		Global.game.play_dialogue("MAP060_SIGN_2")
	if check_pos == Vector2(1264, 688):
		Global.game.play_dialogue("MAP060_SIGN_3")
	if check_pos == Vector2(496, 1328):
		Global.game.play_dialogue("MAP060_SIGN_4")
	if check_pos == Vector2(2032, 1072):
		Global.game.play_dialogue("MAP060_NPC_1")
	if check_pos == Vector2(1520, 1360):
		Global.game.play_dialogue("MAP060_NPC_2")
	if check_pos == Vector2(592, 1392):
		Global.game.play_dialogue("MAP060_NPC_3")
	if check_pos == Vector2(1072, 1328):
		Global.game.play_dialogue("MAP060_NPC_4")
	if check_pos == Vector2(1904, 1104):
		Global.game.play_dialogue("MAP060_NPC_5")
	if check_pos == Vector2(1424, 1104):
		Global.game.play_dialogue("MAP060_NPC_6")
	if check_pos == Vector2(1904, 688):
		Global.game.play_dialogue("MAP060_NPC_7")
	if check_pos == Vector2(656, 1680):
		Global.game.play_dialogue("MAP060_NPC_8")
	if check_pos == Vector2(720, 1040):
		Global.game.play_dialogue("MAP060_NPC_9")
	if check_pos == Vector2(1872, 688):
		Global.game.play_dialogue("MAP060_NPC_10")
	if check_pos == Vector2(1776, 1040):
		Global.game.play_dialogue("MAP060_NPC_11")
	if check_pos == Vector2(1072, 720):
		Global.game.play_dialogue("MAP060_NPC_12")
	if check_pos == Vector2(1648, 752):
		Global.game.play_dialogue("MAP060_NPC_13")
	if check_pos == Vector2(1744, 1200):
		Global.game.open_shop(['ENERGYPOWDER', 'ENERGYROOT', 'HEALPOWDER', 'AROMATICHERB', 'SACHET', 'DESTINYKNOT'])
	if check_pos == Vector2(2000, 1200):
		Global.game.open_shop(['DUSKBALL', 'HEALBALL', 'LEVELBALL', 'LUREBALL', 'REPEATBALL', 'NETBALL', 'NESTBALL'])
	if check_pos == Vector2(1872, 1296):
		Global.game.open_shop(['ORANBERRY', 'SITRUSBERRY', 'PECHABERRY', 'XACCURACY'])
	return null
