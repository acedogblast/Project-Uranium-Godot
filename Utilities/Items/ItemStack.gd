extends Object
class_name ItemStack

var item : Item
var quantity : int
var pocket : int

func _init(item_id : int,amount : int):
	item = load("res://Utilities/Items/database.gd").new().get_item_by_id(item_id)
	item.id = item_id
	quantity = amount
	pocket = item.pocket


func get_name() -> String: # Returns the name of the Item
	return item.name

func get_description() -> String: # Returns the description of the Item
	return item.description

func get_item_icon() -> Texture2D: # Returns the Texture2D of the Item's icon
	var texture = Texture2D.new()
	texture = load("res://Graphics/Icons/item" + str(item.id) + ".png")
	return texture

func get_item_id() -> int: # Returns the ID of the Item
	return item.id

func get_item_quantity() -> int:
	return quantity

static func sort_ascending(a, b): # For sorting ItemStack objects in an array
	if a.get_item_id() < b.get_item_id():
		return true
	return false


func is_ball():
	if item.id >= 208 && item.id <= 232:
		return true
	return false

func is_potion():
	if item.id >= 170 && item.id <= 181:
		return true
	return false