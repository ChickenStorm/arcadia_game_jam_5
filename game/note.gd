extends IteractionText

var has_interacted = false
	
func action():
	if not has_interacted:
		has_interacted = true
		.action()
		$AudioStreamPlayer2D.play()
