class_name EnemyStand
extends Enemy


const WAIT_TIME = 2

var waiting_time = 0
var waiting = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _move(delta):
	if path_p == null or path_p.size() == 0:
		var node = get_node(path_node)
		if node != null and waiting and waiting_time <= 0 :
			var pts = node.points
			path_node_int = (path_node_int + 1) % pts.size()
			waiting = false
			path_p = _update_navigation_path(self.position, pts[path_node_int])
		elif not waiting:
			waiting = true
			waiting_time = WAIT_TIME
		else:
			waiting_time -= delta
	path_p = move_along_path(path_p, delta, speed_factor)
	

func _on_noise(area):
	if not see_cat:
		var check_noise_type = area.noise_type if area.get("noise_type") != null else ""
		# cannot heat the meow he is imeownue
		if noise_type != "meow":
			noise_type = check_noise_type
			inspect_time_next = area.time_distraction if area.get("time_distraction") != null else 3
			color_rect.color = Color(255, 255, 0)
			inspect_sound = true
			has_inspected = false
			path_p = PoolVector2Array([])
			path_sound = _update_navigation_path(self.position, area.get_parent().position)
