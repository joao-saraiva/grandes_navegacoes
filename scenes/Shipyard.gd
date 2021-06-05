extends Node2D

onready var ship = preload("res://scenes/Ship.tscn")
#variaveis para salvar em arquivo\/
onready var building = false
onready var currentBoat = []
onready var currentFrame = 0

export var speed = 1
export var resistance = 1
export var size = 1
export var navegation_technologies = 1
export var fire_power = 1
export var improvement = false
export var boat = [1,1]

func _ready():
	if building:
		buildShip(currentBoat[0],currentBoat[1],currentBoat[2],currentBoat[3],currentBoat[4],currentBoat[5],currentBoat[6])
	buildShip(speed, resistance, size, navegation_technologies, fire_power, improvement, boat)#linha de teste

func _physics_process(delta):
	if building:
		currentFrame = $Ship.frame
	if currentFrame == 7 and $Releasing.is_stopped():
		release()

func buildShip(speed, resistance, size, navegation_technologies, fire_power, improvement = false, boat = [1,1]):
	var resistance_animation = "0"
	var fire_power_animation = "0"
	var upgrade_sequence = ""
	building = true
	currentBoat = [speed, resistance, size, navegation_technologies, fire_power, improvement, boat]
	#define a orderm da animação do ultimo upgrade visual
	if boat[0] < 3 and resistance >= 3 and boat[1] >= 3:
		upgrade_sequence = "0"
	elif boat[1] < 3 and fire_power >= 3 and boat[0] >= 3:
		upgrade_sequence = "1"
	#defina a animação correta para o barco em questão
	if resistance >= 3:
		resistance_animation = "1"
	if fire_power >= 3:
		fire_power_animation = "1"
	if not improvement and resistance >= 3 and fire_power >= 3:
		upgrade_sequence = "0"
	
	$Ship.play("build" + str(size) + resistance_animation + fire_power_animation + upgrade_sequence)
	
	if currentFrame == 0:
		#define o frame correto da animação para caso de aprimoração
		if improvement and (boat[0] >= 3 or boat[1] >= 3):
			$Ship.frame = 5
		elif improvement:
			$Ship.frame = 4
	else:
		#define o frame correto que estava a animação caso o jogo for fechado
		$Ship.frame = currentFrame
	
	$AnimationPlayer.play("building")
	$Cranes.play("building")

func release():
	$AnimationPlayer.play("ready")
	$Cranes.playing = false
	$Releasing.start()

func _on_Releasing_timeout():
	$Ship.play("empty")
	var new_ship = ship.instance()
	new_ship.speed = currentBoat[0]
	new_ship.resistance = currentBoat[1]
	new_ship.size = currentBoat[2]
	new_ship.navegation_technologies = currentBoat[3]
	new_ship.fire_power = currentBoat[4]
	new_ship.position = Vector2(position.x+1,position.y+42)
	new_ship.define_sprite()
	get_parent().add_child(new_ship)
	new_ship.reposition()
	building = false
	currentBoat = []
	currentFrame = 0
