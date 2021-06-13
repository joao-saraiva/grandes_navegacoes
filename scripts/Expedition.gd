extends Node

var fleet = []
var fleet_speed
var fleet_navegation_tech
var fleet_fire_power
var selected_location = null

func remove_ship(ship):
	fleet.erase(ship)

func add_ship(ship):
	if not ship.anchored:
		return
	fleet.append(ship)

func calculate_fleet_atributes():
	if len(fleet) == 0:
		return
	
	fleet_speed = 5
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
			return -4
		if searching_locations > 0:
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
		ship.new_expedition(1, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []

func colonization_expedition():
	if len(fleet) == 0:
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
		ship.new_expedition(2, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []
	selected_location = null

func _on_Button_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D:
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
		if ship is KinematicBody2D:
			add_ship(ship)
	colonization_expedition()

func _on_Button3_pressed():
	print(Locations.exploration)
