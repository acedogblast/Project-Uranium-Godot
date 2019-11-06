extends Object
var pokemon = {
	1: "Orchynx",
	2: "Metalynx"
	
}
func get_pokemon_class(id):
	return load("res://Utilities/Battle/Database/Pokemon/" + pokemon[id] + ".gd").new()
func get_basic_pokemon(id):
	var poke= load("res://Utilities/Battle/Classes/Pokemon.gd").new()
	var data = load("res://Utilities/Battle/Database/Pokemon/" + pokemon[id] + ".gd").new()
	
	poke.name = data.name
	
	return poke