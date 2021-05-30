extends KinematicBody2D

var movement = Vector2(0,0)
export var speed = 2
export var life = 100
export var navegation_technologies = 1
export var fire_power = 1

var anchorage_areas = []
var anchored_area = null
var arriving = false
var sailing = false
var timer = false

func _ready():
	$AnimationPlayer.play("floating")
	arrive()#teste

func _physics_process(delta):
	if arriving:
		dock()
	elif sailing:
		if position.x > 1500:
			sailing = false
			movement.x = 0
			anchored_area.monitorable = true
			arrive()#teste
		elif movement.x < speed:
			movement.x += 0.01
	
	move_and_collide(movement)
	update_animations()

func update_animations():
	if movement.x < 0:
		$CollisionShape2D.scale.x = -1
		$Sprite.scale.x = -1
	elif movement.x > 0:
		$CollisionShape2D.scale.x = 1
		$Sprite.scale.x = 1

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

func dock():
	var distance = position.x - anchored_area.get_children()[0].position.x
	if position.x <= anchored_area.get_children()[0].position.x:
		movement.x = 0
		arriving = false
		sail()#teste
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
