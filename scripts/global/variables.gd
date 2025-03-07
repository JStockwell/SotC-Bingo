extends Node

const TIMES_PATH = "user://times.json"
const RESET_PATH = "res://json/reference_times.json"

const SRC_DIFFICULTIES = {
	"7kjp4p3k": "NTA",
	"xk9g1gvd": "HTA"
}

const SRC_COLOSSI = {
	"z987887w": "Valus",
	"ldygppjd": "Quadratus",
	"gdrxqq8d": "Gaius",
	"nwlo77pw": "Phaedra",
	"ywe588qw": "Avion",
	"69z24469": "Barba",
	"r9g433q9": "Hydrus",
	"o9x7ll6d": "Kuromori",
	"49558829": "Basaran",
	"rdq711m9": "Dirge",
	"5d74335d": "Celosia",
	"kwjzeer9": "Pelagia",
	"owo622vw": "Phalanx",
	"xd1255qw": "Cenobia",
	"ewpxqqld": "Argus",
	"y9mxpplw": "Malus"
}

const COLOSSI: Dictionary = {
	"col1": "Valus",
	"col2": "Quadratus",
	"col3": "Gaius",
	"col4": "Phaedra",
	"col5": "Avion",
	"col6": "Barba",
	"col7": "Hydrus",
	"col8": "Kuromori",
	"col9": "Basaran",
	"col10": "Dirge",
	"col11": "Celosia",
	"col12": "Pelagia",
	"col13": "Phalanx",
	"col14": "Cenobia",
	"col15": "Argus",
	"col16": "Malus"
}

enum COLOSSUS_ENUM {
	col1, col2, col3, col4, col5, col6, col7, col8,
	col9, col10, col11, col12, col13, col14, col15, col16
}

var colTimes: Dictionary

var bgColour: Color

func get_colTimes() -> Dictionary:
	return colTimes

func set_colTimes(tempTimes: Dictionary) -> void:
	if validate_colTimes(tempTimes):
		colTimes = tempTimes
	
	else:
		printerr("Invalid colTimes")

func validate_colTimes(tempTimes: Dictionary) -> bool:
	var result = true
	
	return result
