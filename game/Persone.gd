class_name Enemy
extends KinematicBody2D

signal touched()

const TOUTCH_RADIUS = 10
const SPEED_SEE_CAT = 300
const ANGLE_SPEED = 2
const DIST_SOUND_INSPECTED = 60
var inspect_time_next = 3
var noise_type = ""

var cat = null setget set_cat
var cat_in_area = false
var see_cat = false setget set_see_cat
var inspect_sound = false
var path_sound = PoolVector2Array([])
var inspected_time = 0
var has_inspected = false

var rng = RandomNumberGenerator.new()

export(float) var speed_factor = 100
export(float) var speed_factor_noise = 100
export(NodePath) var path_node = null
var path_p = PoolVector2Array([]);
var path_node_int = 0

onready var navigation = $".."
onready var ray = $RayCast2D
onready var vision = $Vision
onready var vision_out = $VisionOut
onready var hearing = $Hearing
onready var color_rect = $ColorRect


func _ready():
	vision.connect("body_entered", self, "_on_body_entered")
	vision_out.connect("body_exited", self, "_on_body_exited")
	hearing.connect("area_entered", self, "_on_noise")
	$Toutch.connect("body_entered", self, "_on_touch")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var old_position = self.position
	if ray != null and cat != null:
		if cat_in_area:
			var vec_cat = cat.position - self.position
			ray.cast_to = vec_cat.rotated(-self.rotation)
			if not see_cat:
				# we can't "unsee"
				self.see_cat = not ray.is_colliding()
			if see_cat:
#				if self.position.distance_to(cat.position) < TOUTCH_RADIUS * 8:
#					move_and_collide(vec_cat.normalized() * delta * SPEED_SEE_CAT)
#				else:
#					self.position += vec_cat.normalized() * delta * SPEED_SEE_CAT
				move_and_collide(vec_cat.normalized() * delta * SPEED_SEE_CAT)
				rotate_to_dir(delta, vec_cat)
				play_if_has_moved(old_position, delta)
				return
		if inspect_sound:
			path_sound = move_along_path(path_sound, delta, speed_factor_noise)
			#inspect_sound = (path_sound.size() != 0)
			if path_sound.size() == 0 or \
					(path_sound.size() == 1 \
					and path_sound[0].distance_to(self.position) < DIST_SOUND_INSPECTED):
				if not has_inspected:
					has_inspected = true
					inspected_time = inspect_time_next
					print(inspected_time)
				if inspected_time > 0:
					inspected_time -= delta
				else:
					inspect_sound = false
					has_inspected = false
					color_rect.color = Color(0, 255, 0)
			play_if_has_moved(old_position, delta)
			return
		else:
			_move(delta)
			play_if_has_moved(old_position, delta)


func play_if_has_moved(old_position, delta):
	var has_moved = self.position.distance_to(old_position) > speed_factor / 10 * delta
	if has_moved != $StepSound.playing:
		# we chnage the playing mode only if needed
		$StepSound.playing = has_moved

func _move(delta):
 pass


func move_along_path(path, delta, speed_coef):
	var last_pt = self.position
	var remaining_dist = delta * speed_coef
	while path.size() > 0:
		var distance = last_pt.distance_to(path[0])
		if remaining_dist < distance:
			move_and_collide(last_pt.linear_interpolate(path[0], remaining_dist / distance) - self.position)
			rotate_to_dir(delta, path[0] - last_pt)
			#self.position = last_pt.linear_interpolate(path[0], remaining_dist / distance)
			return path
		else:
			remaining_dist -= distance
			last_pt = path[0]
			#self.position = last_pt
			path.remove(0)
	return path


func rotate_to_dir(delta, dir: Vector2):
	var v = Vector2.RIGHT.rotated(self.rotation)
	var angle = v.angle_to(dir)
	if abs(angle) > ANGLE_SPEED * delta:
		self.rotate(sign(angle) * ANGLE_SPEED * delta)
	else:
		self.rotate(angle)



func _on_body_exited(_area):
	pass
	# we can't "unsee"
	#cat_in_area = false
	#self.see_cat = false


func _on_body_entered(_area):
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
	var path = navigation.get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)
	return path


func _on_noise(area):
	if not see_cat:
		color_rect.color = Color(255, 255, 0)
		inspect_time_next = area.time_distraction if area.get("time_distraction") != null else 3
		noise_type = area.noise_type if area.get("noise_type") != null else ""
		inspect_sound = true
		has_inspected = false
		path_p = PoolVector2Array([])
		path_sound = _update_navigation_path(self.position, area.get_parent().position)


func set_see_cat(new_bool):
	if new_bool == see_cat:
		return # we do nothing, we want to register state chnage
	if new_bool:
		$AlertS.play(0.25)
		path_sound = PoolVector2Array([])
		path_p = PoolVector2Array([])
		inspect_sound = false
		color_rect.color = Color(255, 0, 0)
	else:
		color_rect.color = Color(0, 255, 0)
	see_cat = new_bool


func _on_touch(area):
	if area == cat:
		emit_signal("touched")
