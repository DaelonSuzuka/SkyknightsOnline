extends Sprite3D

# ******************************************************************************

export(NodePath) var tracked_object = ''
onready var _tracked_object = get_node_or_null(tracked_object)

# ******************************************************************************

func _process(delta):
	if _tracked_object:
		var angle = _tracked_object.global_transform.basis.get_euler()
		var heading_angle = fmod((angle.y / PI * 180), 360)
		global_rotation = Vector3(0, (heading_angle) * (PI / 180), 0)
