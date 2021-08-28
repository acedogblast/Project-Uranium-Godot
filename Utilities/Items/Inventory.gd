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

var items = []
var medicine = []
var balls = []
var TMs = []
var berries = []
var battle_items = []
var key_items = []

var database = null

func add_item(item: Item):# Adds a single item to the inventory
	if item == null:
		print("Inventory Error: item is null")
	else:
		# Check if ItemStack already exisits
		var item_stack = null
		match item.pocket:
			ITEMS:
				for item_stacks in items:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			MEDICINE:
				for item_stacks in medicine:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			BALLS:
				for item_stacks in balls:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			TMS:
				for item_stacks in TMs:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			BERRIES:
				for item_stacks in berries:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			BATTLE_ITEMS:
				for item_stacks in battle_items:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
			KEY_ITEMS:
				for item_stacks in key_items:
					if item_stacks.get_item_id() == item.id:
						item_stack = item_stacks
						break
		if item_stack != null:
			# Increment quantity
			item_stack.quantity += 1
		else:
			# Create new ItemStack
			match item.pocket:
				ITEMS:
					items.append(ItemStack.new(item.id, 1))
				MEDICINE:
					medicine.append(ItemStack.new(item.id, 1))
				BALLS:
					balls.append(ItemStack.new(item.id, 1))
				TMS:
					TMs.append(ItemStack.new(item.id, 1))
				BERRIES:
					berries.append(ItemStack.new(item.id, 1))
				BATTLE_ITEMS:
					battle_items.append(ItemStack.new(item.id, 1))
				KEY_ITEMS:
					key_items.append(ItemStack.new(item.id, 1))

func add_item_multiple(item: Item, amount : int):
	for i in range(amount):
		add_item(item)

func add_item_by_name(_name : String): # Adds a single item to the inventory
	add_item(get_item_by_name(_name))

func get_item_by_id(_id: int):
	if database == null:
		database = load("res://Utilities/Items/database.gd").new()
	return database.get_item_by_id(_id)

func add_item_by_name_multiple(_name : String, amount : int):
	for i in range(amount):
		add_item(get_item_by_name(_name))

func add_item_by_id_multiple(_id : int, amount : int):
	for i in range(amount):
		add_item(get_item_by_id(_id))	

func get_item_id_by_name(_name : String):
	if database == null:
		database = load("res://Utilities/Items/database.gd").new()
	return database.get_id_by_name(_name)

func get_item_by_name(_name : String):
	if database == null:
		database = load("res://Utilities/Items/database.gd").new()
	return database.get_item_by_name(_name)

func remove_item(item: Item):
	# Check if ItemStack already exisits
	var item_stack = null
	match item.pocket:
		ITEMS:
			for item_stacks in items:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		MEDICINE:
			for item_stacks in medicine:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		BALLS:
			for item_stacks in balls:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		TMS:
			for item_stacks in TMs:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		BERRIES:
			for item_stacks in berries:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		BATTLE_ITEMS:
			for item_stacks in battle_items:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
		KEY_ITEMS:
			for item_stacks in key_items:
				if item_stacks.get_item_id() == item.id:
					item_stack = item_stacks
					break
	if item_stack == null:
		print("Inventory Error. Can not remove non-existant item in inventory.")
		return
	else:
		if item_stack.quantity == 1:
			# Remove item stack
			match item.pocket:
				ITEMS:
					var index = 0
					for item_stacks in items:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					items.remove(index)
				MEDICINE:
					var index = 0
					for item_stacks in medicine:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					medicine.remove(index)
				BALLS:
					var index = 0
					for item_stacks in balls:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					balls.remove(index)
				TMS:
					var index = 0
					for item_stacks in TMs:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					TMs.remove(index)
				BERRIES:
					var index = 0
					for item_stacks in berries:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					berries.remove(index)
				BATTLE_ITEMS:
					var index = 0
					for item_stacks in battle_items:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					battle_items.remove(index)
				KEY_ITEMS:
					var index = 0
					for item_stacks in key_items:
						if item_stacks.get_item_id() == item.id:
							break
						index += 1
					key_items.remove(index)
		else:
			item_stack.quantity -= 1

func is_empty() -> bool:
	if (
		items.size() == 0 &&
		medicine.size() == 0 &&
		balls.size() == 0 &&
		TMs.size() == 0 &&
		berries.size() == 0 && 
		battle_items.size() == 0 &&
		key_items.size() == 0
		):
		return true
	return false

func get_save_state():
	var inventory_save_state = []

	for x in items:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in medicine:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in balls:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in TMs:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in berries:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in battle_items:
		inventory_save_state.append([x.item.id, x.quantity])
	for x in key_items:
		inventory_save_state.append([x.item.id, x.quantity])
	return inventory_save_state
func set_save_state(inventory_save_state):
	for x in inventory_save_state:
		add_item_by_id_multiple(x[0], x[1])

func get_pocket_name(item : Item) -> String:
	var pocket_name
	match item.pocket:
		ITEMS:
			pocket_name = tr("POCKET_NAME_ITEMS")
		MEDICINE:
			pocket_name = tr("POCKET_NAME_MEDICINE")
		BALLS:
			pocket_name = tr("POCKET_NAME_BALLS")
		TMS:
			pocket_name = tr("POCKET_NAME_TMS")
		BERRIES:
			pocket_name = tr("POCKET_NAME_BERRIES")
		BATTLE_ITEMS:
			pocket_name = tr("POCKET_NAME_BATTLE_ITEMS")
		KEY_ITEMS:
			pocket_name = tr("POCKET_NAME_KEY_ITEMS")

	return pocket_name

func has_item_id(id: int):
	var temp = get_item_by_id(id)
	match temp.pocket:
		ITEMS:
			for item_stacks in items:
				if item_stacks.get_item_id() == temp.id:
					return true
		MEDICINE:
			for item_stacks in medicine:
				if item_stacks.get_item_id() == temp.id:
					return true
		BALLS:
			for item_stacks in balls:
				if item_stacks.get_item_id() == temp.id:
					return true
		TMS:
			for item_stacks in TMs:
				if item_stacks.get_item_id() == temp.id:
					return true
		BERRIES:
			for item_stacks in berries:
				if item_stacks.get_item_id() == temp.id:
					return true
		BATTLE_ITEMS:
			for item_stacks in battle_items:
				if item_stacks.get_item_id() == temp.id:
					return true
		KEY_ITEMS:
			for item_stacks in key_items:
				if item_stacks.get_item_id() == temp.id:
					return true
	return false
