extends KinematicBody2D

var cat = null setget set_cat

const SPEED_FACTOR = 20

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ray = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray != null and cat != null:
		ray.cast_to = cat.position - self.position
		if not ray.is_colliding():
			var direction = (cat.position - self.position).normalized()
			move_and_collide(direction * delta * SPEED_FACTOR)


func set_cat(cat_var):
	cat = cat_var
	ray.cast_to = cat.position
