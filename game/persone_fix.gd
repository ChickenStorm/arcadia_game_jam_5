class_name EnemyFix
extends Enemy

const ROT_TIME_MIN = 0.3
const ROT_TIME_MAX = 3
const SPEED_ROT = 3

var angle_target = 0
var rot_time = 0

func _move(delta):
	if self.path_p == null or self.path_p.size() == 0:
		var node = self.get_node(self.path_node)
		if node != null:
			var pts = node.points
			if self.position.distance_to(pts[0]) > 20:
				path_p = _update_navigation_path(self.position, pts[0])
				$AnimatedSprite.animation = "play"
			else:
				if rot_time < 0:
					rot_time = rng.randf_range(ROT_TIME_MIN, ROT_TIME_MAX)
					angle_target += rng.randf_range(-PI, PI)
				else:

					rot_time -= delta
					if abs(self.rotation - angle_target) > delta * SPEED_ROT:
						self.rotation -= sign(self.rotation - angle_target) * delta * SPEED_ROT
					else:
						self.rotation = angle_target
					
	else:
		path_p = move_along_path(path_p, delta, speed_factor)


func _set_inspect_sound(new_bool):
	._set_inspect_sound(new_bool)
	if inspect_sound:
		$AnimatedSprite.animation = "Default"


func set_see_cat(new_bool):
	if new_bool == see_cat:
		return # we do nothing, we want to register state chnage
	.set_see_cat(new_bool)
	if see_cat:
		$AnimatedSprite.animation = "Default"
