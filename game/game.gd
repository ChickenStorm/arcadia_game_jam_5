extends Node2D

signal scene_requested(scene)

# warning-ignore-all:return_value_discarded

onready var cat = $Cat
onready var persone = $Persone


# Called when the node enters the scene tree for the first time.
func _ready():
	$MainMusic.connect("finished", self, "_on_main_music_finished")
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
			if obs is IteractionText:
				obs.connect("interaction_dialogue", self, "_on_interaction_dialogue")


func _on_main_music_finished():
	$MainMusic.play()


func _on_piss(zone_id):
	print(zone_id)
	if zone_id == 0:
		for p in [persone, $PersoneStand]:
			p.inspect_sound = true
			p.has_inspected = false
			p.path_p = PoolVector2Array([])
			p.path_sound = p._update_navigation_path(p.position, $PersoneFix.position)
			p.noise_type = "piss"
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
	#emit_signal("scene_requested", "game_over_" + string )


func _on_interaction_dialogue(string):
	$CanvasLayer/Hud.add_dialogue(string)
