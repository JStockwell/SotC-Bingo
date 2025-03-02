extends Node

const DIFFICULTIES = {
	"7kjp4p3k": "NTA",
	"xk9g1gvd": "HTA"
}

const COLOSSI = {
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

const OFFSETS = [1, 5, 10, 15, 20, 33]
const OFFSET_WEIGHTS = [0.1, 0.6, 1, 1, 0.8, 0.3]

@onready
var testCell = $BingoCell
@onready
var board = $Board

# DEBUG
var testRun = ["", "", 142.84, 0]

func _ready() -> void:
	var testRunJson = UTILS_JSON.read_json("res://scripts/json/test_run.json")["data"]
	var parsedJson = run_json_parse(testRunJson)
	
	testCell.setup(parsedJson[0], parsedJson[1], parsedJson[2], 33)
	
	generate_board()

func generate_board() -> void:
	var cellDict = generate_cells()
	var index = 0
	for i in range(sqrt(cellDict["colossi"].size())):
		for j in range(sqrt(cellDict["colossi"].size())):
			var args = {}
			index = i * 5 + j
			
			args["colossus"] = COLOSSI[cellDict["colossi"][index]]
			args["difficulty"] = DIFFICULTIES[cellDict["difficulties"][index]]
			# TODO Get time
			args["time"] = snapped(randf_range(15.00, 180.00), 0.01)
			args["offset"] = cellDict["offsets"][index]
			
			# position 250 * j, 250 * i
			var tempCell = Factory.BingoCell.create(args)
			board.add_child(tempCell)
			tempCell.change_text()
			tempCell.position = Vector2(256 * j, 256 * i)

func generate_cells() -> Dictionary:
	var cellCol = []
	var cellDif = []
	var cellOff = []
	
	var colossiKeys = COLOSSI.keys()
	var diffKeys = DIFFICULTIES.keys()
	
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

func run_json_parse(json: Dictionary) -> Array:
	var difficulty: String = DIFFICULTIES[json["category"]]
	var colossus: String = COLOSSI[json["level"]]
	var pTime: float
	
	pTime = json["times"]["primary_t"]
	
	return [difficulty, colossus, pTime]
