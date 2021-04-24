extends Node2D

signal scene_requested(scene)

onready var cat = $Cat
onready var persone = $Persone
onready var nav_ploy = $NavigationPolygonInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	persone.cat = cat
	nav_ploy.navpoly.make_polygons_from_outlines()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _unhandled_input(event):
	pass
