extends PanelContainer


var fields = {}
var inputs = {}

func get_field(field):
    var data = get_parent().data
    var value = 0.0
    var parts = field.split('.')

    if parts.size() == 2:
        value = data[parts[0]][parts[1]]
    if parts.size() == 3:
        value = data[parts[0]][parts[1]][parts[2]]
    return value

func set_field(field, new_value):
    var value = float(new_value)
    inputs[field].release_focus()
    var data = get_parent().data

    var parts = field.split('.')
    if parts.size() == 2:
        data[parts[0]][parts[1]] = value
    if parts.size() == 3:
        data[parts[0]][parts[1]][parts[2]] = value

func create_labels():
    $Scroll/Items.columns = 4

    for field in fields:
        var label = Label.new()
        label.text = field.lstrip('.')
        $Scroll/Items.add_child(label)

        var value = Label.new()
        fields[field] = value
        $Scroll/Items.add_child(value)
        fields[field].text = str(0.0)

        if field.split('.')[1] in ['current', 'target', 'input']:
            $Scroll/Items.add_child(Label.new())
            $Scroll/Items.add_child(Label.new())
        else:
            var input = LineEdit.new()
            inputs[field] = input
            input.placeholder_text = str(get_field(field))
            $Scroll/Items.add_child(input)
            input.connect('text_entered', self, 'text_entered', [field])

            var reset = Button.new()
            reset.text = 'reset'
            $Scroll/Items.add_child(reset)
            reset.connect('pressed', self, 'reset_pressed', [field, get_field(field)])

func text_entered(value, field):
    set_field(field, value)

func reset_pressed(field, value):
    inputs[field].clear()
    set_field(field, value)

func walk_data(data, prefix):
    for property in data:
        if typeof(data[property]) == TYPE_DICTIONARY:
            walk_data(data[property], prefix + property + '.')
        if typeof(data[property]) == TYPE_REAL:
            fields[prefix + property] = data[property]

func _ready():
    walk_data(get_parent().data, '')
    get_node('../EditButtons/HBox/Copy').connect('pressed', self, 'copy_pressed')
    get_node('../EditButtons/HBox/Paste').connect('pressed', self, 'paste_pressed')

func copy_pressed():
    var out = {}
    for field in fields:
        if inputs[field].text:
            out[field] = float(inputs[field].text)

    OS.set_clipboard(JSON.print(out, '    '))
    get_node('../EditButtons/HBox/Label').text = 'copied to clipboard'
    yield(get_tree().create_timer(2), "timeout")
    get_node('../EditButtons/HBox/Label').text = ''

func paste_pressed():
    var json = JSON.parse(OS.get_clipboard())
    if json.error == OK:
        for field in json.result:
            if field in fields:
                set_field(field, json.result[field])
        get_node('../EditButtons/HBox/Label').text = 'pasted from clipboard'
    else:
        get_node('../EditButtons/HBox/Label').text = 'invalid settings'
    yield(get_tree().create_timer(2), "timeout")
    get_node('../EditButtons/HBox/Label').text = ''

var current_time = 0.0
func _physics_process(delta):
    current_time += delta
    if current_time < .05:
        return

    current_time = 0
    var data = get_parent().data

    for field in fields:
        var parts = field.split('.')
        var value = 0
        if parts.size() == 2:
            value = data[parts[0]][parts[1]]
        if parts.size() == 3:
            value = data[parts[0]][parts[1]][parts[2]]

        fields[field].text = '%0.2f' % value
