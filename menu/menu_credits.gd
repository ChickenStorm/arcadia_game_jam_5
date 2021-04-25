extends Control

signal scene_requested(scene)


func _ready():
	$Forground/CenterH/CenterV/CreditsContainer/BackMainMenu.connect("pressed", self, "_on_back_to_main_menu")
	# apparently it does not load directly in scene
	$Forground/CenterH/CenterV/CreditsContainer/BackMainMenu.grab_focus()


func _on_back_to_main_menu():
	emit_signal("scene_requested", "menu")


func _on_link_button_press(url):
	OS.shell_open(url)


func _unhandled_input(event):
	if event.is_action("ui_down") or event.is_action("ui_up"):
		print("test 2")
		Audio.play_click()
	if event.is_action_pressed("ui_accept"):
		Audio.play_click_accepte()
