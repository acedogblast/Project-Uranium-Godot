extends Node

enum TERRAIN_TAGS {
	GRASS,
	STAIRS
}

func get_tile_terrain_tag(location: Vector2):
	# get tile id at given position
	var tile_id = Global.game.get_tile_id(location)
	
	# call function based on id
	
	match tile_id:
		0:
			Global.onGrass = true
			print("walking on tall grass")
			pass
		1:
			Global.onStairsUp = true
			print("walking on stair left up")
			pass
		2:
			Global.onStairsDown = true
			print("walking on stair right up")
			pass
		-1:
			Global.onGrass = false
			Global.onStairsUp = false
			Global.onStairsDown = false
			pass
