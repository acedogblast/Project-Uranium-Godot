extends Node
const TOP = Vector2(10,10) # These are the positions where the dialogue 
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10,280)
const LINELIMIT = 36
const BAGICONLINESIZE = 2

#BagIconTextHits   To be used in dialoge text for hinting Icons

const ITEMS = "<ITEMS>"
const MEDICINE = "<MEDICINE>"
const POKEBALLS = "<POKEBALLS>"
const TMANDHMS = "<TMANDHMS>"
const BERRIES = "<BERRIES>"
const MAIL = "<MAIL>"
const BATTLEITEMS = "<BATTLEITEMS>"
const KEYITEMS = "<KEYITEMS>"

#BagIconsFiles
var Items = load("res://Graphics/Icons/bagPocket1.png")
var Medicine = load("res://Graphics/Icons/bagPocket2.png")
var PokeBalls = load("res://Graphics/Icons/bagPocket3.png")
var TMandHMs = load("res://Graphics/Icons/bagPocket4.png")
var Berries = load("res://Graphics/Icons/bagPocket5.png")
var Mail = load("res://Graphics/Icons/bagPocket6.png")
var BattleItems = load("res://Graphics/Icons/bagPocket7.png")
var KeyItems = load("res://Graphics/Icons/bagPocket8.png")

var text = []
var textLines = 0
var currentLine = 0
var isFinished = false
var forceArrow = false

func _ready():
	$Box/Text1.bbcode_enabled = true
	$Box/Text2.bbcode_enabled = true
	
	pass
func loadText(textArray, forceArrowShow): #Old function. To be removed
	text = textArray
	textLines = textArray.size()
	forceArrow = forceArrowShow
	pass
func loadTextNew(): #New Function
	
	pass
func parseText(var input): #Input is a single string
# "\n" are new lines forced.
	var finalTextLine = []
	var isDoneParsing = false
	
	while isDoneParsing == false:
		var nextLineIndex = input.find("\n")
	
	
	
	
	
	return finalTextLine
	pass
#func _process(delta):
#	
#	pass
