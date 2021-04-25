class_name IteractionText
extends Interact

# warning-ignore-all:return_value_discarded



func action():
	emit_signal("interaction_dialogue", text)
