extends Interact

var turned_on = false

func action():
	if not turned_on:
		turned_on = true
		.action()
		$Sprite.visible = true
		$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
