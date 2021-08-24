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

var item_list = { # Can not pull data from Item or ItemStack from saves due to _init problems.
	170: Item.new("Potion", "A spray-type medicine for wounds. It restores the HP of one Pokémon by just 20 points.", MEDICINE),
	171: Item.new("Super Potion", "A spray-type medicine for wounds. It restores the HP of one Pokémon by just 50 points.", MEDICINE),
	172: Item.new("Hyper Potion", "A spray-type medicine for wounds. It restores the HP of one Pokémon by just 200 points.", MEDICINE),
	173: Item.new("Max Potion", "A spray-type medicine for wounds. It completely restores the HP of a single Pokémon.", MEDICINE),
	174: Item.new("Max Potion", "A medicine that fully restores the HP and heals any status problems of a single Pokémon.", MEDICINE),
	176: Item.new("Antidote", "A spray-type medicine. It lifts the effect of poison from one Pokémon.", MEDICINE),
	187: Item.new("Fresh Water", "Water with a high mineral content. It restores the HP of one Pokémon by 50 points.", MEDICINE),
	211: Item.new("Pokéball", "A device for catching wild Pokémon. A capsule system that is thrown like a ball at the target.", BALLS),
	210: Item.new("Great Ball", "A good, high-performance Poké Ball that provides a higher success rate for catching Pokémon than a standard Poké Ball.", BALLS),
	579: Item.new("Maria's Key", "A key given by a creepy guy that unlocks Gym Leader Maria's house.", KEY_ITEMS)
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

func get_description_by_name(_name : String):
	var item = get_item_by_name(_name)
	return item.description
