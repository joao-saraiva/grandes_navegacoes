extends Sprite

func _physics_process(delta):
	randomize()
	var a = rand_range(0.5, 4)
	position.x+=a
