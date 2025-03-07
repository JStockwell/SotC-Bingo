extends Node

#region NTA LineEdits
var NTA_LE = []
@onready var ntaCol1LE = $Col/NTA/Col1/LineEdit
@onready var ntaCol2LE = $Col/NTA/Col2/LineEdit
@onready var ntaCol3LE = $Col/NTA/Col3/LineEdit
@onready var ntaCol4LE = $Col/NTA/Col4/LineEdit
@onready var ntaCol5LE = $Col/NTA/Col5/LineEdit
@onready var ntaCol6LE = $Col/NTA/Col6/LineEdit
@onready var ntaCol7LE = $Col/NTA/Col7/LineEdit
@onready var ntaCol8LE = $Col/NTA/Col8/LineEdit
@onready var ntaCol9LE = $Col/NTA/Col9/LineEdit
@onready var ntaCol10LE = $Col/NTA/Col10/LineEdit
@onready var ntaCol11LE = $Col/NTA/Col11/LineEdit
@onready var ntaCol12LE = $Col/NTA/Col12/LineEdit
@onready var ntaCol13LE = $Col/NTA/Col13/LineEdit
@onready var ntaCol14LE = $Col/NTA/Col14/LineEdit
@onready var ntaCol15LE = $Col/NTA/Col15/LineEdit
@onready var ntaCol16LE = $Col/NTA/Col16/LineEdit
#endregion

#region HTA LineEdits
var HTA_LE = []
@onready var htaCol1LE = $Col/HTA/Col1/LineEdit
@onready var htaCol2LE = $Col/HTA/Col2/LineEdit
@onready var htaCol3LE = $Col/HTA/Col3/LineEdit
@onready var htaCol4LE = $Col/HTA/Col4/LineEdit
@onready var htaCol5LE = $Col/HTA/Col5/LineEdit
@onready var htaCol6LE = $Col/HTA/Col6/LineEdit
@onready var htaCol7LE = $Col/HTA/Col7/LineEdit
@onready var htaCol8LE = $Col/HTA/Col8/LineEdit
@onready var htaCol9LE = $Col/HTA/Col9/LineEdit
@onready var htaCol10LE = $Col/HTA/Col10/LineEdit
@onready var htaCol11LE = $Col/HTA/Col11/LineEdit
@onready var htaCol12LE = $Col/HTA/Col12/LineEdit
@onready var htaCol13LE = $Col/HTA/Col13/LineEdit
@onready var htaCol14LE = $Col/HTA/Col14/LineEdit
@onready var htaCol15LE = $Col/HTA/Col15/LineEdit
@onready var htaCol16LE = $Col/HTA/Col16/LineEdit
#endregion

var tempColTimes: Dictionary

func _ready() -> void:
	setup_le()
	update_labels()

func setup_le() -> void:
	NTA_LE.append(ntaCol1LE)
	NTA_LE.append(ntaCol2LE)
	NTA_LE.append(ntaCol3LE)
	NTA_LE.append(ntaCol4LE)
	NTA_LE.append(ntaCol5LE)
	NTA_LE.append(ntaCol6LE)
	NTA_LE.append(ntaCol7LE)
	NTA_LE.append(ntaCol8LE)
	NTA_LE.append(ntaCol9LE)
	NTA_LE.append(ntaCol10LE)
	NTA_LE.append(ntaCol11LE)
	NTA_LE.append(ntaCol12LE)
	NTA_LE.append(ntaCol13LE)
	NTA_LE.append(ntaCol14LE)
	NTA_LE.append(ntaCol15LE)
	NTA_LE.append(ntaCol16LE)
	
	HTA_LE.append(htaCol1LE)
	HTA_LE.append(htaCol2LE)
	HTA_LE.append(htaCol3LE)
	HTA_LE.append(htaCol4LE)
	HTA_LE.append(htaCol5LE)
	HTA_LE.append(htaCol6LE)
	HTA_LE.append(htaCol7LE)
	HTA_LE.append(htaCol8LE)
	HTA_LE.append(htaCol9LE)
	HTA_LE.append(htaCol10LE)
	HTA_LE.append(htaCol11LE)
	HTA_LE.append(htaCol12LE)
	HTA_LE.append(htaCol13LE)
	HTA_LE.append(htaCol14LE)
	HTA_LE.append(htaCol15LE)
	HTA_LE.append(htaCol16LE)

func update_labels() -> void:
	load_times()
	for i in range(2):
		for j in range(NTA_LE.size()):
			if i == 0:
				NTA_LE[j].text = "" if tempColTimes["nta"][Variables.COLOSSUS_ENUM.find_key(j)] == 0 else Utils.convert_time(tempColTimes["nta"][Variables.COLOSSUS_ENUM.find_key(j)], 0)
			else:
				HTA_LE[j].text = "" if tempColTimes["hta"][Variables.COLOSSUS_ENUM.find_key(j)] == 0 else Utils.convert_time(tempColTimes["hta"][Variables.COLOSSUS_ENUM.find_key(j)], 0)
	pass

func _on_set_times_pressed() -> void:
	print_debug("Saving times...")
	print_verbose(tempColTimes)
	Utils.save_file(Variables.TIMES_PATH, tempColTimes)
	update_labels()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_time_text_changed(new_text: String, isHTA: bool, colNum: int) -> void:
	var colId = Variables.COLOSSUS_ENUM.find_key(colNum - 1)
	
	if validate_time(new_text):
		var tempTime = convert_time(new_text)
		
		if not isHTA:
			tempColTimes["nta"][colId] = tempTime
		else:
			tempColTimes["hta"][colId] = tempTime

func convert_time(text: String) -> float:
	var result = 0.0
	var times = text.split(":")
	
	if times.size() > 1:
		result += float(times[0]) * 60.0
		times.remove_at(0)
	
	result += float(times[0])

	return result

func validate_time(textToValidate: String) -> bool:
	var result = false
	var timeRegex = RegEx.new()
	timeRegex.compile("([1-9]:)?[0-5]?\\d\\.\\d\\d")
	
	var regexResult = timeRegex.search(textToValidate)
	if regexResult:
		if textToValidate == regexResult.get_string():
			print_debug(textToValidate + " is valid")
			result = true
			
		else:
			printerr(textToValidate + " is invalid")
			result = false
	
	return result

func load_times() -> void:
	var loadedTimes = Utils.load_file(Variables.TIMES_PATH)
	
	if loadedTimes.keys().size() > 0:
		tempColTimes = loadedTimes
		
	else:
		printerr("Invalid ColTimes")


func _on_reset_times_pressed() -> void:
	Utils.load_file(Variables.TIMES_PATH)
	update_labels()


func _on_delete_times_pressed() -> void:
	var reference = Utils.load_file(Variables.RESET_PATH)
	Utils.save_file(Variables.TIMES_PATH, reference)
	update_labels()
