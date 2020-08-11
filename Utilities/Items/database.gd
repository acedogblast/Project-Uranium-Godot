extends Object
#class_name Items_database

# item_list OLD
# id, name of the item, detail text, part inside bag
#var item_list = [
#	170, "Potion", "A spray-type medicine for wounds. It restores the HP of one Pokémon by just 20 points.", "Medicine",
#	211, "Pokéball", "A device for catching wild Pokémon. A capsule system that is thrown like a ball at the target.", "Balls",
#	210, "Great Ball", "A good, high-performance Poké Ball that provides a higher success rate for catching Pokémon than a standard Poké Ball.", "Balls",
#]

enum {
	ITEMS,
	MEDICINE,
	BALLS,
	TMS,
	BERRIES,
	BATTLE_ITEMS,
	KEY_ITEMS,
}
# item_list NEW
var item_list = {
	170: Item.new("Potion", "A spray-type medicine for wounds. It restores the HP of one Pokémon by just 20 points.", MEDICINE),
	211: Item.new("Pokéball", "A device for catching wild Pokémon. A capsule system that is thrown like a ball at the target.", BALLS),
	210: Item.new("Great Ball", "A good, high-performance Poké Ball that provides a higher success rate for catching Pokémon than a standard Poké Ball.", BALLS)
}

func get_item_by_id(id: int):
	return item_list.get(id)

func get_id_by_name(_name: String):
	var id = 0
	for entry in item_list:
		if entry.name == _name:
			id = entry.id
			return id
	return id
