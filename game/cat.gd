extends KinematicBody2D

# warning-ignore-all:return_value_discarded

signal interaction_entered()
signal interaction_exited()
signal piss(zone_id)

const SPEED_FACTOR = 150
const SPEED_AFTER_MEOW = 100
const MEOW_CD = 2
const PISS_CD = 20
const ACCELERATION = 300

var speed = 0

var time_meow = 0
var time_piss = 0

var zone = 0

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
	$InteractZone.connect("area_entered", self, "_on_area_entered_zone")


func _on_area_entered_zone(area):
	if area is Zone:
		zone = area.zone_id


func _on_area_entered(area):
	if area.name == "Area_Persone":
		print("test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_meow -= delta
	time_piss -= delta
	var speed_dir = Vector2.ZERO
	speed = min(speed + delta * ACCELERATION, SPEED_FACTOR if time_meow <= 0 else SPEED_AFTER_MEOW)
	for directions in _motion.keys():
		if  _motion[directions]:
			speed_dir += directions * speed * delta
	var vec_or = Vector2.UP.rotated(self.rotation)
	if speed_dir != Vector2.ZERO:
		self.rotate(vec_or.angle_to(speed_dir))
		$sprite.playing = true
		if not $StepSound.playing:
			$StepSound.playing = true
	else:
		speed = 0
		if $StepSound.playing:
			$StepSound.playing = false
		$sprite.playing = false
	move_and_collide(speed_dir)



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
		if event.is_action_pressed("action_meow"):
			action_meow()
		if event.is_action_pressed("piss"):
			action_piss()


func action_meow():
	print("MEOW !!!")
	if time_meow <= 0:
		noise.action_noise()
		time_meow = MEOW_CD


func action_piss():
	if time_piss <= 0:
		print("p")
		#$PissNoise.action_noise()
		emit_signal("piss", zone)
		time_piss = PISS_CD


func _on_interaction_entered(_area):
	emit_signal("interaction_entered")

func _on_interaction_exit(_area):
	emit_signal("interaction_exited")
