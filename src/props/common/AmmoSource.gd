@tool
class_name AmmoSource extends Area3D

@export var trigger_delay: float = 5.0

@export var shape: Shape3D : set = set_shape

func set_shape(new_shape):
	shape = new_shape
	if is_inside_tree():
		$CollisionShape3D.shape = new_shape

@export var offset: Vector3 : set = set_offset

func set_offset(new_offset):
	offset = new_offset
	if is_inside_tree():
		$CollisionShape3D.transform.origin = new_offset

@export var ignore : Array[NodePath] = [] # (Array, NodePath)
var ignored_bodies = []

var targets = []

func _ready():
	if shape:
		$CollisionShape3D.shape = shape
		$CollisionShape3D.transform.origin = offset

	if not Engine.is_editor_hint():
		for path in ignore:
			ignored_bodies.append(get_node(path))

		connect('body_entered',Callable(self,'on_body_entered'))
		connect('body_exited',Callable(self,'on_body_exited'))

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
