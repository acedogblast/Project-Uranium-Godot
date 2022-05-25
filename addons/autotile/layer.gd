# Godot AutoTileLayer v1.1
# https://github.com/leezh/autotile
#
# Copyright (c) 2016, Zher Huei Lee
# All rights reserved.
#
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
#  1. The origin of this software must not be misrepresented; you must not
#     claim that you wrote the original software. If you use this software
#     in a product, an acknowledgment in the product documentation would
#     be appreciated but is not required.
#
#  2. Altered source versions must be plainly marked as such, and must not
#     be misrepresented as being the original software.
#
#  3. This notice may not be removed or altered from any source
#     distribution.

tool
extends StaticBody2D

const MASK_TL = 1
const MASK_TOP = 2
const MASK_TR = 4
const MASK_LEFT = 8
const MASK_RIGHT = 16
const MASK_BL = 32
const MASK_BOTTOM = 64
const MASK_BR = 128
const MASK_ALL = 255

const SOLID_NONE = 0
const SOLID_ALL = 1
const SOLID_EXCEPT_TOP = 2

export(Texture) var texture setget _set_texture
export(int, 2, 128) var tile_size = 32 setget _set_tile_size
export(bool) var draw_center = true setget _set_draw_center
export(Vector2) var region_offset = Vector2(0, 0) setget _set_region_offset
export(bool) var solid = false setget _set_solid
export(Vector2) var solid_offset = Vector2(0, 0) setget _set_solid_offset
onready var is_ready = true
var data = {} setget _set_data
var data_cache = []
var data_modified = true
var min_pos = Vector2(0, 0)
var max_pos = Vector2(0, 0)

# Backwards compatability. Remove when Godot 3.0 is released.
var _gd_21_editor

func _ready():
	_regen_data()

func _get_property_list():
	return [{
		"hint": PROPERTY_HINT_NONE,
		"usage": PROPERTY_USAGE_STORAGE,
		"name": "autotile/data",
		"type": TYPE_INT_ARRAY
	}]

func _get(property):
	if property == "autotile/data":
		if data_modified:
			_regen_data()
		return data_cache

func _set(property, value):
	if property == "autotile/data":
		data.clear()
		var i = 0
		while i + 1 < value.size():
			data[Vector2(value[i], value[i + 1])] = 0
			i += 2
		if is_ready:
			_regen_data()
		return true

func _set_texture(value):
	texture = value
	update()

func _set_tile_size(value):
	tile_size = value
	data_modified = true
	update()

func _set_region_offset(value):
	region_offset = value
	update()

func _set_solid(value):
	solid = value
	data_modified = true
	update()

func _set_solid_offset(value):
	solid_offset = value
	data_modified = true
	update()

func _set_draw_center(value):
	draw_center = value
	update()

func _set_data(value):
	data = value
	data_modified = true
	update()

func _regen_data():
	var shape
	if solid:
		shape = RectangleShape2D.new()
		shape.set_extents(Vector2(0.5, 0.5) * tile_size)
	clear_shapes()
	data_cache.clear()
	min_pos = Vector2(0, 0)
	max_pos = Vector2(0, 0)
	for pos in data.keys():
		min_pos.x = min(min_pos.x, pos.x)
		min_pos.y = min(min_pos.x, pos.y)
		max_pos.x = max(max_pos.x, pos.x)
		max_pos.y = max(max_pos.x, pos.y)
		data_cache.append(int(pos.x))
		data_cache.append(int(pos.y))
		var mask = 0
		if data.has(pos + Vector2(-1, -1)):
			mask = mask | MASK_TL
		if data.has(pos + Vector2( 0, -1)):
			mask = mask | MASK_TOP
		if data.has(pos + Vector2( 1, -1)):
			mask = mask | MASK_TR
		if data.has(pos + Vector2(-1,  0)):
			mask = mask | MASK_LEFT
		if data.has(pos + Vector2( 1,  0)):
			mask = mask | MASK_RIGHT
		if data.has(pos + Vector2(-1,  1)):
			mask = mask | MASK_BL
		if data.has(pos + Vector2( 0,  1)):
			mask = mask | MASK_BOTTOM
		if data.has(pos + Vector2( 1,  1)):
			mask = mask | MASK_BR
		data[pos] = mask
		if solid and is_inside_tree() and not get_tree().is_editor_hint():
			var ofs = (pos + Vector2(0.5, 0.5)) * tile_size + solid_offset
			add_shape(shape, Matrix32(0, ofs))
	data_modified = false
	update()

const CORNERS = [
	{
		"offset": Vector2(0, 0),
		"tests": [
			[
				MASK_LEFT | MASK_TOP | MASK_TL,
				MASK_LEFT | MASK_TOP,
				Vector2(1, 0)
			],
			[
				MASK_LEFT | MASK_TOP | MASK_TL,
				MASK_LEFT | MASK_TOP | MASK_TL,
				Vector2(1, 2)
			],
			[
				MASK_LEFT | MASK_TOP,
				MASK_LEFT,
				Vector2(1, 1)
			],
			[
				MASK_LEFT | MASK_TOP,
				MASK_TOP,
				Vector2(0, 2)
			],
			[
				MASK_LEFT | MASK_TOP,
				0,
				Vector2(0, 1)
			],
		],
	},
	{
		"offset": Vector2(1, 0),
			"tests": [
			[
				MASK_RIGHT | MASK_TOP | MASK_TR,
				MASK_RIGHT | MASK_TOP,
				Vector2(1, 0)
			],
			[
				MASK_RIGHT | MASK_TOP | MASK_TR,
				MASK_RIGHT | MASK_TOP | MASK_TR,
				Vector2(0, 2)
			],
			[
				MASK_RIGHT | MASK_TOP,
				MASK_RIGHT,
				Vector2(0, 1)
			],
			[
				MASK_RIGHT | MASK_TOP,
				MASK_TOP,
				Vector2(1, 2)
			],
			[
				MASK_RIGHT | MASK_TOP,
				0,
				Vector2(1, 1)
			],
		],
	},
	{
		"offset": Vector2(0, 1),
		"tests": [
			[
				MASK_LEFT | MASK_BOTTOM | MASK_BL,
				MASK_LEFT | MASK_BOTTOM,
				Vector2(1, 0)
			],
			[
				MASK_LEFT | MASK_BOTTOM | MASK_BL,
				MASK_LEFT | MASK_BOTTOM | MASK_BL,
				Vector2(1, 1)
			],
			[
				MASK_LEFT | MASK_BOTTOM,
				MASK_LEFT,
				Vector2(1, 2)
			],
			[
				MASK_LEFT | MASK_BOTTOM,
				MASK_BOTTOM,
				Vector2(0, 1)
			],
			[
				MASK_LEFT | MASK_BOTTOM,
				0,
				Vector2(0, 2)
			],
		],
	},
	{
		"offset": Vector2(1, 1),
		"tests": [
			[
				MASK_RIGHT | MASK_BOTTOM | MASK_BR,
				MASK_RIGHT | MASK_BOTTOM,
				Vector2(1, 0)
			],
			[
				MASK_RIGHT | MASK_BOTTOM | MASK_BR,
				MASK_RIGHT | MASK_BOTTOM | MASK_BR,
				Vector2(0, 1)
			],
			[
				MASK_RIGHT | MASK_BOTTOM,
				MASK_RIGHT,
				Vector2(0, 2)
			],
			[
				MASK_RIGHT | MASK_BOTTOM,
				MASK_BOTTOM,
				Vector2(1, 1)
			],
			[
				MASK_RIGHT | MASK_BOTTOM,
				0,
				Vector2(1, 2)
			],
		],
	},
]

func _draw():
	if data_modified:
		_regen_data()
	if texture != null:
		for pos in data.keys():
			var mask = data[pos]
			if not draw_center and mask == MASK_ALL:
				continue
			var size = Vector2(tile_size, tile_size) / 2
			for corner in CORNERS:
				var ofs = (pos + corner["offset"] / 2) * tile_size
				var rect = Rect2(region_offset + corner["offset"] * size, size)
				for test in corner["tests"]:
					if (mask & test[0]) == test[1]:
						rect.pos += test[2] * tile_size
						draw_texture_rect_region(texture, Rect2(ofs, size), rect)
						break
	# Backwards compatability. Remove when Godot 3.0 is released.
	if _gd_21_editor:
		_gd_21_editor.forward_draw_over_canvas(get_global_transform().inverse(), self)

func get_item_rect():
	return Rect2(min_pos * tile_size, (max_pos - min_pos) * tile_size)

func has_tile(pos):
	return data.has(pos)

func add_tile(pos):
	data[pos] = 0
	data_modified = true

func remove_tile(pos):
	data.erase(pos)
	data_modified = true

