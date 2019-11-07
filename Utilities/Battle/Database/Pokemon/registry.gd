extends Object
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
func get_basic_pokemon(id): # Returns a level 1 version of the pokemon by its ID and sets. It's IV values
	var poke= load("res://Utilities/Battle/Classes/Pokemon.gd").new()
	var data = get_pokemon_class(id)
	poke.name = data.name
	
	poke.generate_IV()
	return poke