extends PanelContainer

export(String) var text setget set_text

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(text)
	$Timer.connect("timeout", self, "_on_time_out")
	$AnimationPlayer.current_animation = "fade"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_text(t):
	text = t
	$Label.text = text


func _on_time_out():
	$AnimationPlayer.play_backwards()
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")
	


func _on_animation_finished(_animation_name):
	self.queue_free()
