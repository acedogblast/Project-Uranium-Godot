extends Node2D

var ITEMS

enum OPTIONS{
	ITEMS,
	MEDICINE,
	BALLS,
	TMs,
	BERRIES,
	BATTLE_ITEMS,
	KEY_ITEMS,
}

var current = OPTIONS.MEDICINE
var selected_item = [
	0, # items
	0, # medicine
	0, # balls
	0, # tms
	0, # berries
	0, # battle item
	0 # key items
]

#onready var inventory = Global.inventory

var enabled
signal close_bag

func _ready():
	#Testing
	pass

func setup():
	update_data()
	update_detail()
	#print(str(Global.inventory.get_instance_id()) + "Bag.gd")

func _process(delta):
	if enabled:
		if Input.is_action_just_pressed("ui_right"):
			if current < OPTIONS.KEY_ITEMS:
				current += 1
			else:
				current = OPTIONS.ITEMS
			change_selected()
			update_detail()
			update_data()
			animate()
		elif Input.is_action_just_pressed("ui_left"):
			if current > OPTIONS.ITEMS:
				current -= 1
			else:
				current = OPTIONS.KEY_ITEMS
			change_selected()
			update_detail()
			update_data()
			animate()
		elif Input.is_action_just_pressed("ui_down"):
			#print("Down1")
			if selected_item[current] + 1 <= $items.get_child(current + 1).get_child_count() - 1:
				#print("Down2")
				selected_item[current] += 1
				change_item_selected("down")
				update_detail()
				print(selected_item[current])
				pass
			pass
		elif Input.is_action_just_pressed("ui_up"):
			if selected_item[current] - 1 >= 0:
				selected_item[current] -= 1
				change_item_selected("up")
				update_detail()
				print(selected_item[current])
				pass
			pass
		elif Input.is_action_just_pressed("x"):
			enabled = false
			emit_signal("close_bag")
		elif Input.is_action_just_pressed("ui_accept"):
			#print(get_item_index())
			pass


func change_item_selected(dir):
	for c in $items.get_child(current + 1).get_children():
		c.get_child(0).frame = 0
	$items.get_child(current + 1).get_child(selected_item[current]).get_child(0).frame = 1
	pass


func change_selected():
	match current:
		OPTIONS.ITEMS:
			$CurrentContainer.bbcode_text = "[center]Items"
			
			hide_all()
			$items/items.show()
			
			if $items/items.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/items.get_children():
					c.show()
		OPTIONS.MEDICINE:
			$CurrentContainer.bbcode_text = "[center]Medicine"
			
			hide_all()
			$items/medicine.show()
			if $items/medicine.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/medicine.get_children():
					c.show()
		OPTIONS.BALLS:
			$CurrentContainer.bbcode_text = "[center]Poké Balls"
			
			hide_all()
			$items/balls.show()
			if $items/balls.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/balls.get_children():
					c.show()
		OPTIONS.TMs:
			$CurrentContainer.bbcode_text = "[center]TMs & HMs"
			
			hide_all()
			$items/tms.show()
			
			if $items/tms.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/tms.get_children():
					c.show()
		OPTIONS.BERRIES:
			$CurrentContainer.bbcode_text = "[center]Berries"
			
			hide_all()
			$items/berries.show()
			if $items/berries.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/berries.get_children():
					c.show()
		OPTIONS.BATTLE_ITEMS:
			$CurrentContainer.bbcode_text = "[center]Battle Items"
			
			hide_all()
			$items/battle_items.show()
			if $items/battle_items.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/battle_items.get_children():
					c.show()
		OPTIONS.KEY_ITEMS:
			$CurrentContainer.bbcode_text = "[center]Key Items"
			
			hide_all()
			$items/key_items.show()
			if $items/key_items.get_children().size() == 0:
				$empty_text.show()
				pass
			else:
				for c in $items/key_items.get_children():
					c.show()


func animate():
	reset_frames()
	
	match current:
		OPTIONS.ITEMS:
			$containers/ITEMS.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/ITEMS.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/ITEMS.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.MEDICINE:
			$containers/MEDICINE.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/MEDICINE.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/MEDICINE.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.BALLS:
			$containers/BALLS.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BALLS.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BALLS.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.TMs:
			$containers/TMs.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/TMs.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/TMs.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.BERRIES:
			$containers/BERRIES.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BERRIES.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BERRIES.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.BATTLE_ITEMS:
			$containers/BATTLE_ITEMS.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BATTLE_ITEMS.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/BATTLE_ITEMS.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return
		OPTIONS.KEY_ITEMS:
			$containers/KEY_ITEMS.frame = 0
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/KEY_ITEMS.frame = 1
			yield(get_tree().create_timer(0.1), "timeout")
			$containers/KEY_ITEMS.frame = 2
			yield(get_tree().create_timer(0.1), "timeout")
			return

func reset_frames():
	for c in $containers.get_children():
		c.frame = 0
	pass

func update_data():
	$empty_text.hide()
	match current:
		OPTIONS.ITEMS:
			# setup items
			for c in $items/items.get_children():
				$items/items.remove_child(c)
			if !Global.inventory.items.empty():
				var temp_current = 0
				for i in Global.inventory.items:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/items.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.MEDICINE:
			# setup medicine
			for c in $items/medicine.get_children():
				$items/medicine.remove_child(c)
			if !Global.inventory.medicine.empty():
				var temp_current = 0
				for i in Global.inventory.medicine:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/medicine.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.BALLS:
			# setup balls
			for c in $items/balls.get_children():
				$items/balls.remove_child(c)
			if !Global.inventory.balls.empty():
				var temp_current = 0
				for i in Global.inventory.balls:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/balls.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.TMs:
			# setup tms
			for c in $items/tms.get_children():
				$items/tms.remove_child(c)
			if Global.inventory.TMs.empty():
				var temp_current = 0
				for i in Global.inventory.TMs:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/tms.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.BERRIES:
			# setup berries
			for c in $items/berries.get_children():
				$items/berries.remove_child(c)
			if Global.inventory.berries.empty():
				var temp_current = 0
				for i in Global.inventory.berries:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/berries.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.BATTLE_ITEMS:
			# setup battle_items
			for c in $items/battle_items.get_children():
				$items/battle_items.remove_child(c)
			if Global.inventory.battle_items.empty():
				var temp_current = 0
				for i in Global.inventory.battle_items:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/battle_items.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
		OPTIONS.KEY_ITEMS:
			# setup key_items
			for c in $items/key_items.get_children():
				$items/key_items.remove_child(c)
			if Global.inventory.key_items.empty():
				var temp_current = 0
				for i in Global.inventory.key_items:
					var base = $items/base_item_panel.duplicate()
					base.get_child(1).bbcode_text = i.get_name()
					base.position.y += temp_current * 48
					if temp_current == 0:
						base.get_child(0).frame = 1
					else:
						base.get_child(0).frame = 0
					base.show()
					$items/key_items.add_child(base)
					temp_current += 1
			else:
				$empty_text.show()
	

func update_detail():
	var item_icon
	var section_empty = true
	match current:
		OPTIONS.ITEMS:
			if !Global.inventory.items.empty():
				item_icon = Global.inventory.items[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.MEDICINE:
			if !Global.inventory.medicine.empty():
				item_icon = Global.inventory.medicine[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.BALLS:
			if !Global.inventory.balls.empty():
				item_icon = Global.inventory.balls[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.TMs:
			if !Global.inventory.TMs.empty():
				item_icon = Global.inventory.TMs[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.BERRIES:
			if !Global.inventory.berries.empty():
				item_icon = Global.inventory.berries[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.BATTLE_ITEMS:
			if !Global.inventory.battle_items.empty():
				item_icon = Global.inventory.battle_items[selected_item[current]].get_item_id()
				section_empty = false
		OPTIONS.KEY_ITEMS:
			if !Global.inventory.key_items.empty():
				item_icon = Global.inventory.key_items[selected_item[current]].get_item_id()
				section_empty = false
	
	if Global.inventory == null || Global.inventory.is_empty() || section_empty:
		$Details/icon.hide()
		$Details/text.hide()
		$Details/name.hide()
		$Details/quantity.hide()
		return
	$Details/icon.show()
	$Details/text.show()
	$Details/name.show()
	$Details/quantity.show()
	match current:
		OPTIONS.ITEMS:
			$Details/icon.texture = null
			$Details/name.text = ""
			$Details/quantity.text = ""
			$Details/text.text = ""
			pass
		OPTIONS.MEDICINE:
			$Details/icon.texture = load("res://Graphics/Icons/item" + str(item_icon) + ".png")
			$Details/name.text = Global.inventory.medicine[selected_item[current]].get_name()
			$Details/quantity.text = str("x ", Global.inventory.medicine[selected_item[current]].get_item_quantity())
			$Details/text.text = Global.inventory.medicine[selected_item[current]].get_description()
			
		OPTIONS.BALLS:
			$Details/icon.texture = load("res://Graphics/Icons/item" + str(item_icon) + ".png")
			$Details/name.text = Global.inventory.balls[selected_item[current]].get_name()
			$Details/quantity.text = str("x ", Global.inventory.balls[selected_item[current]].get_item_quantity())
			$Details/text.text = Global.inventory.balls[selected_item[current]].get_description()
			
			pass
		OPTIONS.TMs:
			$Details/icon.texture = null
			$Details/name.text = ""
			$Details/quantity.text = ""
			$Details/text.text = ""
			pass
		OPTIONS.BERRIES:
			$Details/icon.texture = null
			$Details/name.text = ""
			$Details/quantity.text = ""
			$Details/text.text = ""
			pass
		OPTIONS.BATTLE_ITEMS:
			$Details/icon.texture = null
			$Details/name.text = ""
			$Details/quantity.text = ""
			$Details/text.text = ""
			pass
		OPTIONS.KEY_ITEMS:
			$Details/icon.texture = null
			$Details/name.text = ""
			$Details/quantity.text = ""
			$Details/text.text = ""
			pass
	pass

func remove_item(id, quantity):
	match ITEMS.item_list[ITEMS.item_list.find(id) + 3]:
		"Items":
			pass
		"Medicine":
			if Global.items[1][1] - quantity >= 0:
				Global.items[1][1] -= quantity
			pass
		"Balls":
			if Global.items[2][1] - quantity >= 0:
				Global.items[2][1] -= quantity
	pass


func hide_all():
	$empty_text.hide()
	for c in $items.get_children():
		c.hide()
