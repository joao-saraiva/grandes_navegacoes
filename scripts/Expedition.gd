extends Node

var fleet = []
var fleet_speed
var fleet_navegation_tech
var fleet_fire_power

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
	
	var possible_location = []
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
	
	print(local_name, location)
	print("fleet_navegation_tech: ", fleet_navegation_tech,"   fleet_fire_power: ", fleet_fire_power,"   fleet_speed: ", fleet_speed)
	for ship in fleet:
		ship.new_expedition(location, fleet_navegation_tech, fleet_fire_power, fleet_speed)
	fleet = []

func _on_Button_pressed():
	for ship in get_parent().get_node("YSort").get_children():
		if ship is KinematicBody2D:
			add_ship(ship)
	exploration_expedition()
