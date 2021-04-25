class_name Noise
extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var time_distraction = 3
export(String) var noise_type = ""

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func action_noise():
	if timer != null:
		self.monitorable = true
		timer.start()

func _on_timeout():
	self.monitorable = false
