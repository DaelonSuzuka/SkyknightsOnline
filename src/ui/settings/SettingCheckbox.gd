extends HBoxContainer

export var setting_name = 'auto'
export var description = ''
export var default_value = false
var value = false setget set_value

signal value_changed(value)

func _ready():
	Settings.register(self)

	if setting_name == 'auto':
		$Name.text = name
	else:
		$Name.text = setting_name

	$Description.text = description

	set_value(default_value)

	$CheckBox.connect('toggled', self, 'toggled')

func emit():
	emit_signal('value_changed', value)

func set_value(new_value):
	value = bool(new_value)
	$CheckBox.pressed = value

func toggled(state):
	value = state
	emit()
