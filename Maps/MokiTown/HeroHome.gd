extends Node

#var isInteracting = false
#var canInteract = true

var place_name = Global.TrainerName + "'s House"

var background_music = "res://Audio/BGM/PU-Hero House.ogg";

var type = "Indoor"

var event_1_name = "EVENT_HEROHOME_1"
var grass_pos = []

var heal_point = Vector2(192,144)

func _ready():
	$BlackBG.visible = true
	$Floor2/TileMap5.z_index = 9

	$Aunt.set_idle_frame("Up")
	Global.game.get_node("CanvasLayer/Fade").visible = false
	event1()

func interaction(check_pos : Vector2, direction): # check_pos is a Vector2 of the position of object to interact
	if check_pos == $Floor2.position + $Floor2/Console.position:
		return "INTERACT_MOKITOWN_HOUSE_CONSOLE"
	if check_pos == $Floor2.position + $Floor2/TV.position:
		return "INTERACT_MOKITOWN_HOUSE_TV"
	if check_pos == $Floor2.position + $Floor2/TV2.position:
		return "INTERACT_MOKITOWN_HOUSE_TV"
	if check_pos == $Floor2.position + $Floor2/Shelf.position:
		return "INTERACT_MOKITOWN_HOUSE_BOOKSHELF"
	if check_pos == $Floor2.position + $Floor2/Shelf2.position:
		return "INTERACT_MOKITOWN_HOUSE_BOOKSHELF"
	if check_pos == $Aunt.position: # NPC interaction
		#Face player
		$Aunt.face_player(direction)
		#Trigger event2
		if !Global.past_events.has("EVENT_HEROHOME_NPC_AUNT_1"):
			event2()
			return null
		if Global.past_events.has("EVENT_HEROHOME_NPC_AUNT_1") && Global.pokemon_group.empty():
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NPC_AUNT1_D13" , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			$Aunt.set_idle_frame("Down")
			Global.game.release_player()
			return null
		if !Global.past_events.has("EVENT_HEROHOME_NPC_AUNT_RETURNED"):
			Global.game.lock_player()
			if Global.past_events.has("EVENT_MOKI_LAB_GOT_RAPTORCH"):
				Global.game.play_dialogue_with_point("NPC_AUNT1_D14_RAPTORCH" , $Aunt.get_global_transform_with_canvas().get_origin())
			elif Global.past_events.has("EVENT_MOKI_LAB_GOT_ORCHYNX"):
				Global.game.play_dialogue_with_point("NPC_AUNT1_D14_ORCHYNX" , $Aunt.get_global_transform_with_canvas().get_origin())
			else:
				Global.game.play_dialogue_with_point("NPC_AUNT1_D14_ELETUX" , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			$Aunt.set_idle_frame("Down")
			Global.game.release_player()
			Global.past_events.append("EVENT_HEROHOME_NPC_AUNT_RETURNED")
			return null
		if Global.past_events.has("EVENT_HEROHOME_NPC_AUNT_RETURNED"): # Heal player
			Global.game.lock_player()
			Global.game.play_dialogue_with_point("NPC_AUNT_HEAL_1" , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

			Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play_backwards("Fade")
			yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")

			Global.heal_party()
			Global.game.last_heal_point = filename

			# Play heal sound effect
			var sound = load("res://Audio/ME/Pokemon Healing.ogg")
			sound.loop = false
			Global.game.get_node("Effect_music").stream = sound
			Global.game.get_node("Effect_music").play()
			yield(Global.game.get_node("Effect_music"), "finished")
			DialogueSystem.set_box_position(DialogueSystem.TOP)

			Global.game.play_dialogue("NPC_AUNT_HEAL_2")
			yield(Global.game, "event_dialogue_end")
			Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play("Fade")
			yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")
			DialogueSystem.set_box_position(DialogueSystem.BOTTOM)

			Global.game.play_dialogue_with_point("NPC_AUNT_HEAL_3" , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			# Pick random quote
			var ran = Global.rng.randi() % 14 + 1
			Global.game.play_dialogue_with_point("NPC_AUNT_HEAL_RANDOM_" + str(ran) , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
			$Aunt.set_idle_frame("Down")
			Global.game.release_player()
			return null


	return null

func block(_body):
	if !Global.past_events.has("EVENT_HEROHOME_NPC_AUNT_1"):
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.lock_player()
		Global.game.play_dialogue("HERO_HOME_BLOCK")
		yield(Global.game, "event_dialogue_end")
		Global.game.player.call_deferred("move_player_event", Global.game.player.DIRECTION.UP, 1)
		yield(Global.game.player, "done_movement")
		Global.game.release_player()

func event1(): # Aunt Calling player downstairs
	var event_name = "EVENT_HEROHOME_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.game.get_node("CanvasLayer/Fade").visible = true
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.lock_player()
		Global.game.get_node("CanvasLayer/Fade/AnimationPlayer").play("Fade")
		yield(Global.game.get_node("CanvasLayer/Fade/AnimationPlayer"), "animation_finished")
		Global.game.get_node("CanvasLayer/Fade").visible = false
		Global.game.play_dialogue_with_point(event_name, Vector2(120, 140))
		yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
		Global.past_events.append(event_name)
func event2():
	var event_name = "EVENT_HEROHOME_NPC_AUNT_1"
	if !Global.past_events.has(event_name):
		print("New Event: " + event_name)
		Global.past_events.append(event_name)
		Global.game.lock_player()
		DialogueSystem.set_box_position(DialogueSystem.TOP)

		for i in range(4):
			Global.game.play_dialogue_with_point("NPC_AUNT1_D" + str(i+1) , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")

		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		Global.game.play_dialogue_with_point("NPC_AUNT1_D5" , $Aunt.get_global_transform_with_canvas().get_origin())
		yield(Global.game, "event_dialogue_end")

		Global.game.play_dialogue("NPC_AUNT1_D6")
		# Play key item sound
		var time = Global.game.get_node("Background_music").get_playback_position()
		Global.game.get_node("Background_music").stop()
		var sound = load("res://Audio/ME/Jinlge - KeyItem.ogg")
		sound.loop = false
		Global.game.get_node("Effect_music").stream = sound
		Global.game.get_node("Effect_music").play()
		yield(Global.game.get_node("Effect_music"), "finished")
		Global.game.get_node("Background_music").play(time)

		# Enable running
		Global.can_run = true
		
		Global.game.play_dialogue("NPC_AUNT1_D7")
		yield(Global.game, "event_dialogue_end")

		DialogueSystem.set_box_position(DialogueSystem.TOP)
		for i in range(5):
			Global.game.play_dialogue_with_point("NPC_AUNT1_D" + str(i+8) , $Aunt.get_global_transform_with_canvas().get_origin())
			yield(Global.game, "event_dialogue_end")
		Global.game.release_player()
		DialogueSystem.set_box_position(DialogueSystem.BOTTOM)
		
