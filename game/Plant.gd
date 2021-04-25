class_name Plant
extends Interact

signal noise_plant()

var broken = false

func action():
	if not broken:
		broken = true
		#.action()
		emit_signal("interaction_dialogue", text)
		emit_signal("noise_plant")
		$AnimatedSprite.animation = "brocken"
		$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
