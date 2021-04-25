extends Control

signal scene_requested(scene)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Button.grab_focus()
	$MarginContainer/VBoxContainer/Button.connect("pressed", self, "_on_back_to_main_menu")
	$MarginContainer/VBoxContainer/Button2.connect("pressed", self, "_on_replay")
	Audio.set_requested_music("defaite")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_back_to_main_menu():
	emit_signal("scene_requested", "menu")


func _on_replay():
	emit_signal("scene_requested", "game")


func _unhandled_input(event):
	if event.is_action("ui_down") or event.is_action("ui_up"):
		print("test 2")
		Audio.play_click()
	if event.is_action_pressed("ui_accept"):
		Audio.play_click_accepte()
