extends Node2D

signal scene_requested(scene)

# warning-ignore-all:return_value_discarded

onready var cat = $Cat
onready var persone = $Persone
onready var nav_ploy = $NavigationPolygonInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	persone.cat = cat
	#nav_ploy.navpoly.make_polygons_from_outlines()
	cat.connect("interaction_entered", self, "_on_interaction_entered")
	cat.connect("interaction_exited", self, "_on_interaction_exited")
	#$Camera2D.make_current()
	persone.connect("touched", self, "_on_touched")
	$InteractibleText.connect("interaction_dialogue", self, "_on_interaction_dialogue")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$Camera2D.position = cat.position


func _unhandled_input(event):
	pass


func _on_interaction_entered():
	pass
	#$CanvasLayer/Hud/MarginContainer/VBoxContainer/PanelContainer.visible = true


func _on_interaction_exited():
	pass
	#$CanvasLayer/Hud/MarginContainer/VBoxContainer/PanelContainer.visible = false

func _on_touched():
	emit_signal("scene_requested", "game_over")


func _on_interaction_dialogue(string):
	$CanvasLayer/Hud.add_dialogue(string)
