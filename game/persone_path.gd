class_name EnemyPath
extends Enemy


const WAIT_TIME = 0.5

var waiting_time = 0
var waiting = false


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
