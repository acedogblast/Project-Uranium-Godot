extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	test()

func signaled_function():
	print("Signaled!")

func test():
	print("Start of Test")
	DialogueSystem.dialogue_start.connect(signaled_function)
	
	DialogueSystem.set_dialogue_sequence("CUTSCENE_PLAYERCREATION_D")
	DialogueSystem.start_dialogue_sequence()
	#print("Awaiting...")
	await DialogueSystem.dialogue_sequence_end
	print("Test Done!")
	
	
