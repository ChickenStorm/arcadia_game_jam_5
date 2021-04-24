extends Node2D

var can_interact = false
signal interaction_dialogue(string)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interact.connect("area_entered", self, "_on_area_entered")
	$Interact.connect("area_exited", self, "_on_area_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if can_interact and event.is_action_pressed("interact"):
			emit_signal("interaction_dialogue", "ceci est un objet")
		

func _on_area_entered(area):
	can_interact = true
	$PanelContainer2.visible = true

func _on_area_exited(area):
	can_interact = false
	$PanelContainer2.visible = false
