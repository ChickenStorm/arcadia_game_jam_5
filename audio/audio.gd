extends Node

signal building_finished_audio(building)
signal ship_queue_finished_audio(ship_queue)

const AUDIO_SCENE_SINGLETON = preload("res://audio/audio_scene_singleton.tscn")

var sounds = {
	"main_menu":  preload("res://resources/sounds/Dialogue.ogg"),
	"game_1": preload("res://resources/sounds/enJeu.wav"),
	"victory": preload("res://resources/sounds/Victoire.wav"),
	"defaite": preload("res://resources/sounds/Defaite.ogg")
}


var requested_music = "main_menu"

var audio_scene
var node_audio = null

func _init():
	var node = AUDIO_SCENE_SINGLETON.instance()
	add_child(node)
	audio_scene = node
	node_audio = AudioStreamPlayer.new()
	add_child(node_audio)
	node_audio.stream = sounds[requested_music]
	if node_audio.stream is AudioStreamOGGVorbis:
		node_audio.stream.loop = false
		node_audio.stream.loop = false
	node_audio.volume_db = -15
	node_audio.play()
	node_audio.connect("finished", self, "_on_mus_finished")


func _on_mus_finished():
	node_audio.stream = sounds[requested_music]
	node_audio.play()

func play_click():
	audio_scene.play_click()


func play_ctached_kitty():
	audio_scene.play_ctached_kitty()


func building_constructed_audio(building):
	emit_signal("building_finished_audio", building)


func ship_queue_finished_audio(ship_group):
	emit_signal("ship_queue_finished_audio", ship_group)


func set_requested_music(string):
	requested_music = string


func play_click_accepte():
	audio_scene.play_click_accepte()
