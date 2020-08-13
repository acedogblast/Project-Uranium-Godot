extends Node2D

var enabled = false
var stage = 1

enum {MEDICINE, POKEBALLS, BERRIES, BATTLE_ITEMS, LAST_ITEM, BACK}
var selection = MEDICINE

var last_item

func _ready():
	pass # Replace with function body.

func start():
	enabled = true
	self.visible = true
	# Slide
	$AnimationPlayer.play("SlideBag")

func _input(event):
	if enabled:
		if event.is_action_pressed("x"):
			enabled = false
			$Selection.visible = false
			# Close menu and go back
			$AnimationPlayer.play_backwards("SlideBag")
			yield($AnimationPlayer, "animation_finished")
			self.visible = false
			self.get_parent().get_node("BattleComandSelect").enabled = true
			self.get_parent().get_node("BattleComandSelect").visible = true
			return
		if event.is_action_pressed("ui_down"):
			match selection:
				MEDICINE:
					selection = BERRIES
				POKEBALLS:
					selection = BATTLE_ITEMS
				BERRIES:
					if last_item == null:
						selection = BACK
					else:
						selection = LAST_ITEM
				BATTLE_ITEMS:
					selection = BACK
			update_selection()
		if event.is_action_pressed("ui_up"):
			match selection:
				BERRIES:
					selection = MEDICINE
				BATTLE_ITEMS:
					selection = POKEBALLS
				BACK:
					selection = BATTLE_ITEMS
				LAST_ITEM:
					selection = BERRIES
			update_selection()
		if event.is_action_pressed("ui_left"):
			match selection:
				POKEBALLS:
					selection = MEDICINE
				BATTLE_ITEMS:
					selection = BERRIES
				BACK:
					if last_item == null:
						selection = BERRIES
					else:
						selection = LAST_ITEM
			update_selection()
		if event.is_action_pressed("ui_right"):
			match selection:
				MEDICINE:
					selection = POKEBALLS
				BERRIES:
					selection = BATTLE_ITEMS
				LAST_ITEM:
					selection = BACK
			update_selection()
		

		if event.is_action_pressed("ui_accept"):
			stage = 2
			$Selection.visible = false
			match selection:
				MEDICINE:
					$AudioStreamPlayer.stream = load("res://Audio/SE/SE_Select1.wav")
					$AudioStreamPlayer.play()
					$AnimationPlayer.play_backwards("SlideBag")
					yield($AnimationPlayer, "animation_finished")







				POKEBALLS:
				BERRIES:
				BATTLE_ITEMS:
				LAST_ITEM:
				BACK:
					stage = 1
					$Bottom/Last/Select.visible = false
					enabled = false
					# Close menu and go back
					$AnimationPlayer.play_backwards("SlideBag")
					yield($AnimationPlayer, "animation_finished")
					self.visible = false
					self.get_parent().get_node("BattleComandSelect").enabled = true
					self.get_parent().get_node("BattleComandSelect").visible = true


func update_selection():
	$Selection.visible = true
	$Bottom/Back/Select.visible = false
	$Bottom/Last/Select.visible = false
	match selection:
		MEDICINE:
			$Selection.position = Vector2(132,78)
		POKEBALLS:
			$Selection.position = Vector2(385,125)
		BERRIES:
			$Selection.position = Vector2(132,205)
		BATTLE_ITEMS:
			$Selection.position = Vector2(385, 250)
		LAST_ITEM:
			$Selection.visible = false
			$Bottom/Last/Select.visible = true
		BACK:
			$Selection.visible = false
			$Bottom/Back/Select.visible = true
	
	$AudioStreamPlayer.stream = load("res://Audio/SE/SE_Select1.wav")
	$AudioStreamPlayer.play()

