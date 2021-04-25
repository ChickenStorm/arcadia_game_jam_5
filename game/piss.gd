extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished():
	queue_free()
