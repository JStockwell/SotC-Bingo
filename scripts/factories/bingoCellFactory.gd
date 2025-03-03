extends Node

const BingoCellScene = preload("res://scenes/entities/bingo_cell.tscn")

static func create(args: Dictionary) -> BingoCell:
	var cell = BingoCellScene.instantiate()
	
	cell.colossus = args["colossus"]
	cell.difficulty = args["difficulty"]
	# TODO Get time
	cell.time = args["time"] * (1 + args["offset"] / 100)
	cell.offset = args["offset"]
	
	return cell
