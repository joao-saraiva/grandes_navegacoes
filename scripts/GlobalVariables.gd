extends Node
var save_path = "user://save_slot1.dat"
var coins = 0
var totalShips = 0
var shipyards = null
var ships = null
var wineAmount = 0
var sugarAmount = 0
var beerAmount = 0
var NutmegAmount = 0
var BlackPepperAmount = 0
var cloveAmount = 0
var gingerAmount = 0
var clothAmount = 0
var goldAmount = 0
var silverAmount = 0
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
		totalShips = SaveFile.loadData.totalShips
		wineAmount = SaveFile.loadData.inventory.wine.amount
		sugarAmount = SaveFile.loadData.inventory.sugar.amount
		beerAmount = SaveFile.loadData.inventory.beer.amount
		NutmegAmount = SaveFile.loadData.inventory.Nutmeg.amount
		BlackPepperAmount = SaveFile.loadData.inventory.BlackPepper.amount
		cloveAmount = SaveFile.loadData.inventory.clove.amount
		gingerAmount = SaveFile.loadData.inventory.ginger.amount
		clothAmount = SaveFile.loadData.inventory.cloth.amount
		goldAmount = SaveFile.loadData.inventory.gold.amount
		silverAmount = SaveFile.loadData.inventory.silver.amount
		compass = SaveFile.loadData.upgrades.compass
		cartography = SaveFile.loadData.upgrades.cartography
		astrolabe = SaveFile.loadData.upgrades.astrolabe
		Madeira = SaveFile.loadData.upgrades.Madeira
		canhao = SaveFile.loadData.upgrades.canhao
		vela = SaveFile.loadData.upgrades.vela
		arquitetura_nautica = SaveFile.loadData.upgrades.arquitetura_nautica
