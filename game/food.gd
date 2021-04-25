extends IteractionText

signal win_game()

var has_activate = false

func _ready():
	$Timer.connect("timeout", self, "_on_win_game")

func action():
	if not has_activate:
		has_activate = true
		#.action()
		$Timer.start()
		$AudioStreamPlayer.play()

func _on_win_game():
	emit_signal("win_game")
