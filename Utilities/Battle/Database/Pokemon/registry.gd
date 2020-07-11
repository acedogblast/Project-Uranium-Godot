extends Object
class_name registry
var pokemon = {
	1: "Orchynx",
	2: "Metalynx",
	3: "Raptorch",
	4: "Archilles",
	5: "Eletux",
	6: "Electruxo"
	
}
func get_pokemon_class(id):
	return load("res://Utilities/Battle/Database/Pokemon/" + pokemon[id] + ".gd").new()
