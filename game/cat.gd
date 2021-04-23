extends KinematicBody2D

const SPEED_FACTOR = 100

var _motion = {
	Vector2.LEFT : false,
	Vector2.RIGHT : false,
	Vector2.UP : false,
	Vector2.DOWN : false,
}





# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_area_entered")

func _on_area_entered(area):
	if area.name == "Area_Persone":
		print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = Vector2.ZERO
	for directions in _motion.keys():
		if  _motion[directions]:
			speed += directions * SPEED_FACTOR * delta
	move_and_collide(speed)



func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_action_pressed("move_up"):
			_motion[Vector2.UP] = true
		if event.is_action_pressed("move_down"):
			_motion[Vector2.DOWN] = true
		if event.is_action_pressed("move_left"):
			_motion[Vector2.LEFT] = true
		if event.is_action_pressed("move_right"):
			_motion[Vector2.RIGHT] = true
		if event.is_action_released("move_up"):
			_motion[Vector2.UP] = false
		if event.is_action_released("move_down"):
			_motion[Vector2.DOWN] = false
		if event.is_action_released("move_left"):
			_motion[Vector2.LEFT] = false
		if event.is_action_released("move_right"):
			_motion[Vector2.RIGHT] = false

