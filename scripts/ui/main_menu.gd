extends Node

@onready
var bgColourLE = $BGColor

func _ready() -> void:
	print_debug("Save file loaded")
	Variables.set_colTimes(Utils.load_file(Variables.TIMES_PATH))
	
	if Variables.get_colTimes().keys().size() == 0:
		print_debug("No save file detected, creating new save file")
		Utils.save_file(Variables.TIMES_PATH, Utils.load_file(Variables.RESET_PATH))
		Variables.set_colTimes(Utils.load_file(Variables.TIMES_PATH))
	

func _on_generate_board_pressed() -> void:
	var regEx = RegEx.new()
	regEx.compile("^([A-F]|\\d){6}$")
	
	var regexResult = regEx.search(bgColourLE.text)
	
	if regexResult:
		Variables.bgColour = Color.from_string(bgColourLE.text, Color.SLATE_GRAY)
		
	else:
		Variables.bgColour = Color.SLATE_GRAY
		
	get_tree().change_scene_to_file("res://scenes/2d/bingo.tscn")


func _on_set_times_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/set_times.tscn")
