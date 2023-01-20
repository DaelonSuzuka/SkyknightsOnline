extends Node

# ******************************************************************************

signal input_event(event)

var state := {}
var mouse_delta = Vector2()
var paused := false

var actions = {
	# misc
	'open_menu': {'key': KEY_QUOTELEFT},
	'settings': {'key': KEY_BACKSLASH},
	'exit': {'key': KEY_ESCAPE},
	# 'console': {'key': KEY_QUOTE_LEFT},
	'free_mouse': {'key': KEY_ALT},
	'toggle_camera_mode': {'key': KEY_T},
	'freelook': {'mouse': BUTTON_MIDDLE},
	'scoreboard': {'key': KEY_TAB},
	'map': {'key': KEY_M},
	'open_chat': {'key': KEY_ENTER},
	'toggle_ship_engine_stats': {'key': KEY_MINUS},
	'minimap_zoom_in': {'mouse': BUTTON_WHEEL_UP},
	'minimap_zoom_out': {'mouse': BUTTON_WHEEL_DOWN},
	# movement
	'throttle_up': {'key': KEY_W},
	'throttle_down': {'key': KEY_S},
	'afterburner': {'key': KEY_SHIFT},
	'pitch_up': {'key': KEY_UP},
	'pitch_down': {'key': KEY_DOWN},
	'yaw_left': {'key': KEY_A},
	'yaw_right': {'key': KEY_D},
	'roll_left': {'key': KEY_Q},
	'roll_right': {'key': KEY_E},
	'vertical_thrust_up': {'key': KEY_SPACE},
	'vertical_thrust_down': {'key': KEY_CONTROL},
	#
	'switch_seat_1': {'key': KEY_F1},
	'switch_seat_2': {'key': KEY_F2},
	'switch_seat_3': {'key': KEY_F3},
	# weapons and items
	'fire_primary': {'mouse': BUTTON_LEFT},
	'fire_secondary': {'mouse': BUTTON_RIGHT},
	'reload': {'key': KEY_R},
	'select_item_1': {'key': KEY_1},
	'select_item_2': {'key': KEY_2},
	'select_item_3': {'key': KEY_3},
	'select_item_4': {'key': KEY_4},
	'select_item_5': {'key': KEY_5},
	'activate_abilty': {'key': KEY_F},
}

# ******************************************************************************

func _ready() -> void:
	# for action in InputMap.get_actions():
	# 	state[action] = false
	# 	actions.append(action)

	get_mouse()
	register_actions()
	get_mouse()

func register(object) -> void:
	if object.has_method('handle_input'):
		connect('input_event', object, 'handle_input')

func register_actions():
	for action in actions:
		var control = actions[action]
		InputMap.add_action(action)

		if 'key' in control:
			var ev = InputEventKey.new()
			ev.scancode = control['key']
			InputMap.action_add_event(action, ev)

		if 'mouse' in control:
			var ev = InputEventMouseButton.new()
			ev.button_index = control['mouse']
			InputMap.action_add_event(action, ev)

		state[action] = false

# ******************************************************************************

func _input(event):
	# use godot events to collect relative mouse movements
	if event is InputEventMouseMotion:
		mouse_delta += event.relative
		
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP:
				var ev = FakeEvent.new('minimap_zoom_in', true)
				emit_signal('input_event', ev)
			BUTTON_WHEEL_DOWN:
				var ev = FakeEvent.new('minimap_zoom_out', true)
				emit_signal('input_event', ev)

func get_mouse():
	var mouse = mouse_delta
	mouse_delta.y = 0
	mouse_delta.x = 0
	return mouse

# ------------------------------------------------------------------------------

func _notification(what) -> void:
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		paused = true
		for action in actions:
			state[action] = false
			var event = FakeEvent.new(action, false)
			emit_signal('input_event', event)
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		paused = false

# ******************************************************************************

func _physics_process(delta) -> void:
	if paused:
		return
	for action in actions:
		if Input.is_action_pressed(action) != state[action]:
			state[action] = Input.is_action_pressed(action)
			var event = FakeEvent.new(action, state[action])
			emit_signal('input_event', event)
