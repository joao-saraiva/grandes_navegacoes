extends Node

func _ready():
	if not SaveFile.loadData.locations.empty():
		print("save")
		exploration = SaveFile.loadData.locations

var muslims = {
	"distance": 240,
	"navegationDifficulty": 1,
	"dangerousness": 11
}

var spain = {
	"distance": 30,
	"navegationDifficulty": 1,
	"dangerousness": 11
}

var france = {
	"distance": 100,
	"navegationDifficulty": 1,
	"dangerousness": 11
}

var italy = {
	"distance": 140,
	"navegationDifficulty": 1,
	"dangerousness": 11
}

var portugal = {
	"distance": 70,
	"navegationDifficulty": 1,
	"dangerousness": 11
}

var exploration = {
	madeira = {
		"distance": 100,
		"navegationDifficulty": 10,
		"dangerousness": 13,
		"found": false,
		"searching": 0
	},

	acores = {
		"distance": 120,
		"navegationDifficulty": 15,
		"dangerousness": 15,
		"found": false,
		"searching": 0
	},

	cabo_verde = {
		"distance": 240,
		"navegationDifficulty": 16,
		"dangerousness": 25,
		"found": false,
		"searching": 0
	},

	sao_tome = {
		"distance": 480,
		"navegationDifficulty": 20,
		"dangerousness": 50,
		"found": false,
		"searching": 0
	},

	caboBoaEsperanca = {
		"distance": 750,
		"navegationDifficulty": 30,
		"dangerousness": 80,
		"found": false,
		"searching": 0
	},
	
	india = {
		"distance": 1500,
		"navegationDifficulty": 100,
		"dangerousness": 150,
		"found": false,
		"searching": 0
	}
}

var brasil = {
	"distance": 520,
	"navegationDifficulty": 0,
	"dangerousness": 0
}
