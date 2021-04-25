class_name IteractionText
extends Interact

# warning-ignore-all:return_value_discarded

signal interaction_dialogue(string)

export(String, MULTILINE) var text = ""

func action():
	emit_signal("interaction_dialogue", text)
