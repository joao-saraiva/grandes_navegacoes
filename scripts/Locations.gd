extends Node

func _ready():
	if SaveFile.loadData != null:
		print("save")
		exploration = SaveFile.loadData.locations

var muslims = {
	"distance": 240,
	"navegationDifficulty": 1,
	"dangerousness": 11,
	"searching": 0,
	price = {
		"wine": 25,
		"sugar": 10 ,
		"beer": 15,
		"gold": 100,
		"silver": 75 
	},
	contract = {
		"open": false,
		"wine": 0,
		"sugar": 0 ,
		"beer": 0,
		"gold": 0,
		"silver": 0
	}
}

var spain = {
	"distance": 30,
	"navegationDifficulty": 1,
	"dangerousness": 11,
	price = {
		"wine": 50,
		"sugar": 25,
		"beer": 35,
		"gold": 175,
		"silver": 140,
		"Nutmeg": 40,
		"BlackPepper": 45,
		"clove": 30,
		"ginger":35,
		"cloth": 50
	}
}

var france = {
	"distance": 100,
	"navegationDifficulty": 1,
	"dangerousness": 11,
	price = {
		"wine": 160,
		"sugar": 75,
		"beer": 100,
		"gold": 550,
		"silver": 380,
		"Nutmeg": 120,
		"BlackPepper": 130,
		"clove": 120,
		"ginger":110,
		"cloth": 150
	}
}

var italy = {
	"distance": 140,
	"navegationDifficulty": 1,
	"dangerousness": 11,
	price = {
		"wine": 180,
		"sugar": 105,
		"beer": 130,
		"gold": 650,
		"silver": 400,
		"Nutmeg": 200,
		"BlackPepper": 200,
		"clove": 190,
		"ginger":195,
		"cloth": 200
	}
}

var portugal = {
	"distance": 70,
	"navegationDifficulty": 1,
	"dangerousness": 11,
	price = {
		"wine": 140,
		"sugar": 55,
		"beer": 80,
		"gold": 490,
		"silver": 320,
		"Nutmeg": 120,
		"BlackPepper": 130,
		"clove": 100,
		"ginger":100,
		"cloth": 180
	}
}

var exploration = {
	madeira = {
		"distance": 100,
		"navegationDifficulty": 10,
		"dangerousness": 13,
		"found": false,
		"searching": 0,
		"colonized": false
	},

	acores = {
		"distance": 120,
		"navegationDifficulty": 15,
		"dangerousness": 15,
		"found": false,
		"searching": 0,
		"colonized": false
	},

	cabo_verde = {
		"distance": 240,
		"navegationDifficulty": 16,
		"dangerousness": 25,
		"found": false,
		"searching": 0,
		"colonized": false
	},

	sao_tome = {
		"distance": 480,
		"navegationDifficulty": 20,
		"dangerousness": 50,
		"found": false,
		"searching": 0,
		"colonized": false
	},

	caboBoaEsperanca = {
		"distance": 750,
		"navegationDifficulty": 30,
		"dangerousness": 80,
		"found": false,
		"searching": 0,
		"colonized": false
	},
	
	india = {
		"distance": 1500,
		"navegationDifficulty": 100,
		"dangerousness": 150,
		"found": false,
		"searching": 0,
		price = {
			"wine": 15,
			"sugar": 17 ,
			"beer": 10,
			"gold": 75,
			"silver": 55,
			"Nutmeg": 10 ,
			"BlackPepper": 15,
			"clove": 10,
			"ginger":15,
			"cloth": 25,
		},
		contract = {"open": false}
	}
}

var brazil = {
	"distance": 520,
	"navegationDifficulty": 0,
	"dangerousness": 0
}
