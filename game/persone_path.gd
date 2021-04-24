class_name EnemyPath
extends Enemy


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
		if node != null:
			var pts = node.points
			path_node_int = (path_node_int + 1) % pts.size()
			print(path_node_int)
			path_p = _update_navigation_path(self.position, pts[path_node_int])
	path_p = move_along_path(path_p, delta)
	return
