extends Control

signal scene_requested(scene)



func _ready():
	$GUI/Node2D/Menu/LobbyCreationButton.grab_focus()
	$GUI/Node2D/Menu/LobbyCreationButton.connect("pressed", self, "_on_press_play")
	$GUI/Node2D/Menu/OptionButton.connect("pressed", self, "_on_menu_option_pressed")
	$GUI/Node2D/Menu/CreditsButton.connect("pressed", self, "_on_menu_credits_pressed")
	$GUI/Node2D2/Quit.connect("pressed", self, "_quit_game")


func _unhandled_input(event):
	if event.is_action("ui_down") or event.is_action("ui_up"):
		print("test 2")
		Audio.play_click()
	if event.is_action_pressed("ui_accept"):
		Audio.play_click_accepte()

func _quit_game():
	get_tree().quit()


func _on_menu_option_pressed():
	emit_signal("scene_requested", "option_menu")


func _on_menu_credits_pressed():
	emit_signal("scene_requested", "credits_menu")


func _on_press_play():
	emit_signal("scene_requested", "intro")
