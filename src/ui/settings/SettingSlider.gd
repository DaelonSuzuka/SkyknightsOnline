extends HBoxContainer

export var setting_name = 'auto'
export var min_value = 0.001
export var max_value = 1.0
export var starting_value = 0.5
var value = 0.5 setget set_value

signal value_changed(value)

func _ready():
    Settings.register(self)

    if setting_name == 'auto':
        $Name.text = name
    else:
        $Name.text = setting_name

    $Slider.min_value = min_value * 1000
    $Slider.max_value = max_value * 1000
    $Slider.value = starting_value * 1000
    $LineEdit.text = str(starting_value)
    $Slider.connect('value_changed', self, 'slider_changed')
    $LineEdit.connect('text_entered', self, 'line_changed')

func set_value(new_value):
    new_value = clamp(new_value, min_value, max_value)
    value = new_value
    $LineEdit.text = str(value)
    $Slider.value = int(value * 1000)

func slider_changed(_value):
    var new_value = float(_value) / 1000
    $LineEdit.text = str(new_value)
    value = new_value
    emit_signal('value_changed', value)

func line_changed(text):
    var new_value = float(text)
    $Slider.value = int(new_value * 1000)
    value = new_value
    emit_signal('value_changed', value)
