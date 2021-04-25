extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var keys = InputMap.get_action_list("interact")
	if  keys.size() > 0:
		var text_button= Utils.get_label_of_event(keys[0])
		$Label.text = "Appuiez sur %s pour intéragire" % text_button


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
