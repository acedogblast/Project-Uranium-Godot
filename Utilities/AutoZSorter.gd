extends Object
class_name AutoZSorter

static func sort_ascending(a, b):
    if a.position.y < b.position.y:
        return true
    return false