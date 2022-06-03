extends PanelContainer

var fields = {}

func _ready():
	pass

func set_field(field, value):
	if !(field in fields):
		var label = Label.new()
		fields[field] = label
		$VBox.add_child(label)

	fields[field].text = field + ': ' + value
