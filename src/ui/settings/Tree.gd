extends Tree

func _ready():
	columns = 2
	set_hide_root(true)
	set_column_titles_visible(true)
	set_column_title(0, 'Action')
	set_column_title(1, 'Key')

	for action in InputManager.actions:
		var item = create_item()
		item.set_text(0, action)
		if 'key' in InputManager.actions[action]:
			var s = OS.get_scancode_string(InputManager.actions[action]['key'])
			item.set_text(1, s)
		if 'mouse' in InputManager.actions[action]:
			var s = 'Mouse ' + str(InputManager.actions[action]['mouse'])
			item.set_text(1, s)
	connect('button_pressed', self, '_button_pressed')

func _button_pressed(item, col, id):
	print(item, col, id)
