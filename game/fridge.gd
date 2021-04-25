extends IteractionText

var has_activated = false

# Declare member variables here. Example
func action():
	if not has_activated:
		has_activated = true
		.action()
		$SpriteFirst.visible = false
		$SpriteThen.visible = true
		$AudioStreamPlayer2D.play()
