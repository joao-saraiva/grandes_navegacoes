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
		taxesship = {
			
		},
		shipyards = {
			
		},
		upgrades = {
			"compass": false,
			"cartography": false,
			"astrolabe": false,
			"Madeira": 1,
			"canhao": 1,
			"vela": 1,
			"arquitetura_nautica": 1
		},
		locations = {}
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
		taxesship = {
			
		},
		shipyards = {
			
		},
		upgrades = {
			"compass": GlobalVariables.compass,
			"cartography": GlobalVariables.cartography,
			"astrolabe": GlobalVariables.astrolabe,
			"Madeira": GlobalVariables.Madeira,
			"canhao": GlobalVariables.canhao,
			"vela": GlobalVariables.vela,
			"arquitetura_nautica": GlobalVariables.arquitetura_nautica
		},
		locations = Locations.exploration
	}
	
	for node in children:
		if node is KinematicBody2D and node.name != "TaxesShip":
			print(node.name)
			SaveFile.data.ships[node.name] = {
				"position":node.position,
				"movement": node.movement,
				 "speed": node.speed,
				 "resistance": node.resistance,
				 "size": node.size,
				 "navegation_technologies": node.navegation_technologies,
				 "fire_power": node.fire_power,
				 "life": node.life,
				 "arriving": node.arriving,
				 "sailing": node.sailing,
				 "repositioning": node.repositioning,
				 "anchored": node.anchored,
				 "expedition_location": node.expedition_location,
				 "expedition_type": node.expedition_type,
				 "in_expedition": node.in_expedition,
				 "expedition_time": node.expedition_time,
				 "failure_time": node.failure_time
			}
			if node.anchored_area != null:
				SaveFile.data.ships[node.name]["anchored_area"] = node.anchored_area.name
			else:
				SaveFile.data.ships[node.name]["anchored_area"] = null
		elif node is KinematicBody2D and node.name == "TaxesShip":
			SaveFile.data.taxesship = {
				"position": node.position,
				"movement": node.movement,
				"anchored": node.anchored,
				"arriving": node.arriving,
				"sailing": node.sailing,
				"taxes": node.taxes,
				"time_left": node.time_left
			}
			if node.anchored_area != null:
				SaveFile.data.taxesship.anchored_area = node.anchored_area.name
			else:
				SaveFile.data.taxesship.anchored_area = null
		if node is StaticBody2D:
			SaveFile.data.shipyards[node.name] = {"building":node.building, 
												"purchased": node.purchased, 
												"currentBoat": node.currentBoat, 
												"currentFrame": node.currentFrame
												}
		
	print(SaveFile.data.shipyards)
	print(SaveFile.data.ships)
	SaveFile.Save_request()
