class_name Inventory

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

func add_item(item: Item):# Adds a single item to the inventory
    # Check if ItemStack already exisits
    var item_stack = null
    match item.pocket:
        ITEMS:
            for item_stacks in items:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        MEDICINE:
            for item_stacks in medicine:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        BALLS:
            for item_stacks in balls:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        TMS:
            for item_stacks in TMs:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        BERRIES:
            for item_stacks in berries:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        BATTLE_ITEMS:
            for item_stacks in battle_items:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
        KEY_ITEMS:
            for item_stacks in key_items:
                if item_stacks.get_item_id == item.id
                    item_stack = item_stacks
                    break
    if item_stack != null:
        # Increment quantity
        item_stack.quantity += 1
    else:
        # Create new ItemStack
        match item.pocket:
            ITEMS:
                items.add(ItemStack.new(item.id, 1))
            MEDICINE:
                medicine.add(ItemStack.new(item.id, 1))
            BALLS:
                balls.add(ItemStack.new(item.id, 1))
            TMS:
                TMs.add(ItemStack.new(item.id, 1))
            BERRIES:
                berries.add(ItemStack.new(item.id, 1))
            BATTLE_ITEMS:
                battle_items.add(ItemStack.new(item.id, 1))
            KEY_ITEMS:
                key_items.add(ItemStack.new(item.id, 1))
        pass

func add_item_multiple(item: Item, amount : int):
    for i in range(amount):
        add_item(item)
    
func add_item_by_name(_name : String): # Adds a single item to the inventory
    add_item(get_id_by_name(_name))
func get_item_by_id(_id: int): # Adds a single item to the inventory
    add_item(get_item_by_id(_id))
func add_item_by_name_multiple(_name : String, amount : int):
    for i in range(amount):
        add_item(get_id_by_name(_name))