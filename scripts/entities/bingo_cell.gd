extends Node
class_name BingoCell

@onready
var cellText = $CellText

var text: String = "[p align=center][font_size=20]%s %s\n%s\n%s"

var colossus: String = "UNDEFINED"
var difficulty: String = "UTA"
var time: float = 0.0
var offset: int = 0

func setup(t_difficulty: String, t_colossus: String, t_time: float, t_offset: int) -> void:
	difficulty = t_difficulty
	colossus = t_colossus
	time = t_time
	offset = t_offset
	
	change_text()

func change_text() -> void:
	cellText.text = text % [difficulty, colossus, Utils.convert_time(time, offset), str(offset) + "%"]
