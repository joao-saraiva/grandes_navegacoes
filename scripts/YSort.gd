extends YSort

func _on_HUD_salvar():
	save()

func _on_TestButton4_pressed():		#test function
	SaveFile.data = {
		"coins" : 0,
		"totalShips" : 0,
		inventory = {
			"wine": 0
		},
		ships = {
			
		},
		shipyards = {
			
		},
		upgrades = {
			"compass": false,
			"cartography": false,
			"astrolabe": false,
		}
	}
	SaveFile.Save_request()


func save():
	var children = get_children()
	SaveFile.data = {
		"coins" : GlobalVariables.coins,
		"totalShips" : GlobalVariables.totalShips,
		inventory = {
			"wine": GlobalVariables.wineCount
		},
		ships = {
			
		},
		shipyards = {
			
		},
		upgrades = {
			"compass": GlobalVariables.compass,
			"cartography": GlobalVariables.cartography,
			"astrolabe": GlobalVariables.astrolabe,
		}
	}
	
	for node in children:
		if node is KinematicBody2D:
			SaveFile.data.ships[node.name] = {"position":node.position,
											"movement": node.movement,
											 "speed": node.speed,
											 "resistance": node.resistance,
											 "size": node.size,
											 "navegation_technologies": node.navegation_technologies,
											 "fire_power": node.fire_power,
											 "life": node.life,
											 "arriving": node.arriving,
											 "sailing": node.sailing,
											 "repositioning": node.repositioning}
			if node.anchored_area != null:
				SaveFile.data.ships[node.name]["anchored_area"] = node.anchored_area.name
			else:
				SaveFile.data.ships[node.name]["anchored_area"] = null
		if node is StaticBody2D:
			SaveFile.data.shipyards[node.name] = {"building":node.building, 
												"purchased": node.purchased, 
												"currentBoat": node.currentBoat, 
												"currentFrame": node.currentFrame}
	print(SaveFile.data.shipyards)
	SaveFile.Save_request()
