extends KinematicBody2D

signal interaction_entered()
signal interaction_exited()

const SPEED_FACTOR = 150

var _motion = {
	Vector2.LEFT : false,
	Vector2.RIGHT : false,
	Vector2.UP : false,
	Vector2.DOWN : false,
}

onready var noise = $Noise



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Interact.connect("body_entered", self, "_on_area_entered")
	$Interact.connect("area_entered", self, "_on_interaction_entered")
	$Interact.connect("area_exited", self, "_on_interaction_exit")

func _on_area_entered(area):
	if area.name == "Area_Persone":
		print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = Vector2.ZERO
	for directions in _motion.keys():
		if  _motion[directions]:
			speed += directions * SPEED_FACTOR * delta
	var vec_or = Vector2.UP.rotated(self.rotation)
	if speed != Vector2.ZERO:
		self.rotate(vec_or.angle_to(speed))
		$sprite.playing = true
	else:
		$sprite.playing = false
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
		#if event.is_action_released("action_meow"):
		# 	action_meow()

func action_meow():
	noise.action_noise()
	


func _on_interaction_entered(area):
	emit_signal("interaction_entered")

func _on_interaction_exit(area):
	emit_signal("interaction_exited")
