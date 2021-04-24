extends KinematicBody2D

const SPEED_FACTOR = 20
const ANGLE_SPEED = 2
const ANGLE_LIMITOR = ANGLE_SPEED * 2.0 / 30.0

var cat = null setget set_cat
var cat_in_area = false
var see_cat = false setget set_see_cat
var inspect_sound = false
var path = null


onready var navigation = $".."
onready var ray = $RayCast2D
onready var vision = $Vision
onready var hearing = $Hearing
onready var color_rect = $ColorRect
# Called when the node enters the scene tree for the first time.
func _ready():
	vision.connect("body_entered", self, "_on_body_entered")
	vision.connect("body_exited", self, "_on_body_exited")
	hearing.connect("area_entered", self, "_on_area_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray != null and cat != null:
		if cat_in_area:
			var vec_cat = cat.position - self.position
			ray.cast_to = vec_cat.rotated(-self.rotation)
			self.see_cat = not ray.is_colliding()
			if see_cat:
				move_and_collide(vec_cat.normalized() * delta * SPEED_FACTOR)
				rotate_to_dir(delta, vec_cat)
		if inspect_sound and path != null:
			var last_pt = self.position
			var remaining_dist = delta * SPEED_FACTOR
			while path.size() > 0:
				var distance = last_pt.distance_to(path[0])
				if remaining_dist < distance:
					move_and_collide(last_pt.linear_interpolate(path[0], remaining_dist / distance) - self.position)
					rotate_to_dir(delta, path[0] - last_pt)
					return
				else:
					remaining_dist -= distance
					last_pt = path[0]
					path.remove(0)


func rotate_to_dir(delta, dir: Vector2):
	var v = Vector2.RIGHT.rotated(self.rotation)
	var angle = v.angle_to(dir)
	if abs(angle) > ANGLE_LIMITOR:
		self.rotate(sign(angle) * ANGLE_SPEED * delta)



func _on_body_exited(area):
	cat_in_area = false
	self.see_cat = false


func _on_body_entered(area):
	cat_in_area = true
	var vec_cat = cat.position - self.position
	ray.cast_to = vec_cat.rotated(-self.rotation)
	#if not ray.is_colliding():
	#	self.see_cat = true


func set_cat(cat_var):
	cat = cat_var
	ray.cast_to = cat.position

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = navigation.get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)


func _on_area_entered(area):
	if not see_cat:
		color_rect.color = Color(255, 255, 0)
		inspect_sound = true
		_update_navigation_path(self.position, area.get_parent().position)



func set_see_cat(new_bool):
	if new_bool == see_cat:
		return # we do nothing, we want to register state chnage
	if new_bool:
		path = null
		inspect_sound = false
		color_rect.color = Color(255, 0, 0)
	else:
		color_rect.color = Color(0, 255, 0)
	see_cat = new_bool
