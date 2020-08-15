extends Node2D

var enabled = false
enum {ATTACK, BAG, POKE, RUN}
var selected = ATTACK

var battle_node
var battle_attack_select_node
var battle_bag_node

onready var select_se_1 = load("res://Audio/SE/SE_Select1.wav")
onready var select_se_2 = load("res://Audio/SE/SE_Select2.wav")
onready var select_se_3 = load("res://Audio/SE/SE_Select3.wav")

const ATTACK_POS = Vector2(76, 50)
const BAG_POS = Vector2(195, 50)
const POKE_POS = Vector2(315, 50)
const RUN_POS = Vector2(435, 50)

signal command_received

func _ready():
	battle_node = self.get_parent().get_parent().get_parent()
	battle_attack_select_node = self.get_parent().get_node("BattleAttackSelect")
	battle_bag_node = self.get_parent().get_node("BattleBag")
	battle_attack_select_node.connect("command_received", self, "submit_command")
	battle_bag_node.connect("command_received", self, "submit_command")
func start(name):
	$SelHand/AnimationPlayer.play("Squeez")
	$Prompt.bbcode_text = "[center]What will " + name + " do?"
	$Prompt/PromptShadow.bbcode_text = "[center]What will " + name + " do?"
	enabled = true
	
	$AttackLable.visible = true
	$BagLable.visible = false
	$PokeLable.visible = false
	$RunLable.visible = false
	$Attack/AnimationPlayer.play("Slide")
	
func _input(event):
	if event.is_action_pressed("ui_left") and enabled and selected != ATTACK:
		selected -= 1
		change_Sel_Hand_Pos()
	if event.is_action_pressed("ui_right") and enabled and selected != RUN:
		selected += 1
		change_Sel_Hand_Pos()
	if event.is_action_pressed("ui_accept") and enabled:
		enabled = false
		var command = BattleCommand.new()
		match selected:
			ATTACK:
				$SelHand/AudioStreamPlayer.stream = select_se_2
				$SelHand/AudioStreamPlayer.play()
				self.visible = false
				battle_attack_select_node.position = Vector2(0, 286)
				battle_attack_select_node.visible = true
				battle_attack_select_node.call_deferred("start", battle_node.battler1)
			RUN:
				if battle_node.battle_instance.battle_type == BattleInstanceData.BattleType.SINGLE_WILD:
					command.command_type = command.RUN
					submit_command(command)
					self.visible = false
			BAG:
				self.visible = false
				battle_bag_node.call_deferred("start")
					

	
func change_Sel_Hand_Pos():
	match selected:
		ATTACK:
			$SelHand.position = ATTACK_POS
			$AttackLable.visible = true
			$BagLable.visible = false
			$PokeLable.visible = false
			$RunLable.visible = false
			$Bag.position = Vector2(195,70)
			$Poke.position = Vector2(315,70)
			$Run.position = Vector2(435,70)
			$Attack/AnimationPlayer.play("Slide")
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.stop(true)
		BAG:
			$SelHand.position = BAG_POS
			$AttackLable.visible = false
			$BagLable.visible = true
			$PokeLable.visible = false
			$RunLable.visible = false
			$Attack.position = Vector2(75,70)
			$Poke.position = Vector2(315,70)
			$Run.position = Vector2(435,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.play("Slide")
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.stop(true)
		POKE:
			$SelHand.position = POKE_POS
			$AttackLable.visible = false
			$BagLable.visible = false
			$PokeLable.visible = true
			$RunLable.visible = false
			$Attack.position = Vector2(75,70)
			$Bag.position = Vector2(195,70)
			$Run.position = Vector2(435,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.play("Slide")
			$Run/AnimationPlayer.stop(true)
		RUN:
			$SelHand.position = RUN_POS
			$AttackLable.visible = false
			$BagLable.visible = false
			$PokeLable.visible = false
			$RunLable.visible = true
			$Attack.position = Vector2(75,70)
			$Bag.position = Vector2(195,70)
			$Poke.position = Vector2(315,70)
			$Attack/AnimationPlayer.stop(true)
			$Bag/AnimationPlayer.stop(true)
			$Poke/AnimationPlayer.stop(true)
			$Run/AnimationPlayer.play("Slide")
	$SelHand/AudioStreamPlayer.stream = select_se_1
	$SelHand/AudioStreamPlayer.play()
func submit_command(command):
	self.get_parent().get_parent().get_parent().battle_command = command
	emit_signal("command_received")
