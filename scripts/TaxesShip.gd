extends KinematicBody2D

var movement = Vector2(0,0)
var speed = 2

var anchored_area = null
var anchored = false
var arriving = false
var sailing = false
var taxes = 100

onready var timer_ref = get_parent().get_parent().get_node("TaxesTimer")
onready var time_left = timer_ref.wait_time

func _ready():
	check_load()
	if position.x > 1500:
		timer_ref.wait_time = time_left
		timer_ref.start()
	define_sprite()
	$AnimationPlayer.play("floating")

func _physics_process(delta):
	time_left = timer_ref.time_left
	if arriving:
		dock()
	elif sailing:
		if position.x > 1500:
			sailing = false
			movement.x = 0
			if anchored_area != null:
				anchored_area.monitorable = true
				anchored_area = null
			timer_ref.start()
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
	anchored = false
	sailing = true

func arrive():
	position = Vector2(1450, 384)
	$Area2D.monitoring = true
	$DetectionDelay.start()

func _on_Area2D_area_entered(area):
	if area.name == "TradePoint":
		anchored_area = area

func _on_DetectionDelay_timeout():
	$Area2D.monitoring = false
	
	if anchored_area.monitorable == true:
		anchored_area.monitorable = false
		
		position.y = anchored_area.position.y
		movement.x = -speed
		arriving = true
	else:
		arrive()
		

func dock():
	var distance = position.x - anchored_area.position.x
	if position.x <= anchored_area.position.x:
		movement.x = 0
		arriving = false
		anchored = true
		GlobalVariables.coins += taxes
		sail()
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
	$Sprite.texture = load("res://assets/ships/ship35.tres")

func _on_TaxesTimer_timeout():
	arrive()

func check_load():
	if not SaveFile.loadData.taxesship.empty():
		position = SaveFile.loadData.taxesship.position
		movement = SaveFile.loadData.taxesship.movement
		
		anchored = SaveFile.loadData.taxesship.anchored
		arriving = SaveFile.loadData.taxesship.arriving
		sailing = SaveFile.loadData.taxesship.sailing
		taxes = SaveFile.loadData.taxesship.taxes
		time_left = SaveFile.loadData.taxesship.time_left
		if SaveFile.loadData.taxesship.anchored_area != null:
			anchored_area = get_parent().get_parent().get_node(SaveFile.loadData.taxesship.anchored_area)
			anchored_area.monitorable = false
		else:
			anchored_area = null
