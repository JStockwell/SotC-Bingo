extends Node

@onready
var testCell = $BingoCell

func _ready() -> void:
	testCell.setup("", "", 0.0, 0)
