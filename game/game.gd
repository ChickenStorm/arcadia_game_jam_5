extends Node2D

signal scene_requested(scene)

# warning-ignore-all:return_value_discarded

onready var cat = $Cat
onready var persone = $Persone
const PISS = preload("res://game/piss.tscn")

var has_shown_txt_1 = false
var has_shown_txt_2 = false
var has_shown_txt_3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#$MainMusic.connect("finished", self, "_on_main_music_finished")
	persone.cat = cat
	$PersoneFix.cat = cat
	$PersoneStand.cat = cat
	#nav_ploy.navpoly.make_polygons_from_outlines()
	cat.connect("interaction_entered", self, "_on_interaction_entered")
	cat.connect("interaction_exited", self, "_on_interaction_exited")
	cat.connect("piss", self, "_on_piss")
	#$Camera2D.make_current()
	persone.connect("touched", self, "_on_touched", ["mother"])
	$PersoneFix.connect("touched", self, "_on_touched", ["children"])
	$PersoneStand.connect("touched", self, "_on_touched", ["father"])
	for node in $Obstacle.get_children():
		for obs in node.get_children():
			if obs is Interact:
				obs.connect("interaction_dialogue", self, "_on_interaction_dialogue")
			if obs is Plant:
				obs.connect("noise_plant", self, "_on_noise_pant", [obs])
	cat.connect("entered_zone", self, "_on_cat_entered_zone")
	$"Obstacle/Room 3/InteractibleFood".connect("win_game", self, "_on_win_game")
	Audio.set_requested_music("game_1")


func _on_cat_entered_zone(zone):
	match zone:
		0:
			if not has_shown_txt_1:
				has_shown_txt_1 = true
				_on_interaction_dialogue("Félix : Des cubes et des boules et des cubes et des pyramides. Et ensuite c’est moi qu’on emmène chez le médecin.")
		1:
			if not has_shown_txt_2:
				has_shown_txt_2 = true
			_on_interaction_dialogue("Félix : Une pelote de laine. Ils me prennent vraiment pour un crétin s’ils pensent que je vais courir après.")
		2:
			if not has_shown_txt_3:
				has_shown_txt_3 = true
			_on_interaction_dialogue([
				"Mère : Oh oui, il est énorme. Tu n’imagines pas. Son double menton et ses poignets d’amour battent largement celui de ton Pierre. Attends, on parle encore des chats, hein ?",
				"Félix : Mais qu’est-ce qu’elle baragouine celle-là ?",
			])



func _on_noise_pant(plant):
	$PersoneStand.inspect_sound = true
	$PersoneStand.has_inspected = false
	$PersoneStand.path_p = PoolVector2Array([])
	$PersoneStand.path_sound = $PersoneStand._update_navigation_path($PersoneStand.position, plant.position)
	$PersoneStand.inspect_time_next = 3
	$PersoneStand.noise_type = "plant"


func _on_main_music_finished():
	$MainMusic.play()


func _on_piss(zone_id):
	var node = PISS.instance()
	node.position = cat.position
	$Decore.add_child(node)
	if zone_id == 0:
		for p in [persone, $PersoneStand]:
			p.inspect_sound = true
			p.has_inspected = false
			p.path_p = PoolVector2Array([])
			p.path_sound = p._update_navigation_path(p.position, cat.position)
			p.noise_type = "piss"
		_on_interaction_dialogue([
			"Frank : Rah, fichue bête ! Et maintenant tu vas dire que c’est de ma faute peut-être ?",
			"Céline : Marquer son territoire c’est typiquement masculin je te signale.",
			"Henri : Maman ! Félix a encore fait pipi sur mon parquet !",
		])
	else:
		_on_interaction_dialogue([
				"Frank : Rah, fichue bête ! Et maintenant tu vas dire que c’est de ma faute peut-être ?",
				"Céline : Marquer son territoire c’est typiquement masculin je te signale.",
			])
	if zone_id == 1:
		$TimerPissZ1.start()
		$TimerPissZ1.connect("timeout", self, "_on_timer_piss_timeout", [cat.position])
	if zone_id == 2:
		persone.inspect_sound = true
		persone.has_inspected = false
		persone.path_p = PoolVector2Array([])
		persone.path_sound = persone._update_navigation_path(persone.position, cat.position)
		persone.noise_type = "piss"


func _on_timer_piss_timeout(pos):
	$PersoneStand.inspect_sound = true
	$PersoneStand.has_inspected = false
	$PersoneStand.path_p = PoolVector2Array([])
	$PersoneStand.path_sound = $PersoneStand._update_navigation_path($PersoneStand.position, pos)
	$PersoneStand.inspect_time_next = 5
	$PersoneStand.noise_type = "piss"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#$Camera2D.position = cat.position


func _unhandled_input(event):
	pass


func _on_interaction_entered():
	pass
	#$CanvasLayer/Hud/MarginContainer/VBoxContainer/PanelContainer.visible = true


func _on_interaction_exited():
	pass
	#$CanvasLayer/Hud/MarginContainer/VBoxContainer/PanelContainer.visible = false

func _on_touched(string):
	pass
	emit_signal("scene_requested", "game_over_" + string )
	Audio.play_ctached_kitty()


func _on_interaction_dialogue(string):
	if string is String:
		$CanvasLayer/Hud.add_dialogue(string)
	if string is Array:
		var new_str = ""
		for i in string:
			new_str += i + "\n"
		$CanvasLayer/Hud.add_dialogue(new_str)

func _on_win_game():
	emit_signal("scene_requested", "win")
