extends Node
var save_path = "user://save_slot1.dat"
var coins = 0
var totalShips = 0
var shipyards = null
var ships = null

func _ready():
	SaveFile.save_path = save_path
	SaveFile.Load_request()
	if SaveFile.loadData !=null:
		coins = SaveFile.loadData.coins
		shipyards = SaveFile.loadData.shipyards
		ships = SaveFile.loadData.ships
		print(ships)
		totalShips = SaveFile.loadData.totalShips
