extends Node

var fleet = []
var buy_fleet_list = []
var sell_fleet_list = []
var fleet_speed
var fleet_navegation_tech
var fleet_fire_power
var selected_location = null

func _ready():
	if SaveFile.loadData == null:
		return
	buy_fleet_list = SaveFile.loadData.buy_fleet_list
	sell_fleet_list = SaveFile.loadData.sell_fleet_list

func remove_ship(ship):
	fleet.erase(ship)

func add_ship(ship):
	if not ship.anchored and not ship.empty():
		return
	fleet.append(ship)

func calculate_fleet_atributes():
	if len(fleet) == 0:
		return
	
	fleet_speed = 60
	fleet_navegation_tech = 1
	fleet_fire_power = 0
	
	for ship in fleet:
		if ship.speed < fleet_speed:
			fleet_speed = ship.speed
		fleet_fire_power += ship.fire_power
		if ship.navegation_technologies > fleet_navegation_tech:
			fleet_navegation_tech = ship.navegation_technologies
	
	fleet_navegation_tech += len(fleet)-1

func exploration_expedition():
	if len(fleet) == 0:
		fleet = []
		selected_location = null
		return -1
	
	calculate_fleet_atributes()
	
	var location = null
	var local_name
	var found_locations = 0
	var searching_locations = 0
	for local in Locations.exploration:
		if float(fleet_navegation_tech*2)/Locations.exploration[local].navegationDifficulty >= 0.2 and not Locations.exploration[local].found and Locations.exploration[local].searching == 0:
			location = Locations.exploration[local]
			local_name = local
			print(float(fleet_navegation_tech*2)/Locations.exploration[local].navegationDifficulty)
			break
		elif Locations.exploration[local].found:
			found_locations += 1
		elif Locations.exploration[local].searching:
			searching_locations += 1
	
	if location == null:
		fleet = []
		if found_locations == 6:
			fleet = []
			selected_location = null
			return -4
		if searching_locations > 0:
			fleet = []
			selected_location = null
			return -3
		return -2
	
	var battle_RNG = rand_range(1,location.dangerousness)
	if battle_RNG > 10:
		battle_RNG = true
	else:
		battle_RNG = false
	print(local_name, location)
	print("len(fleet): ", len(fleet), "    fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(1, null, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []

func colonization_expedition():
	if len(fleet) == 0:
		fleet = []
		selected_location = null
		return -1
	
	calculate_fleet_atributes()
	
	var location = Locations.exploration[selected_location]
	
	if float(fleet_navegation_tech*2)/location.navegationDifficulty < 0.2:
		fleet = []
		selected_location = null
		print(-2)
		return -2
	if not location.found:
		fleet = []
		selected_location = null
		print(-3)
		return -3
	if location.colonized:
		print(-4)
		fleet = []
		selected_location = null
		return -4
	if location.searching > 0:
		fleet = []
		selected_location = null
		print(-5)
		return -5
	
	var battle_RNG = rand_range(1,location.dangerousness)
	if battle_RNG > 10:
		battle_RNG = true
	else:
		battle_RNG = false
	print(selected_location, location)
	print("len(fleet): ", len(fleet), "    fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(2, null, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []
	selected_location = null

func contract_expedition(local, contract = null):
	if len(fleet) == 0:
		print(-1)
		return -1
	
	var location
	if local == "india" and Locations.exploration.india.found == true and contract == null:
		if Locations.exploration.india.contract.open or Locations.exploration.india.contract == contract:
			fleet = []
			selected_location = null
			print(-7)
			return -7
		location = Locations.exploration.india
	elif local == "muslims" and contract != null:
		if Locations.muslims.contract == contract:
			fleet = []
			selected_location = null
			print(-7)
			return -7
		location = Locations.muslims
		location.contract = contract
		location.contract.open = !location.contract.open
	else:
		fleet = []
		selected_location = null
		print(-6)
		return -6
	
	calculate_fleet_atributes()
	
	if float(fleet_navegation_tech*2)/location.navegationDifficulty < 0.2:
		fleet = []
		selected_location = null
		print(-2)
		return -2
	if location.searching > 0:
		fleet = []
		selected_location = null
		print(-5)
		return -5
	
	var battle_RNG = rand_range(1,location.dangerousness/3)
	if battle_RNG > 25:
		battle_RNG = true
	else:
		battle_RNG = false
	print(selected_location, location)
	print("len(fleet): ", len(fleet), "    fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(3, null, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []
	selected_location = null

func buy_expedition(buy_list = null):
	if len(fleet) == 0:
		print(-1)
		return -1
	
	var location = Locations.exploration.india
	if location.found == false or location.contract.open == false or buy_list == null:
		fleet = []
		selected_location = null
		print(-6)
		return -6
	
	var totalweight = 0
	for item in buy_list:
		totalweight += buy_list[item] * fleet[0].inventory.items[item].weight
	for ship in fleet:
		if totalweight > ship.inventory.size:
			fleet = []
			selected_location = null
			print(totalweight)
			print(ship.inventory.size)
			return -7
	
	calculate_fleet_atributes()
	
	if float(fleet_navegation_tech*2)/location.navegationDifficulty < 0.2:
		fleet = []
		selected_location = null
		print(-2)
		return -2
	if not location.found:
		fleet = []
		selected_location = null
		print(-3)
		return -3
		
	buy_fleet_list.append(fleet)
	
	var battle_RNG = rand_range(1,location.dangerousness/6)
	if battle_RNG > 25:
		battle_RNG = true
	else:
		battle_RNG = false
	print(selected_location, location)
	print("len(fleet): ", len(fleet), "    fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(4, buy_list, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []
	selected_location = null

func sell_expedition(local, sell_list):
	if len(fleet) == 0:
		print(-1)
		return -1
	
	var location = Locations[local]
	if sell_list == null or (local != "spain" and local != "france" and local != "portugal" and local != "italy"):
		fleet = []
		selected_location = null
		print(-6)
		return -6
		
	var totalweight = 0
	for item in sell_list:
		totalweight += sell_list[item] * fleet[0].inventory.items[item].weight
	for ship in fleet:
		if totalweight > ship.inventory.size:
			fleet = []
			selected_location = null
			print(totalweight)
			print(ship.inventory.size)
			return -7
	
	calculate_fleet_atributes()
	
	if float(fleet_navegation_tech*2)/location.navegationDifficulty < 0.2:
		fleet = []
		selected_location = null
		print(-2)
		return -2
	
	sell_fleet_list.append(fleet)
	
	var battle_RNG = rand_range(1,location.dangerousness)
	if battle_RNG > 25:
		battle_RNG = true
	else:
		battle_RNG = false
	print(selected_location, location)
	print("len(fleet): ", len(fleet), "    fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(5, sell_list, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []
	selected_location = null

func remove_buy_expedition(index):
	print(buy_fleet_list)
	for ship in buy_fleet_list[index]:
		ship.on_commercial_route = false
	buy_fleet_list.erase(buy_fleet_list[index])
	print(buy_fleet_list)

func remove_sell_expedition(index):
	print(sell_fleet_list)
	for ship in sell_fleet_list[index]:
		ship.on_commercial_route = false
	sell_fleet_list.erase(sell_fleet_list[index])
	print(sell_fleet_list)

func _on_Button_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	exploration_expedition()

func _on_Button2_pressed():
	for local in Locations.exploration:
		if Locations.exploration[local].found == true and Locations.exploration[local].colonized == false:
			selected_location = local
			break;
	if selected_location == null:
		print("não a locais para colonizar")
		selected_location = null
		return
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	colonization_expedition()

func _on_Button3_pressed():
	print(Locations.muslims)
	print(Locations.exploration)

func _on_Button4_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	contract_expedition("muslims", {
		"open": false,
		"wine": 2,
		"sugar": 0 ,
		"beer": 2,
		"gold": 2,
		"silver": 0
	})

func _on_Button5_pressed():
	print("pressed")
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	contract_expedition("india")

func _on_Button6_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	buy_expedition({
		"wine": 2,
		"sugar": 0 ,
		"beer": 2,
		"gold": 2,
		"silver": 0
	})


func _on_Button7_pressed():
	print(SaveFile.loadData.inventory)


func _on_Button8_pressed():
	if len(buy_fleet_list)-1 >= 0:
		remove_buy_expedition(len(buy_fleet_list)-1)
	else:
		print("não existe barcos atribuidos para compra")


func _on_Button9_pressed():
	if len(sell_fleet_list)-1 >= 0:
		remove_sell_expedition(len(sell_fleet_list)-1)
	else:
		print("não existe barcos atribuidos para venda")


func _on_Button10_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D and ship.name != "TaxesShip":
			add_ship(ship)
	sell_expedition("italy", {
		"wine": 2,
		"sugar": 0 ,
		"beer": 2,
		"gold": 2,
		"silver": 0
	})
