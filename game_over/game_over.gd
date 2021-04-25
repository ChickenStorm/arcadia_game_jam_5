extends Control

signal scene_requested(scene)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Button.connect("pressed", self, "_on_back_to_main_menu")
	Audio.set_requested_music("defaite")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_back_to_main_menu():
	emit_signal("scene_requested", "menu")
