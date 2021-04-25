extends IteractionText


var has_interacted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func action():
	if not has_interacted:
		has_interacted = true
		.action()
		$SpriteFirst.visible = false
		$SpriteThen.visible = true
		$AudioStreamPlayer2D.play()
