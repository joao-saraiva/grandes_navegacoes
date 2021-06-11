extends Node2D
onready var ship_tscn = preload("res://scenes/Ship.tscn")
func _ready():
	get_node("YSort").save()
	if SaveFile.loadData == null:
		return
	
	for ship in SaveFile.loadData.ships:
		var loadShip = ship_tscn.instance()
		loadShip.speed = SaveFile.loadData.ships[ship].speed
		loadShip.resistance = SaveFile.loadData.ships[ship].resistance
		loadShip.size = SaveFile.loadData.ships[ship].size
		loadShip.navegation_technologies = SaveFile.loadData.ships[ship].navegation_technologies
		loadShip.fire_power = SaveFile.loadData.ships[ship].fire_power
		loadShip.position = SaveFile.loadData.ships[ship].position
		loadShip.movement = SaveFile.loadData.ships[ship].movement
		loadShip.life = SaveFile.loadData.ships[ship].life
		if SaveFile.loadData.ships[ship].anchored_area != null:
			loadShip.anchored_area = get_node(SaveFile.loadData.ships[ship].anchored_area)
			loadShip.anchored_area.monitorable = false
		else:
			loadShip.anchored_area = null
		loadShip.arriving = SaveFile.loadData.ships[ship].arriving
		loadShip.sailing = SaveFile.loadData.ships[ship].sailing
		loadShip.repositioning = SaveFile.loadData.ships[ship].repositioning
		loadShip.define_sprite()
		get_node("YSort").add_child(loadShip)


func _on_TestButton3_pressed():			#teste
	GlobalVariables.coins += 100		#teste
