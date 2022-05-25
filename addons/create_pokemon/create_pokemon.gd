tool
extends EditorPlugin

var open = false
var r

func _ready():
	
	
	pass


func _input(event):
	if Input.is_key_pressed(KEY_F12) && !open:
		open = true
		r = load("res://addons/create_pokemon/interface.tscn").instance()
		r.get_node("ColorRect").get_node("Button").connect("pressed", self, "_on_pressed", [r])
		add_child(r)
		pass
	elif Input.is_key_pressed(KEY_F12) && open:
		r.queue_free()
		open = false


func _on_pressed(interface):
	
	# add pokemon resource
	var res : Resource = load("res://Utilities/Battle/Database/Pokemon/PokemonBase.gd").new()
	res.set_script(load("res://Utilities/Battle/Database/Pokemon/PokemonBase.gd").duplicate(true))
	
	# set pokemon data
	res.name = interface.get_node("ColorRect").get_node("Name").text
	res.ID = int(interface.get_node("ColorRect").get_node("ID").value)
	res.hp = int(interface.get_node("ColorRect").get_node("Stats").get_node("HP").value)
	res.attack = int(interface.get_node("ColorRect").get_node("Stats").get_node("Attack").value)
	res.defense = int(interface.get_node("ColorRect").get_node("Stats").get_node("Defense").value)
	res.sp_attack = int(interface.get_node("ColorRect").get_node("Stats").get_node("Sp Attack").value)
	res.sp_defense = int(interface.get_node("ColorRect").get_node("Stats").get_node("Sp Defense").value)
	res.speed = int(interface.get_node("ColorRect").get_node("Stats").get_node("Speed").value)
	res.ev_yield_hp = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV HP").value)
	res.ev_yield_attack = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV Attack").value)
	res.ev_yield_defense = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV Defense").value)
	res.ev_yield_sp_attack = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV Sp Attack").value)
	res.ev_yield_sp_defense = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV Sp Defense").value)
	res.ev_yield_speed = int(interface.get_node("ColorRect").get_node("EV yield").get_node("EV Speed").value)
	res.exp_yield = int(interface.get_node("ColorRect").get_node("Exp_yield").value)
	
	res.leveling_rate = interface.get_node("ColorRect").get_node("leveling_Rate").selected
	
	res.male_ratio = interface.get_node("ColorRect").get_node("Male_Rate").value
	res.evolution_level = int(interface.get_node("ColorRect").get_node("Evolution").get_node("Level").value)
	res.evolution_ID = int(interface.get_node("ColorRect").get_node("Evolution").get_node("ID").value)
	
	ResourceSaver.save("res://Utilities/Battle/Database/Pokemon/" + res.name + ".tres", res)
	
	# remove interface
	interface.queue_free()
	open = false
	pass
