extends Node
class_name UTILS_JSON

static func read_json(jsonPath: String) -> Dictionary:
	if FileAccess.file_exists(jsonPath):
		var dataFile = FileAccess.open(jsonPath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			push_error("Error reading file " + jsonPath)
			return {}
			
	else:
		push_error("File {path} doesn't exist!".format({"path": jsonPath}))
		return {}
