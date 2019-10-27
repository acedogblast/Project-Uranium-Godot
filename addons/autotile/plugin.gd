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
extends EditorPlugin

var AutoTileLayer = load("res://addons/autotile/layer.gd")
var icon = load("res://addons/autotile/icon.png")

const MODE_NONE = 0
const MODE_BRUSH = 1
const MODE_BOX = 2

var mode = MODE_BRUSH
var mode_toggle = null

var drag_button = 0
var drag_start = null

var current = null
var current_modified = false
var current_hover = null
var current_undo = {}

func _enter_tree():
	add_custom_type("AutoTileLayer", "StaticBody2D", AutoTileLayer, icon)

func _exit_tree():
	remove_custom_type("AutoTileLayer")
	if mode_toggle != null:
		mode_toggle.free()

func get_state():
	return {
		"mode": mode
	}

func set_state(state):
	mode = state["mode"]
	drag_button = 0
	_update_mode_toggle()

func _update_mode_toggle():
	if mode_toggle != null:
		if mode == MODE_NONE:
			mode_toggle.set_text(tr("Paint Mode Disabled"))
		elif mode == MODE_BRUSH:
			mode_toggle.set_text(tr("Brush Paint Mode"))
		elif mode == MODE_BOX:
			mode_toggle.set_text(tr("Box Paint Mode"))

func _on_mode_pressed():
	if mode == MODE_NONE:
		mode = MODE_BRUSH
	elif mode == MODE_BRUSH:
		mode = MODE_BOX
	elif mode == MODE_BOX:
		mode = MODE_NONE
	drag_button = 0
	_update_mode_toggle()

func _on_layer_edit_start():
	if current_modified:
		return
	current_modified = true
	current_undo = {}
	for pos in current.data:
		current_undo[pos] = 0

func _on_layer_edit_finish():
	current_modified = false
	var current_do = {}
	for pos in current.data:
		current_do[pos] = 0
	var undoredo = get_undo_redo()
	undoredo.create_action("AutoTileLayer Edited")
	undoredo.add_undo_method(current, "_set_data", current_undo)
	undoredo.add_do_method(current, "_set_data", current_do)
	undoredo.commit_action()

func handles(object):
	if object extends AutoTileLayer:
		return true

func forward_canvas_input_event(canvas_xform, event):
	if current == null:
		return
	if current extends AutoTileLayer:
		if event.type == InputEvent.KEY and event.pressed:
			if event.scancode == KEY_B:
				mode = MODE_BRUSH
				drag_button = 0
				_update_mode_toggle()
				return true
			if event.scancode == KEY_N:
				mode = MODE_BOX
				drag_button = 0
				_update_mode_toggle()
				return true
			return
		elif event.type == InputEvent.MOUSE_BUTTON:
			pass
		elif event.type == InputEvent.MOUSE_MOTION:
			pass
		else:
			return
		var pos = canvas_xform.affine_inverse().xform(Vector2(event.x, event.y))
		pos = current.get_global_transform().affine_inverse().xform(pos)
		pos = pos / current.tile_size
		pos = Vector2(floor(pos.x), floor(pos.y))
		if current_hover == null or current_hover != pos:
			current_hover = pos
			update_canvas()
		if mode == MODE_BRUSH:
			if event.type == InputEvent.MOUSE_BUTTON:
				if event.pressed:
					if event.button_index == 1 or event.button_index == 2:
						if drag_button == 0:
							drag_button = event.button_index
					else:
						return
				elif event.button_index == drag_button:
					drag_button = 0
				else:
					return
			if drag_button == 1:
				if not current.has_tile(pos):
					_on_layer_edit_start()
					current.add_tile(pos)
					current.update()
			elif drag_button == 2:
				if current.has_tile(pos):
					_on_layer_edit_start()
					current.remove_tile(pos)
					current.update()
			elif current_modified:
				_on_layer_edit_finish()
			return drag_button
		elif mode == MODE_BOX:
			if event.type == InputEvent.MOUSE_BUTTON:
				if event.pressed:
					if event.button_index == 1 or event.button_index == 2:
						if drag_button == 0:
							drag_button = event.button_index
							drag_start = pos
							return true
				elif event.button_index == drag_button:
					var min_x = min(pos.x, drag_start.x)
					var max_x = max(pos.x, drag_start.x) + 1
					var min_y = min(pos.y, drag_start.y)
					var max_y = max(pos.y, drag_start.y) + 1
					_on_layer_edit_start()
					for x in range(min_x, max_x):
						for y in range(min_y, max_y):
							if drag_button == 1:
								current.add_tile(Vector2(x, y))
							elif drag_button == 2:
								current.remove_tile(Vector2(x, y))
					current.update()
					_on_layer_edit_finish()
					drag_button = 0
					update_canvas()
					return true
			elif event.type == InputEvent.MOUSE_MOTION and drag_button:
				return true

func forward_draw_over_canvas(canvas_xform, canvas):
	if current == null:
		return
	if current extends AutoTileLayer:
		if current_hover == null or mode == MODE_NONE:
			return
		var control_xform = current.get_global_transform()
		var pos = control_xform.xform(current_hover * current.tile_size)
		pos = canvas_xform.xform(pos)
		var size = control_xform.basis_xform(Vector2(1, 1) * current.tile_size)
		size = canvas_xform.basis_xform(size)
		canvas.draw_rect(Rect2(pos, size), Color(1, 1, 1, 0.5))
		if mode == MODE_BOX and drag_button != 0:
			var min_x = min(current_hover.x, drag_start.x)
			var max_x = max(current_hover.x, drag_start.x) + 1
			var min_y = min(current_hover.y, drag_start.y)
			var max_y = max(current_hover.y, drag_start.y) + 1
			pos = Vector2(min_x, min_y) * current.tile_size
			pos = control_xform.xform(pos)
			pos = canvas_xform.xform(pos)
			size = Vector2(max_x - min_x, max_y - min_y) * current.tile_size
			size = control_xform.basis_xform(size)
			size = canvas_xform.basis_xform(size)
			canvas.draw_rect(Rect2(pos, size), Color(1, 1, 1, 0.5))

func edit(object):
	if current != object:
		if current != null:
			_gd_21_disconnect()
		current = object
		current_hover = null
		current_modified = false
		drag_button = 0
		_gd_21_connect()
	if mode_toggle == null:
		mode_toggle = ToolButton.new()
		mode_toggle.connect("pressed", self, "_on_mode_pressed")
		_update_mode_toggle()
		add_control_to_container(CONTAINER_CANVAS_EDITOR_MENU, mode_toggle)

func make_visible(visible):
	if visible == false:
		if current != null:
			_gd_21_disconnect()
			current = null
		if mode_toggle != null:
			mode_toggle.free()
			mode_toggle = null

# Backwards compatability. Remove when Godot 3.0 is released.
var old_methods = OS.get_engine_version()["major"] == "2" and OS.get_engine_version()["minor"] == "1"

func forward_input_event(event):
	if current != null:
		return forward_canvas_input_event(current.get_viewport_transform(), event)

func update_canvas():
	if old_methods:
		current.update()
		return
	.update_canvas()

func _gd_21_connect():
	if old_methods:
		current._gd_21_editor = self

func _gd_21_disconnect():
	if old_methods:
		current._gd_21_editor = null

