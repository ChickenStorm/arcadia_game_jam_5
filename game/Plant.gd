extends Interact

var broken = false

func action():
	if not broken:
		broken = true
		.action()
		$AnimatedSprite.animation = "brocken"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
