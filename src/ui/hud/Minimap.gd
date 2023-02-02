extends Control

# ******************************************************************************

@onready var viewport = $SubViewportContainer/SubViewport
@onready var camera = $SubViewportContainer/SubViewport/Camera3D

var default_size = 3500
var min_size = 1000
var max_size = 5000

var size_step = 100

var big = false

# ******************************************************************************

func _ready() -> void:
	camera.size = default_size

func zoom_in():
	var new_size = camera.size - size_step
	if new_size < min_size:
		new_size = min_size
	camera.size = new_size

func zoom_out():
	var new_size = camera.size + size_step
	if new_size > max_size:
		new_size = max_size
	camera.size = new_size

func toggle_size():
	if big:
		offset_top = -400
		offset_right = 400
		big = false
	else:
		offset_top = -600
		offset_right = 600
		big = true

# ******************************************************************************

var ctx = null
var ctx_pos = null

func dismiss_ctx() -> void:
	if is_instance_valid(ctx):
		ctx.queue_free()
		ctx = null

func handle_input(event):
	dismiss_ctx()

	ctx = ContextMenu.new(self, 'ctx_item_selected')
	ctx.add_item('Set Waypoint')
	ctx.add_item('Clear Waypoints')
	ctx_pos = viewport.get_mouse_position()
	ctx.open(event.position)

var Waypoint = load('res://src/ui/waypoint/Waypoint.tscn')

var waypoints = []

func ctx_item_selected(item):
	match item:
		'Set Waypoint':
			var selection = get_object_under_pos(ctx_pos)

			var waypoint_pos = selection.position
			# waypoint_pos.y = 0
			# print(waypoint_pos)

			var waypoint = Waypoint.instantiate()
			waypoints.append(waypoint)
			Game.world.add_child(waypoint)
			waypoint.position = waypoint_pos
		'Clear Waypoints':

			for waypoint in waypoints:
				Game.world.remove_child(waypoint)
				waypoint.queue_free()
			waypoints.clear()

# ------------------------------------------------------------------------------

# forward input events to the viewport so object picking can work
# func _input(event):
	# if viewport and is_inside_tree():
	# 	viewport.input(event)
		
# func _unhandled_input(event):
# 	if viewport and is_inside_tree():
# 		viewport.unhandled_input(event)

# ******************************************************************************

func get_object_under_mouse():
	var mouse_pos = viewport.get_mouse_position()
	var ray_from = camera.project_ray_origin(mouse_pos)
	var ray_to = ray_from + camera.project_ray_normal(mouse_pos) * 10000
	var space_state = camera.get_world_3d().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to, [], 0x7FFFFFFF, true, true)
	return selection

func get_object_under_pos(pos: Vector2):
	var ray_from = camera.project_ray_origin(pos)
	var ray_to = ray_from + camera.project_ray_normal(pos) * 10000
	var space_state = camera.get_world_3d().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to, [], 0x7FFFFFFF, true, true)
	return selection
