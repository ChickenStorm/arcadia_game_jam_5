class_name EnemyStand
extends Enemy


const WAIT_TIME = 6

var waiting_time = 0
var waiting = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var path_node_ref = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _move(delta):
	if path_p == null or path_p.size() == 0:
		var node = get_node(path_node)
		if node != null and waiting and waiting_time <= 0 :
			stop_playing_anim_desk()
			stop_playing_anim_canape()
			var pts = node.points
			path_node_int = (path_node_int + 1) % pts.size()
			waiting = false
			path_p = _update_navigation_path(self.position, pts[path_node_int])
		elif not waiting:
			var pts = node.points
			var close = false
			for pt in pts:
				close = close or self.position.distance_to(pt) < 30
			if close:
				if path_node_int == 0:
					start_playing_anim_desk()
				else:
					start_playing_anim_canape()
			waiting = true
			waiting_time = WAIT_TIME
		else:
			waiting_time -= delta
	else:
		path_p = move_along_path(path_p, delta, speed_factor)


func start_playing_anim_desk():
	$"../Obstacle/Room2/Desk".play_anim()
	var node = get_node(path_node_ref)
	self.position = node.points[0]
	self.rotation = PI/2
	$AnimatedSprite.visible = false


func start_playing_anim_canape():
	$"../Obstacle/Room2/Canape".play_anim()
	$AnimatedSprite.visible = false
	var node = get_node(path_node_ref)
	self.position = node.points[1]
	self.rotation = 0


func stop_playing_anim_desk():
	$AnimatedSprite.visible = true
	if $"../Obstacle/Room2/Desk".is_playing:
		self.position = get_node(path_node).points[0]
	$"../Obstacle/Room2/Desk".static_sprite()

func stop_playing_anim_canape():
	$AnimatedSprite.visible = true
	if $"../Obstacle/Room2/Canape".is_playing:
		self.position = get_node(path_node).points[1]
	$"../Obstacle/Room2/Canape".static_sprite()


func _set_inspect_sound(new_bool):
	._set_inspect_sound(new_bool)
	if inspect_sound:
		stop_playing_anim_desk()
		stop_playing_anim_canape()


func set_see_cat(new_bool):
	if new_bool == see_cat:
		return # we do nothing, we want to register state chnage
	.set_see_cat(new_bool)
	stop_playing_anim_desk()
	stop_playing_anim_canape()


func _on_noise(area):
	if not see_cat:
		var check_noise_type = area.noise_type if area.get("noise_type") != null else ""
		# cannot heat the meow he is imeownue
		if check_noise_type != "meow":
			noise_type = check_noise_type
			inspect_time_next = area.time_distraction if area.get("time_distraction") != null else 3
			color_rect.color = Color(255, 255, 0)
			self.inspect_sound = true
			has_inspected = false
			path_p = PoolVector2Array([])
			path_sound = _update_navigation_path(self.position, area.get_parent().position)
