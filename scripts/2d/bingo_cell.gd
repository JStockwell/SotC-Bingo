extends Node

@onready
var cellText = $Cell/CellText

var text: String = "[p align=center][font_size=20]%s %s\n%s\n%s"

var difficulty: String = "UTA"
var colossus: String = "UNDEFINED"
var time: float = 0.0
var offset: int = 0

func setup(t_difficulty: String, t_colossus: String, t_time: float, t_offset: int) -> void:
	difficulty = t_difficulty
	colossus = t_colossus
	time = t_time
	offset = t_offset
	
	change_text()

func change_text() -> void:
	cellText.text = text % [difficulty, colossus, convert_time(time), str(offset) + "%"]

func convert_time(pTime: float) -> String:
	var adjustedTime = pTime * (1 + (float(offset) / 100))
	
	var minutes = snapped(adjustedTime / 60, 0)
	var seconds = snapped(adjustedTime - minutes * 60, 0)
	var miliseconds = snapped(adjustedTime - snapped(adjustedTime, 0), 0.01)
	
	if minutes == 0:
		minutes = ""
		
	else:
		minutes = "%s:" % minutes
	
	var finalTime = "%s:%s.%s" % [minutes, seconds, str(miliseconds).replace("0.", "")]
	return finalTime
