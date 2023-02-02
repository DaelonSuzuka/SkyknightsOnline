extends Control

# ******************************************************************************

@onready var viewport = $SubViewportContainer/SubViewport
@onready var camera = $SubViewportContainer/SubViewport/Camera3D

var default_size = 5000
var min_size = 1000
var max_size = 10000

var size_step = 100

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

# ******************************************************************************

var mouse_start_pos: Vector2
var camera_start_pos: Vector2
var dragging := false


func handle_input(event):
	pass

# forward input events to the viewport so object picking can work
func _input(event):
	# if viewport and is_inside_tree():
	# 	viewport.input(event)

	if !visible:
		return
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if event.pressed:
					mouse_start_pos = event.position
					camera_start_pos = Vector2(camera.position.x, camera.position.z)
					dragging = true
				else:
					dragging = false
					if mouse_start_pos == event.position:
						pass
			MOUSE_BUTTON_WHEEL_UP:
				zoom_in()
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom_out()

	elif event is InputEventMouseMotion and dragging:
		var x = (mouse_start_pos - event.position)
		var new_pos = camera_start_pos + x

		camera.position.x = new_pos.x
		camera.position.z = new_pos.y

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
