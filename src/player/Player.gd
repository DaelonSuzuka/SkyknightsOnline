extends Node3D

# ******************************************************************************

var flight_sens = Vector2(1, 1)
var freelook_sens = Vector2(1, 1)
var invert_y = false
var ship = null
var seat = null
var first_person = true
var freelook = false
var capture_mouse = false : get = get_capture_mouse, set = set_capture_mouse
var input_state = {}
var camera_pos = null

# ******************************************************************************

func _ready():
	InputManager.register(self)

	Settings.connect_to('Controls/Mouse/Flight', self, 'flight_sens_changed')
	Settings.connect_to('Controls/Mouse/Freelook', self, 'freelook_sens_changed')
	Settings.connect_to('Controls/Mouse/InvertY', self, 'invert_y_changed')

	update_mouse_capture()
	update_camera_mode()
	# HUD.Radial.connect('item_selected',Callable(self,'radial_item_selected'))

	for action in InputManager.actions:
		input_state[action] = false

func flight_sens_changed(sens):
	if sens:
		flight_sens = Vector2(float(sens), float(sens))

func freelook_sens_changed(sens):
	if sens:
		freelook_sens = Vector2(float(sens), float(sens))

func invert_y_changed(value):
	invert_y = value

func radial_item_selected(id, pos):
	print(id, pos)

# ******************************************************************************

func update_mouse_capture():
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		# HUD.Chat.InputField.release_focus()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_capture_mouse(state):
	capture_mouse = state
	update_mouse_capture()

func get_capture_mouse():
	return capture_mouse

func toggle_mouse_capture(state=1):
	if state:
		capture_mouse = !capture_mouse
		# MainMenu.visible = !capture_mouse
		# HUD.Radial.close_menu()

		update_mouse_capture()

# ******************************************************************************

func update_camera_pos():
	if ship and camera_pos:
		$Camera3D.current = true
		$Camera3D.transform = camera_pos.global_transform

func update_camera_mode():
	if ship:
		camera_pos = ship.seats.get_camera_pos(seat, int(!first_person))
		HUD.Crosshair.visible = first_person

func toggle_camera_mode(state=1):
	if state:
		first_person = !first_person
		update_camera_mode()

# ******************************************************************************

func toggle_ship_engine_editor(state=1):
	if state and ship:
		if ship.engine.editor_visible:
			ship.engine.hide_editor()
		else:
			ship.engine.show_editor()

func set_freelook(state=1):
	freelook = state

	if ship and !freelook:
		ship.seats.reset_freelook(seat)

func switch_seat(new_seat):
	if ship.seats.enter_seat(new_seat, self):
		seat = new_seat
		update_camera_mode()

func enter_ship(new_ship):
	if !new_ship.seats.has_empty_seats():
		return

	if ship:
		leave_ship()
	ship = new_ship

	switch_seat(ship.seats.get_first_empty_seat())

	# update UI stuff
	HUD.show_hud()
	ship.healthbar.hide()
	if ship.current_weapon:
		HUD.WeaponInfo.show()
		if ship.current_weapon.get('crosshair'):
			HUD.Crosshair.texture = load(ship.current_weapon.crosshair)

func leave_ship():
	ship.healthbar.show()
	ship = null

	HUD.hide_hud()

func toggle_menu(state):
	if state:
		if MainMenu.visible:
			MainMenu.hide()
			set_capture_mouse(true)
		else:
			MainMenu.show()
			set_capture_mouse(false)

# func get_object_under_mouse():
# 	var mouse_pos = get_viewport().get_mouse_position()
# 	var camera = get_viewport().get_camera_3d()
# 	var ray_from = camera.project_ray_origin(mouse_pos)
# 	var ray_to = ray_from + camera.project_ray_normal(mouse_pos) * 1000
# 	var space_state = get_world_3d().direct_space_state
# 	var selection = space_state.intersect_ray(ray_from, ray_to, [], 0x7FFFFFFF, true, true)
# 	return selection

var picked = null

func _input(event):
	if capture_mouse or !(event is InputEventMouseButton):
		return
	if event.button_index != MOUSE_BUTTON_RIGHT or !event.pressed:
		return
		
	if HUD.Map.visible:
		HUD.Map.handle_input(event)
		return
	
	var rect = Rect2(HUD.Minimap.position, HUD.Minimap.size)
	if rect.has_point(event.position):
		HUD.Minimap.handle_input(event)
		return

	# var selection = get_object_under_mouse()
	# if 'collider' in selection:
	# 	HUD.Radial.open_menu(get_viewport().get_mouse_position())

func handle_input(event):
	match event.action:
		'toggle_camera_mode':
			toggle_camera_mode(event.pressed)
		'toggle_ship_engine_stats':
			toggle_ship_engine_editor(event.pressed)
		'free_mouse':
			if event.pressed:
				toggle_mouse_capture()
		'freelook':
			set_freelook(event.pressed)
		'open_menu':
			if event.pressed:
				print('menu')
				if MainMenu.visible:
					set_capture_mouse(true)
					MainMenu.hide()
				else:
					set_capture_mouse(false)
					MainMenu.show()
		'scoreboard':
			pass
			# print('scoreboard')
		'toggle_minimap_size':
			if event.pressed and !HUD.Map.visible:
				HUD.Minimap.toggle_size()
		'minimap_zoom_in':
			if !HUD.Map.visible:
				HUD.Minimap.zoom_in()
		'minimap_zoom_out':
			if !HUD.Map.visible:
				HUD.Minimap.zoom_out()
		'map':
			if event.pressed:
				if HUD.Map.visible:
					set_capture_mouse(true)
					HUD.Map.hide()
				else:
					set_capture_mouse(false)
					HUD.Map.show()
		# 'open_chat':
		#     if event.pressed:
		#         print('chat')
		'switch_seat_1':
			if event.pressed:
				switch_seat(0)
		'switch_seat_2':
			if event.pressed:
				switch_seat(1)
		'switch_seat_3':
			if event.pressed:
				switch_seat(2)

var previous_state = {}
var current_time = 0.0

func _physics_process(delta):
	current_time += delta
	var pitch = 0
	var roll = 0
	var mouse_delta = InputManager.get_mouse() * delta

	if MainMenu.visible:
		return

	if capture_mouse:
		pitch = mouse_delta.y * flight_sens.y
		if invert_y:
			pitch *= -1
		roll = mouse_delta.x * flight_sens.x
	else:
		pitch = 0
		roll = 0

	if ship and seat == 0:
		if first_person and freelook and capture_mouse:
			ship.seats.set_freelook(seat, mouse_delta * freelook_sens)
			pitch = 0
			roll = 0

		for action in InputManager.state:
			input_state[action] = InputManager.state[action]

		input_state['fire_primary'] = InputManager.state['fire_primary'] and capture_mouse
		input_state['pitch'] = pitch
		input_state['roll'] = roll
		input_state['yaw'] = 0

		apply_input(input_state)
		# if !Network.connected:
		# 	return

		# var state_diff = {}

		# for action in input_state:
		# 	if action in previous_state:
		# 		pass
		# 	else:
		# 		previous_state[action] = null

		# 	if previous_state[action] != input_state[action]:
		# 		state_diff[action] = input_state[action]
		# 		previous_state[action] = input_state[action]

		# if current_time > 0.5:
		# 	current_time = 0.0
		# 	rpc_unreliable_id(1, 'network_update', input_state)
		# else:
		# 	rpc_unreliable_id(1, 'network_update', state_diff)

@rpc("any_peer", "call_local") func apply_input(input):
	if ship:
		ship.input_state = input

func _process(delta):
	if ship:
		update_camera_pos()
		if ship.current_weapon:
			var weapon = ship.current_weapon

			if weapon.reloading:
				HUD.ReloadIndicator.show()
				HUD.ReloadIndicator.max_value = weapon.reload_time * 100
				HUD.ReloadIndicator.value = weapon.reload_progress * 100
			else:
				HUD.ReloadIndicator.hide()
			HUD.WeaponInfo.weapon_name = weapon.name
			HUD.WeaponInfo.magazine = '%04d' % weapon.magazine
			HUD.WeaponInfo.ammo = '%04d' % weapon.ammo

		var angle = ship.global_transform.basis.get_euler()
		HUD.PitchLadderLeft.material.set_shader_parameter('pitch', angle.x / PI)
		HUD.PitchLadderRight.material.set_shader_parameter('pitch', angle.x / PI)
		HUD.HeadingIndicator.material.set_shader_parameter('heading', -angle.y / PI)
		HUD.HorizonIndicator.rotation = -angle.z / PI * 180

		HUD.Minimap.camera.position.x = ship.position.x
		HUD.Minimap.camera.position.z = ship.position.z

		var heading_angle = fmod((angle.y / PI * 180) + 180, 360)
		HUD.Minimap.camera.rotation_degrees.z = heading_angle

		# HUD.SeatingDiagram.health = ship.get_node('Health').current
