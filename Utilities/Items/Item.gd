extends Object
class_name Item

var name : String           # Name of Item
var id : int                # ID of Item
var pocket : int            # Which pocket the Item belongs to.
var description : String    # Description of Item

func _init(_name : String, _description : String, _pocket ):
	name = _name
	pocket = _pocket
	description = _description
