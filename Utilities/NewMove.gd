extends Node2D

var mode = 0
var selection = 1 # 0 is cancel
var poke
var new_move

signal close

func setup(pokemon : Pokemon, new : Move):
	poke = pokemon
	new_move = new
	$Move1/Name.text = poke.move_1.name
	$Move1/PP2.text = str(poke.move_1.remaining_pp) + "/" + str(poke.move_1.total_pp)
	$Move1/Type.frame = poke.move_1.type

	$Move2/Name.text = poke.move_2.name
	$Move2/PP2.text = str(poke.move_2.remaining_pp) + "/" + str(poke.move_2.total_pp)
	$Move2/Type.frame = poke.move_2.type

	$Move3/Name.text = poke.move_3.name
	$Move3/PP2.text = str(poke.move_3.remaining_pp) + "/" + str(poke.move_3.total_pp)
	$Move3/Type.frame = poke.move_3.type

	$Move4/Name.text = poke.move_4.name
	$Move4/PP2.text = str(poke.move_4.remaining_pp) + "/" + str(poke.move_4.total_pp)
	$Move4/Type.frame = poke.move_4.type

	$NewMove/Name.text = new.name
	$NewMove/PP2.text = str(new.total_pp) + "/" + str(new.total_pp)
	$NewMove/Type.frame = new.type

	$Poke.texture = poke.get_icon_texture()
	update()

func _input(event):
	
	if mode == 1:
		
		if event.is_action_pressed("ui_down") && selection != 5:
			selection += 1
			update()
		if event.is_action_pressed("ui_up") && selection != 1:
			selection -= 1
			update()

		if event.is_action_pressed("x"):
			selection = 0
			mode = 0
			emit_signal("close")

		if event.is_action_pressed("ui_accept") && selection != 5:
			mode = 0
			emit_signal("close")

func update():
	$Move1.frame = 0
	$Move2.frame = 0
	$Move3.frame = 0
	$Move4.frame = 0
	$NewMove.frame = 0

	match selection:
		1:
			$Move1.frame = 1
			var move = poke.move_1
			$Type.frame = move.type
			$Category/Value.frame = move.style
			$Power/Value.text = str(move.base_power)
			$Accuracy/Value.text = str(move.accuracy)

			if "description" in move && move.description != null:
				$Description.text = move.description
			else:
				$Description.text = "TO BE ADDED"

		2:
			$Move2.frame = 1
			var move = poke.move_2
			$Type.frame = move.type
			$Category/Value.frame = move.style
			$Power/Value.text = str(move.base_power)
			$Accuracy/Value.text = str(move.accuracy)

			if "description" in move && move.description != null:
				$Description.text = move.description
			else:
				$Description.text = "TO BE ADDED"
		3:
			$Move3.frame = 1
			var move = poke.move_3
			$Type.frame = move.type
			$Category/Value.frame = move.style
			$Power/Value.text = str(move.base_power)
			$Accuracy/Value.text = str(move.accuracy)

			if "description" in move && move.description != null:
				$Description.text = move.description
			else:
				$Description.text = "TO BE ADDED"
		4:
			$Move4.frame = 1
			var move = poke.move_4
			$Type.frame = move.type
			$Category/Value.frame = move.style
			$Power/Value.text = str(move.base_power)
			$Accuracy/Value.text = str(move.accuracy)

			if "description" in move && move.description != null:
				$Description.text = move.description
			else:
				$Description.text = "TO BE ADDED"
		5:
			$NewMove.frame = 1
			var move = new_move
			$Type.frame = move.type
			$Category/Value.frame = move.style
			$Power/Value.text = str(move.base_power)
			$Accuracy/Value.text = str(move.accuracy)

			if "description" in move && move.description != null:
				$Description.text = move.description
			else:
				$Description.text = "TO BE ADDED"

	
	pass
