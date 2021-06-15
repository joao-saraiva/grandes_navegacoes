extends YSort

func _on_HUD_salvar():
	save()

func _on_TestButton4_pressed():		#test function
	SaveFile.data = {
		"coins" : 0,
		"totalShips" : 0,
		"inventorySize": 100,
		inventory = {
			wine = {"amout": 0, "weight": 3},
			sugar = {"amout": 0, "weight": 1},
			beer = {"amout": 0, "weight": 3},
			Nutmeg = {"amout": 0, "weight": 1},
			BlackPepper = {"amout": 0, "weight": 1},
			clove = {"amout": 0, "weight": 1},
			ginger = {"amout": 0, "weight": 1},
			cloth = {"amount": 0, "weigth": 3},
			gold = {"amout": 0, "weight": 5},
			silver = {"amout": 0, "weight": 5}
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
		"inventorySize": 100,
		inventory = {
			wine = {"amount": GlobalVariables.wineAmount, "weight": 3},
			sugar = {"amount":GlobalVariables.sugarAmount, "weight": 1},
			beer = {"amount": GlobalVariables.beerAmount, "weight": 3},
			Nutmeg = {"amount": GlobalVariables.NutmegAmount, "weight": 1},
			BlackPepper = {"amount": GlobalVariables.BlackPepperAmount, "weight": 1},
			clove = {"amount": GlobalVariables.cloveAmount, "weight": 1},
			ginger = {"amount": GlobalVariables.gingerAmount, "weight": 1},
			cloth = {"amount": GlobalVariables.clothAmount, "weight": 3},
			gold = {"amount": GlobalVariables.goldAmount, "weight": 5},
			silver = {"amount": GlobalVariables.silverAmount, "weight": 5}
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
		if node is KinematicBody2D and node.name != "TaxesShip" and node.name != "MuslimShip":
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
				 "failure_time": node.failure_time,
				"inventory": node.inventory,
				"buy_list": node.buy_list,
				"on_comertial_route": node.on_comertial_route,
				"battle_rand":node.battle_rand,
				"fleet_tech": node.fleet_tech,
				"fleet_power": node.fleet_power,
				"fleet_spd": node.fleet_spd
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
