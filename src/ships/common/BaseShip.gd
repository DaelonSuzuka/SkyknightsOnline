extends CharacterBody3D

var data = null

var ship_dir = ''

var seating_diagram = ''
var seating_diagram_outline = ''

var slots = {}
var inventory = {}

var server_transform = Transform3D()
var server_linear_velocity = Vector3()
var server_angular_velocity = Vector3()
var interpolation_active = true

var input_state = {} : set = set_input

var current_weapon = null
var dead = false

@onready var healthbar = $HealthBar
@onready var seats = $Seats
@onready var engine = $Engine

func _ready():
	add_to_group('ships')

	for action in InputManager.actions:
		input_state[action] = false
	input_state['pitch'] = 0.0
	input_state['roll'] = 0.0
	input_state['yaw'] = 0.0

	# if get_tree().get_multiplayer_peer():
	# 	if !is_multiplayer_authority():
	# 		server_transform = transform

func equip(category, item_type, item_name):
	if !(category in slots):
		return
	if !(item_type in slots[category]):
		return
	if !(item_name in slots[category][item_type]):
		return

	if inventory[category][item_type]:
		var prev_item = inventory[category][item_type]
		if prev_item:
			prev_item.queue_free()
		current_weapon = null

	var item_dir = slots[category][item_type][item_name]
	if item_dir == null:
		inventory[category][item_type] = null
		return
	
	var item = load(ship_dir + item_dir).instantiate()
	inventory[category][item_type] = item
	if item_type == 'nosegun':
		$Nosegun.add_child(item)
		current_weapon = item
	if item_type == 'pylons':
		$Pylons.add_child(item)
	if item_type == 'bellygun':
		$Bellygun.add_child(item)

func set_input(input):
	for action in input:
		input_state[action] = input[action]

func kill():
	queue_free()

func _physics_process(delta):
	# if Network.connected:
	# 	if is_multiplayer_authority():
	# 		rset_unreliable('server_transform', transform)
	# 	else:
	# 		if interpolation_active:		
	# 			var scale_factor = 0.1
	# 			var dist = transform.origin.distance_squared_to(server_transform.origin)
	# 			var weight = clamp(pow(2, dist/4) * scale_factor, 0.0, 1.0)
	# 			transform = transform.interpolate_with(server_transform, weight)
	# 		else:
	# 			transform = server_transform

	$Engine.calculate_forces(input_state)

	# this order is important
	rotate_object_local(Vector3.RIGHT, $Engine.data.pitch.current * delta)
	rotate_object_local(Vector3.UP, $Engine.data.yaw.current * delta)
	rotate_object_local(Vector3.FORWARD, $Engine.data.roll.current * delta)

	set_velocity($Engine.data.velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()

	transform = transform.orthonormalized()
