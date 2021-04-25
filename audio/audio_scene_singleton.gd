extends Node


onready var click_sound = $AudioStackingClick
onready var click_sound_accept = $AudioStackingClickA

func play_click():
	if click_sound != null:
		click_sound.play_sound()


func play_ctached_kitty():
	$Catched.play()

func play_click_accepte():
	click_sound_accept.play_sound()
