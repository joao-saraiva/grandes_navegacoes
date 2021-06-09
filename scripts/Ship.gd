extends KinematicBody2D

var movement = Vector2(0,0)
export var speed = 2
export var resistance = 1
export var size = 2
export var navegation_technologies = 1
export var fire_power = 1

export var life = 100
var anchorage_areas = []
var anchored_area = null
var arriving = false
var sailing = false
var timer = false
var repositioning = false

func _ready():
	define_sprite()
	$AnimationPlayer.play("floating")
	reposition()#linha de teste

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
	sailing = true

func arrive():
	position = Vector2(1450, 384)
	$Area2D.monitoring = true
	$DetectionDelay.start()

func _on_Area2D_area_entered(area):
	anchorage_areas.append(area)

func _on_DetectionDelay_timeout():
	$Area2D.monitoring = false
	randomize()
	var random_choice = int(rand_range(0, len(anchorage_areas)))
	
	if len(anchorage_areas) != 0 and anchorage_areas[random_choice].monitorable == true:
		anchorage_areas[random_choice].monitorable = false
		anchored_area = anchorage_areas[random_choice]
		anchorage_areas = []
	
		position.y = anchored_area.get_children()[0].position.y
		movement.x = -speed
		arriving = true
	else:
		anchorage_areas = []
		arrive()
		
func reposition():
	repositioning = true

func dock():
	var distance = position.x - anchored_area.get_children()[0].position.x
	if position.x <= anchored_area.get_children()[0].position.x:
		movement.x = 0
		arriving = false
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
