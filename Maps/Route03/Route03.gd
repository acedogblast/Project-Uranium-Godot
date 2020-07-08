extends Node2D

#onready var next_scene1 = preload("res://Maps/MokiTown/MokiTown.tscn")
#var offset = Vector2(2272,26*32)

var type = "Outdoor"
var place_name = "Route 03"
var grass_pos = []

func _ready():
	var grass_cells = $Layer2/Wild_Grass.get_used_cells_by_id(0) # Get Array of Vector2s of cells in cell cord
	var final_pos = [] # Array of Vector2s of grass global locations

	for cells in grass_cells:
		var pos = cells
		pos = pos * 32
		pos = pos + self.position
		pos = pos + Vector2(16,16)
		final_pos.append(pos)
	#print(final_pos)
	Global.grass_positions = final_pos
	

