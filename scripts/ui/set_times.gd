extends Node

const TIMES_PATH = "user://times.json"
const RESET_PATH = "user://reference_times.json"

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

# TODO make external
var colTimes: Dictionary = {
	"nta": {
		"col1": 0.0,
		"col2": 0.0,
		"col3": 0.0,
		"col4": 0.0,
		"col5": 0.0,
		"col6": 0.0,
		"col7": 0.0,
		"col8": 0.0,
		"col9": 0.0,
		"col10": 0.0,
		"col11": 0.0,
		"col12": 0.0,
		"col13": 0.0,
		"col14": 0.0,
		"col15": 0.0,
		"col16": 0.0
	},
	"hta": {
		"col1": 0.0,
		"col2": 0.0,
		"col3": 0.0,
		"col4": 0.0,
		"col5": 0.0,
		"col6": 0.0,
		"col7": 0.0,
		"col8": 0.0,
		"col9": 0.0,
		"col10": 0.0,
		"col11": 0.0,
		"col12": 0.0,
		"col13": 0.0,
		"col14": 0.0,
		"col15": 0.0,
		"col16": 0.0
	}
}

enum COLOSSUS_ENUM {
	col1, col2, col3, col4, col5, col6, col7, col8,
	col9, col10, col11, col12, col13, col14, col15, col16
}

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

func update_labels() -> void:
	load_times()
	for i in range(2):
		for j in range(NTA_LE.size()):
			if i == 0:
				NTA_LE[j].text = "" if colTimes["nta"][COLOSSUS_ENUM.find_key(j)] == 0 else Utils.convert_time(colTimes["nta"][COLOSSUS_ENUM.find_key(j)], 0)
			#else:
				#HTA_LE[j].text = "" if colTimes["hta"][COLOSSUS_ENUM.find_key(j)] == 0 else Utils.convert_time(colTimes["hta"][COLOSSUS_ENUM.find_key(j)], 0)
	pass

func _on_set_times_pressed() -> void:
	print_debug("Saving times...")
	print_verbose(colTimes)
	Utils.save_file(TIMES_PATH, colTimes)
	update_labels()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_time_text_changed(new_text: String, isHTA: bool, colNum: int) -> void:
	var colId = COLOSSUS_ENUM.find_key(colNum - 1)
	
	if validate_time(new_text):
		var tempTime = convert_time(new_text)
		
		if not isHTA:
			colTimes["nta"][colId] = tempTime
		else:
			colTimes["hta"][colId] = tempTime

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
	var loadedTimes = Utils.load_file(TIMES_PATH)
	
	if loadedTimes:
		colTimes = loadedTimes
		
	print(colTimes)

func _on_reset_times_pressed() -> void:
	Utils.load_file(TIMES_PATH)
	update_labels()


func _on_delete_times_pressed() -> void:
	var reference = Utils.load_file(RESET_PATH)
	Utils.save_file(TIMES_PATH, reference)
	update_labels()
