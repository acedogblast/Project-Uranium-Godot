extends Node2D

#onready var next_scene1 = preload("res://Maps/MokiTown/MokiTown.tscn")
#var offset = Vector2(2272,26*32)

var type = "Outdoor"
var place_name = "Route 03"
var grass_pos = []

func _ready():
#	$Layer2/Wild_Grass/GrassCheck.connect("area_entered", get_tree().get_root().get_child(4), "enter_grass")
#	$Layer2/Wild_Grass/GrassCheck.connect("area_exited", get_tree().get_root().get_child(4), "exit_grass")
	print()
	
	var grass_cells = $"Tile Layer 1/Grass".get_used_cells() # Get Array of Vector2s of cells in cell cord
	var final_pos = [] # Array of Vector2s of grass global locations

	for cells in grass_cells:
		var pos = cells
		pos = pos * 32
		pos = pos + self.position
		pos = pos + Vector2(16,16)
		final_pos.append(pos)
	#print(final_pos)
	Global.grass_positions = final_pos

func get_areas():
	return $Layer2/Wild_Grass/GrassCheck.get_overlapping_areas()
