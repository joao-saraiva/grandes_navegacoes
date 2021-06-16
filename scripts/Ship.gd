extends KinematicBody2D

var movement = Vector2(0,0)
var speed = 2
var resistance = 1
var size = 2
var navegation_technologies = 1
var fire_power = 1

export var life = 100
var anchorage_areas = []
var anchored_area = null
var anchored = false
var arriving = false
var sailing = false
var repositioning = false
var in_expedition = false
var expedition_location = null
var expedition_type = 0
var lost_in_sea = false
var killed_in_battle = false
var expedition_time = 0
var failure_time = 0
var buy_sell_list = null
var on_commercial_route = false
var battle_rand = 0
var fleet_tech = 0
var fleet_power = 0
var fleet_spd = 0
onready var inventory = {
	"size": size*10,
	items = {
		wine = {"amount": 0, "weight": 3},
		sugar = {"amount": 0, "weight": 1},
		beer = {"amount": 0, "weight": 3},
		Nutmeg = {"amount": 0, "weight": 1},
		BlackPepper = {"amount": 0, "weight": 1},
		clove = {"amount": 0, "weight": 1},
		ginger = {"amount": 0, "weight": 1},
		cloth = {"amount": 0, "weight": 3},
		gold = {"amount": 0, "weight": 5},
		silver = {"amount": 0, "weight": 5}
	}
}
func _ready():
	if in_expedition and failure_time != 0:
		$FailureTimeout.wait_time = failure_time
		$FailureTimeout.start()
	elif in_expedition:
		$ExpeditionTimeout.wait_time = expedition_time
		$ExpeditionTimeout.start()
		
	define_sprite()
	$AnimationPlayer.play("floating")

func _physics_process(delta):
	if arriving:
		dock()
	elif sailing or repositioning:
		if position.x > 1500:
			sailing = false
			movement.x = 0
			if anchored_area != null:
				anchored_area.monitorable = true
			if repositioning:
				arrive()
				repositioning = false
		elif movement.x < speed:
			movement.x += 0.01
	if in_expedition:
		expedition_time = $ExpeditionTimeout.time_left
		failure_time = $FailureTimeout.time_left
	move_and_collide(movement)
	update_animations()

func update_animations():
	if movement.x < 0:
		$Area2D2/CollisionPolygon2D.scale.x = -abs($Area2D2/CollisionPolygon2D.scale.x)
		$Sprite.scale.x = -abs($Sprite.scale.x)
	elif movement.x > 0:
		$Area2D2/CollisionPolygon2D.scale.x = abs($Area2D2/CollisionPolygon2D.scale.x)
		$Sprite.scale.x = abs($Sprite.scale.x)

func sail():
	anchored = false
	sailing = true

func arrive():
	position = Vector2(1450, 384)
	$Area2D.monitoring = true
	$DetectionDelay.start()

func _on_Area2D_area_entered(area):
	if area.name != "TradePoint":
		anchorage_areas.append(area)

func _on_DetectionDelay_timeout():
	$Area2D.monitoring = false
	randomize()
	var random_choice = int(rand_range(0, len(anchorage_areas)))
	
	if len(anchorage_areas) != 0 and anchorage_areas[random_choice].monitorable == true:
		anchorage_areas[random_choice].monitorable = false
		anchored_area = anchorage_areas[random_choice]
		anchorage_areas = []
	
		position.y = anchored_area.position.y
		movement.x = -speed
		arriving = true
	else:
		anchorage_areas = []
		arrive()
		
func reposition():
	anchored = false
	repositioning = true

func dock():
	var distance = position.x - anchored_area.position.x
	if position.x <= anchored_area.position.x:
		movement.x = 0
		arriving = false
		
		if not on_commercial_route:
			expedition_location = null
			expedition_type = 0
			in_expedition = false
			anchored = true
		else:
			if expedition_type == 4:
				store_items()
			elif expedition_type == 5:
				take_items()
			new_expedition(expedition_type, buy_sell_list, expedition_location, battle_rand, fleet_tech, fleet_power, fleet_spd)
	elif movement.x < -0.1 and distance < 500:
		if speed != 1:
			if distance > 300:
				movement.x +=  float(speed)/(1000/(2*speed))
			else:
				movement.x += float(speed)/(5700/(2*speed))
		else:
			movement.x += 0.001
	if arriving and movement.x > -0.1:
		movement.x = -0.1

func define_sprite():
	if size == 1:
		if $Area2D2/CollisionPolygon2D.scale.x < 0:
			$Area2D2/CollisionPolygon2D.scale.x = -0.5
			$Area2D2/CollisionPolygon2D.scale.y = -1
		elif $Area2D2/CollisionPolygon2D.scale.x > 0:
			$Area2D2/CollisionPolygon2D.scale.x = 0.5
			$Area2D2/CollisionPolygon2D.scale.y = 1
		
		if resistance >= 3:
			if fire_power >=3:
				$Sprite.texture = load("res://assets/ships/ship18.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship17.tres")
		else:
			if fire_power >= 3:
				$Sprite.texture = load("res://assets/ships/ship16.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship15.tres")
		
	elif size == 2:
		if $Area2D2/CollisionPolygon2D.scale.x < 0:
			$Area2D2/CollisionPolygon2D.scale.x = -1
			$Area2D2/CollisionPolygon2D.scale.y = -1
		elif $Area2D2/CollisionPolygon2D.scale.x > 0:
			$Area2D2/CollisionPolygon2D.scale.x = 1
			$Area2D2/CollisionPolygon2D.scale.y = 1
		
		if resistance >= 3:
			if fire_power >=3:
				$Sprite.texture = load("res://assets/ships/ship28.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship27.tres")
		else:
			if fire_power >= 3:
				$Sprite.texture = load("res://assets/ships/ship26.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship25.tres")
		
	elif size == 3:
		if $Area2D2/CollisionPolygon2D.scale.x < 0:
			$Area2D2/CollisionPolygon2D.scale.x = -1.2
			$Area2D2/CollisionPolygon2D.scale.y = -1.2
		elif $Area2D2/CollisionPolygon2D.scale.x > 0:
			$Area2D2/CollisionPolygon2D.scale.x = 1.2
			$Area2D2/CollisionPolygon2D.scale.y = 1.2
		
		if resistance >= 3:
			if fire_power >=3:
				$Sprite.texture = load("res://assets/ships/ship38.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship37.tres")
		else:
			if fire_power >= 3:
				$Sprite.texture = load("res://assets/ships/ship36.tres")
			else:
				$Sprite.texture = load("res://assets/ships/ship35.tres")

func new_expedition(type, item_list, location, battle_RNG, fleet_navegation_tech, fleet_fire_power, fleet_speed):
	#   SALVAR TEMPO DOS TIMERS EM ARQUIVO
	in_expedition = true
	if not type == 5:
		location.searching += 1
	expedition_location = location
	expedition_type = type
	battle_rand = battle_RNG
	fleet_tech = fleet_navegation_tech
	fleet_power = fleet_fire_power
	fleet_spd = fleet_speed
	randomize()
	var lost_in_sea_RNG = rand_range(1,location.navegationDifficulty)
	if lost_in_sea_RNG > fleet_navegation_tech*2:
		lost_in_sea = true
		$ExpeditionTimeout.wait_time = location.distance/fleet_speed
		$FailureTimeout.wait_time = location.distance/fleet_speed/2
		$ExpeditionTimeout.start()
		$FailureTimeout.start()
		sail()
		return
	if battle_RNG:
		var damage_RNG = rand_range(1,location.dangerousness*20)/fleet_fire_power
		life -= damage_RNG
		if life <= 0:
			$ExpeditionTimeout.wait_time = location.distance/fleet_speed
			$FailureTimeout.wait_time = location.distance/fleet_speed/2
			$ExpeditionTimeout.start()
			$FailureTimeout.start()
			sail()
			return
	$ExpeditionTimeout.wait_time = location.distance/fleet_speed
	$ExpeditionTimeout.start()
	if expedition_type == 4 or expedition_type == 5:
		on_commercial_route = true
		buy_sell_list = item_list
		if expedition_type == 4:
			$BuyTimeout.wait_time = location.distance/fleet_speed/2
			$BuyTimeout.start()
		if expedition_type == 5:
			take_items()
			$SellTimeout.wait_time = location.distance/fleet_speed/2
			$SellTimeout.start()
	sail()

func _on_ExpeditionTimeout_timeout():
	sailing = false
	arrive()
	if expedition_type == 1:
		expedition_location.found = true
	elif expedition_type == 2:
		expedition_location.colonized = true
	elif expedition_type == 3:
		expedition_location.contract.open = true
	
	if not expedition_type == 5:
		expedition_location.searching -= 1
	if expedition_type < 4:
		expedition_location = null
		expedition_type = 0
		in_expedition = false
	
	failure_time = 0
	expedition_time = 0

func _on_FailureTimeout_timeout():
	$ExpeditionTimeout.stop()
	expedition_location.searching -= 1
	GlobalVariables.totalShips -= 1
	in_expedition = false
	failure_time = 0
	expedition_type = 0
	expedition_time = 0
	queue_free()

func _on_BuyTimeout_timeout():
	if expedition_type == 4:
		for item in buy_sell_list:
			if GlobalVariables.coins - (buy_sell_list[item] * Locations.exploration.india.price[item]) >= 0:
				GlobalVariables.coins -= buy_sell_list[item] * Locations.exploration.india.price[item]
				inventory.items[item].amount = buy_sell_list[item]
	print(inventory.items)

func remove_items():
	inventory.items = {
		wine = {"amount": 0, "weight": 3},
		sugar = {"amount": 0, "weight": 1},
		beer = {"amount": 0, "weight": 3},
		Nutmeg = {"amount": 0, "weight": 1},
		BlackPepper = {"amount": 0, "weight": 1},
		clove = {"amount": 0, "weight": 1},
		ginger = {"amount": 0, "weight": 1},
		cloth = {"amount": 0, "weight": 3},
		gold = {"amount": 0, "weight": 5},
		silver = {"amount": 0, "weight": 5}
	}

func store_items():
	var totalshipweight = 0
	for item in inventory.items:
		totalshipweight += inventory.items[item].amount * inventory.items[item].weight
	var totalportweight
	for item in SaveFile.loadData.inventory:
		totalportweight = SaveFile.loadData.inventory[item].amount * SaveFile.loadData.inventory[item].weight
		
	if totalportweight + totalshipweight > SaveFile.loadData.inventorySize:
		store_items()
	else:
		for item in inventory.items:
			SaveFile.loadData.inventory[item].amount += inventory.items[item].amount
		remove_items()
		
func empty():
	return inventory.items == {
		wine = {"amount": 0, "weight": 3},
		sugar = {"amount": 0, "weight": 1},
		beer = {"amount": 0, "weight": 3},
		Nutmeg = {"amount": 0, "weight": 1},
		BlackPepper = {"amount": 0, "weight": 1},
		clove = {"amount": 0, "weight": 1},
		ginger = {"amount": 0, "weight": 1},
		cloth = {"amount": 0, "weight": 3},
		gold = {"amount": 0, "weight": 5},
		silver = {"amount": 0, "weight": 5}
	}

func take_items():
	for item in buy_sell_list:
		if SaveFile.loadData.inventory[item].amount - buy_sell_list[item] < 0:
			inventory.items[item].amount = SaveFile.loadData.inventory[item].amount
			SaveFile.loadData.inventory[item].amount = 0
		else:
			inventory.items[item].amount = buy_sell_list[item]
			SaveFile.loadData.inventory[item].amount -= buy_sell_list[item]

func _on_SellTimeout_timeout():
	for item in inventory.items:
		GlobalVariables.coins += inventory.items[item].amount * expedition_location.price[item]
	empty()
