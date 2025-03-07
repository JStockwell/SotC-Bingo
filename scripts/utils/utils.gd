extends Node

class_name Utils

static func convert_time(pTime: float, offset: int) -> String:
	var adjustedTime = pTime * (1 + (float(offset) / 100))
	
	var minutes = snapped(adjustedTime / 60, 0)
	var seconds = snapped(adjustedTime - minutes * 60, 0)
	var miliseconds = snapped(adjustedTime - snapped(adjustedTime, 0), 0.01)
	
	if minutes == 0:
		minutes = ""
		
	else:
		minutes = "%s:" % minutes
		
	if seconds < 10:
		seconds = "0%s." % seconds
		
	else:
		seconds = "%s." % seconds
	
	var finalTime = minutes + seconds + str(miliseconds).replace("0.", "")
	return finalTime


static func save_file(filePath: String, fileData: Dictionary) -> void:
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(fileData, "\t")
	file.store_line(json_string)


static func load_file(filePath: String) -> Dictionary:
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			push_error("Error reading file " + filePath)
			return {}
			
	else:
		push_error("File {path} doesn't exist!".format({"path": filePath}))
		return {}
