extends NinePatchRect
const TOP = Vector2(10,10)
const MIDDLE = Vector2(10, 150)
const BOTTOM = Vector2(10,280)

var text = []
var textLines = 0
var currentLine = 0
var isFinished = false
var forceArrow = false

func loadText(textArray, forceArrowShow):
	text = textArray
	textLines = textArray.size()
	forceArrow = forceArrowShow
	pass
func loadRichText(textArray, forceArrowShow):
	text = textArray
	textLines = textArray.size()
	forceArrow = forceArrowShow
	pass

func _ready():
	$Text1.bbcode_enabled = true
	$Text2.bbcode_enabled = true
	$AudioStreamPlayer.play()
	$Text1.bbcode_text = ""
	$Text2.bbcode_text = ""
	$Text1.percent_visible = 0
	$Text2.percent_visible = 0
	$PauseArrow.hide()
	#loadSingleExample()
	#loadMultiExample()
	if textLines <= 1:
		$Text1.bbcode_text = text[0]
		$Text1/AnimationPlayer.play("SingleText")
	else:
		$Text1.bbcode_text = text[0]
		$Text2.bbcode_text = text[1]
		$Text1/AnimationPlayer.play("MultiText")
	pass
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and $Text2/AnimationPlayer.is_playing() == false and $Text1/AnimationPlayer.is_playing() == false:
		if textLines == 1 and isFinished == true:
			self.queue_free()
			if isFinished:
				get_parent().dialogEnd()
		else:
			if isFinished:
				get_parent().dialogEnd()
				#self.queue_free()
			else:
				slideText()
	pass
func slideText():
	$PauseArrow.hide()
	if currentLine != (textLines - 2):
		currentLine = currentLine + 1
		$AnimationPlayer.play("Slide Text")
		$AudioStreamPlayer.play()
	else:
		get_parent().dialogEnd()
		#self.queue_free()
	pass
func swapText():
	var tempText = $Text2.bbcode_text
	$Text1.bbcode_text = ""
	$Text2.bbcode_text = ""
	$Text1.rect_position = Vector2(17,15)
	$Text2.rect_position = Vector2(17,50)
	$Text1.bbcode_text = tempText
	$Text2.percent_visible = 0
	$Text2.bbcode_text = text[currentLine + 1]
	$Text2/AnimationPlayer.play("Text")
	pass
func loadSingleExample():
	text = ["This is an example text."]
	textLines = text.size()
	forceArrow = true
	pass
func loadMultiExample():
	text = ["This is an example text.",
	"This is also an example text.",
	"This is the third line",
	"This is the fourth line",
	"This should be the last line of text."]
	textLines = text.size()
	forceArrow = true
	pass
func loadTwoExample():
	text = ["This is an example text.",
	"This is also an example text.",]
	textLines = text.size()
	forceArrow = true
	pass
func SecondLinePrinted():
	if textLines != 2 and currentLine != (textLines - 2):
		$PauseArrow.show()
	else:
		Finished()
	pass
func FirstLinePrinted():
	$Text2/AnimationPlayer.play("Text")
	if textLines == 1:
		Finished()
	pass
func Finished():
	if forceArrow == true:
		$PauseArrow.show()
	isFinished = true
	pass