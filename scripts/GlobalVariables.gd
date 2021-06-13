extends Node
var save_path = "user://save_slot1.dat"
var coins = 0
var totalShips = 0
var shipyards = null
var ships = null
var wineCount = 0
var compass = false
var cartography = false
var astrolabe = false
var Madeira = 1
var canhao = 1
var vela = 1
var arquitetura_nautica = 1

func _ready():
	SaveFile.save_path = save_path
	SaveFile.Load_request()
	if SaveFile.loadData != null:
		coins = SaveFile.loadData.coins
		shipyards = SaveFile.loadData.shipyards
		ships = SaveFile.loadData.ships
		totalShips = SaveFile.loadData.totalShips
		wineCount = SaveFile.loadData.inventory.wine
		compass = SaveFile.loadData.upgrades.compass
		cartography = SaveFile.loadData.upgrades.cartography
		astrolabe = SaveFile.loadData.upgrades.astrolabe
		Madeira = SaveFile.loadData.upgrades.Madeira
		canhao = SaveFile.loadData.upgrades.canhao
		vela = SaveFile.loadData.upgrades.vela
		arquitetura_nautica = SaveFile.loadData.upgrades.arquitetura_nautica
