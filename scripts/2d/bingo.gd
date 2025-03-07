extends Node

const OFFSETS = [1, 5, 10, 15, 20, 33]
const OFFSET_WEIGHTS = [0.1, 0.6, 1, 1, 0.8, 0.3]

@onready
var board = $Board
@onready
var bg = $BG

func _ready() -> void:
	bg.color = Variables.bgColour
	generate_board()

func generate_board() -> void:
	var cellDict = generate_cells()
	var index = 0
	
	for i in range(sqrt(cellDict["colossi"].size())):
		for j in range(sqrt(cellDict["colossi"].size())):
			var args = {}
			index = i * 5 + j
			
			args["colossus"] = Variables.COLOSSI[cellDict["colossi"][index]]
			args["difficulty"] = Variables.SRC_DIFFICULTIES[cellDict["difficulties"][index]]
			# TODO Get time
			#args["time"] = snapped(randf_range(15.00, 180.00), 0.01)
			args["time"] = Variables.get_colTimes()[args["difficulty"].to_lower()][cellDict["colossi"][index]]
			args["offset"] = cellDict["offsets"][index]
			
			# position 180 * j, 180 * i
			var tempCell = Factory.BingoCell.create(args)
			board.add_child(tempCell)
			tempCell.change_text()
			tempCell.position = Vector2(10 + 185 * j, 10 + 185 * i)

func generate_cells() -> Dictionary:
	var cellCol = []
	var cellDif = []
	var cellOff = []
	
	var colossiKeys = Variables.COLOSSI.keys()
	var diffKeys = Variables.SRC_DIFFICULTIES.keys()
	
	for i in range(25):
		for j in range(999):
			var randCol = colossiKeys.pick_random()
			
			if randCol not in cellCol:
				cellCol.append(randCol)
				break
				
			else:
				if cellCol.count(randCol) == 1:
					cellCol.append(randCol)
					break
	
	var searchedCol = []
	for i in range(cellCol.size()):
		var randDif = diffKeys.pick_random()
		
		if cellCol[i] in searchedCol:
			var index = cellCol.find(cellCol[i])
			var oldDif = cellDif[index]
			
			if oldDif == "7kjp4p3k":
				randDif = "xk9g1gvd"
				
			else:
				randDif = "7kjp4p3k"
		
		cellDif.append(randDif)
		searchedCol.append(cellCol[i])
		
	for i in range(cellCol.size()):
		var random = RandomNumberGenerator.new()
		cellOff.append(OFFSETS[random.rand_weighted(OFFSET_WEIGHTS)])
	
	return {"colossi": cellCol, "difficulties":cellDif, "offsets":cellOff}
