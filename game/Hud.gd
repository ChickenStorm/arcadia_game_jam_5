extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const DIALOG = preload("res://game/dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func add_dialogue(text):
	var node = DIALOG.instance()
	node.text = text
	$MarginContainer/VBoxContainer.add_child(node)
