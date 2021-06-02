extends Node2D
var rand = 0

func _ready():
	#script para teste de animação
	randomize()
	rand = int(rand_range(0,800))

func _physics_process(delta):
	#script para teste de animação
	if rand > 800:
		if $AnimationPlayer.current_animation == "building" and $Ship.animation == "build" and $Ship.frame == 4:
			$AnimationPlayer.play("ready")
			$Cranes.frame = 0
			$Cranes.playing = false
		elif $AnimationPlayer.current_animation == "":
			$AnimationPlayer.play("building")
			$Ship.frame = 0
			$Ship.play("build")
			$Cranes.playing = true
	rand+=1
