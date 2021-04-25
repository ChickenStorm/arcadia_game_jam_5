extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var nav_poly = $"../NavigationPolygonInstance"
onready var poly = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var poly = poly.polygon
	var poly_translated = PoolVector2Array([])
	for pt in poly:
		poly_translated.append(pt + self.position)
	nav_poly.navpoly.add_outline(poly_translated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
