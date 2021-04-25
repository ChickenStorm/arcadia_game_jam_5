extends IteractionText

signal win_game()

func _ready():
	$Timer.connect("timeout", self, "_on_win_game")

func action():
	.action()
	$Timer.start()

func _on_win_game():
	emit_signal("win_game")
