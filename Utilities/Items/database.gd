extends Object
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
	var item = item_list.get(id)
	item.id = id
	return item

func get_id_by_name(_name: String):
	var id = 0
	for key in item_list.keys():
		if item_list.get(key).name == _name:
			id = key
			return id
	return id

func get_item_by_name(_name: String):
	var id = get_id_by_name(_name)
	var item = get_item_by_id(id)
	item.id = id
	return item
