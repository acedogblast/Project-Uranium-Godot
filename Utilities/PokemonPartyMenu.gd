extends CanvasLayer
# Slots
enum {S1, S2, S3, S4, S5, S6}
var selection
# Modes
enum {MANAGE, SELECT}
var mode

func _ready():
    # Testing setup. Should be removed when not testing
    test_setup()

    # Fill slots with current pokemon
    update_slots()
    pass
func _input(event):
    pass
func update_slots():
    print("Updating slots.")
    print("Size of pokemon group:" + str(Global.pokemon_group.size()))
    for i in range(1, 7):
        if i == 1: # First slot use round slot texture
            $Slot1/TextureRect.texture = load("res://Graphics/Pictures/partyPanelRound.png")
        elif i <= Global.pokemon_group.size():
            get_node("Slot" + str(i) + "/TextureRect").texture = load("res://Graphics/Pictures/partyPanelRect.png")
        else : # Use rect slot texture
            get_node("Slot" + str(i) + "/TextureRect").texture = load("res://Graphics/Pictures/partyPanelBlank.png")
            get_node("Slot" + str(i) + "/Content").visible = false
    pass
    
    # Fill slots
    var index = 1
    for poke in Global.pokemon_group:
        var slot_content = get_node("Slot" + str(index) + "/Content")
        slot_content.visible = true

        var name_label = slot_content.get_node("Name")
        change_label_text(name_label, poke.name)

        var level_label = slot_content.get_node("Level")
        change_label_text(level_label, "Lv." + str(poke.level))
        
        var hp_label = slot_content.get_node("HP")
        change_label_text(hp_label, str(poke.current_hp) + "/ " + str(poke.hp))
        
        var gender_label = slot_content.get_node("Gender")
        if poke.gender == poke.MALE:
            change_label_text(gender_label , "♂")
            gender_label.add_color_override("font_color" , Color("0070f8"))
            gender_label.get_node("Shadow").add_color_override("font_color" , Color("78b8e8"))
        if poke.gender == poke.FEMALE:
            change_label_text(gender_label , "♀")
            gender_label.add_color_override("font_color" , Color("e82010"))
            gender_label.get_node("Shadow").add_color_override("font_color" , Color("f8a8b8"))

        var icon_texture = slot_content.get_node("Poke")
        icon_texture.texture = poke.get_icon_texture()

        var hp_bar = slot_content.get_node("HP_Bar/ColorRect")
        set_hp_bar_by_percent(hp_bar, float(poke.current_hp) / float(poke.hp))

        # If hp is zero change background to faint
        if poke.current_hp == 0:
            if index == 1:
                slot_content.get_parent().get_node("TextureRect").texture = load("res://Graphics/Pictures/partyPanelRoundFnt.png")
            else:
                slot_content.get_parent().get_node("TextureRect").texture = load("res://Graphics/Pictures/partyPanelRectFnt.png")
            pass

        index += 1
            





func test_setup():
    print("Test setup.")
    var poke = Pokemon.new()
    poke.set_basic_pokemon_by_level(3,5)
    poke.current_hp = 0
    Global.pokemon_group.append(poke)
    poke = Pokemon.new()
    poke.set_basic_pokemon_by_level(1,5)
    Global.pokemon_group.append(poke)
    poke = Pokemon.new()
    poke.set_basic_pokemon_by_level(1,5)
    Global.pokemon_group.append(poke)
    poke = Pokemon.new()
    poke.set_basic_pokemon_by_level(1,5)
    Global.pokemon_group.append(poke)
    poke = Pokemon.new()
    poke.set_basic_pokemon_by_level(1,5)
    Global.pokemon_group.append(poke)
    pass
func change_label_text(label : Label, text : String):
    label.text = text
    label.get_node("Shadow").text = text
func set_hp_bar_by_percent(color_rect : ColorRect, percent : float):
    color_rect.rect_size = Vector2(96 * percent , 4)
    var color_of_hp
    if percent > 0.5:
        color_of_hp = Color( 0, 1, 0, 1) # Green
    elif percent <= 0.5 && percent > 0.2:
        color_of_hp = Color( 1, 1, 0, 1) # Yellow
    else:
        color_of_hp = Color( 1, 0, 0, 1) # Red
    color_rect.color = color_of_hp
