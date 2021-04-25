extends Node2D

var is_playing = false

func play_anim():
	is_playing = true
	$AnimatedSprite.animation = "Anim"
	$Chair/Sprite.visible = false

func static_sprite():
	is_playing = false
	$AnimatedSprite.animation = "default"
	$Chair/Sprite.visible = true
