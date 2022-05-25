extends Object
class_name AutoZSorter
# New Z-Layering guidelines:
#
# Layers 0-9 are for backgrounds (floors, ground, doors, etc.)
# Layers 10-29 are for Player and NPCs and is what the AutoZSorter will manage.
# Layers >=30 are for foregrounds and will always be above Player and NPCs (Trees, etc.)

static func sort_ascending(a, b):
    if a.get_global_transform_with_canvas().get_origin().y < b.get_global_transform_with_canvas().get_origin().y:
        return true
    return false