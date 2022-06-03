tool
class_name AmmoSource extends Area

export(float) var trigger_delay = 5.0

export(Shape) var shape setget set_shape

func set_shape(new_shape):
	shape = new_shape
	if is_inside_tree():
		$CollisionShape.shape = new_shape

export(Vector3) var offset setget set_offset

func set_offset(new_offset):
	offset = new_offset
	if is_inside_tree():
		$CollisionShape.transform.origin = new_offset

export(Array, NodePath) var ignore
var ignored_bodies = []

var targets = []

func _ready():
	if shape:
		$CollisionShape.shape = shape
		$CollisionShape.transform.origin = offset

	if not Engine.editor_hint:
		for path in ignore:
			ignored_bodies.append(get_node(path))

		connect('body_entered', self, 'on_body_entered')
		connect('body_exited', self, 'on_body_exited')

func on_body_entered(body: Node):
	if !(body in ignored_bodies):
		targets.append(body)

func on_body_exited(body: Node):
	if body in targets:
		targets.erase(body)

var time = 0.0

func _physics_process(delta):
	time += delta
	if time < trigger_delay:
		return
	time = 0

	for target in targets:
		if target.has_method('give_ammo'):
			target.give_ammo()
