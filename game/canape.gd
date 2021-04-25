extends Node2D

var is_playing = false

func play_anim():
	is_playing = true
	$AnimatedSprite.visible = true

func static_sprite():
	is_playing = false
	$AnimatedSprite.visible = false
