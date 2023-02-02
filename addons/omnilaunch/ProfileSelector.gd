@tool
extends Tree

# ******************************************************************************

var root = null

var items = {}

signal profile_selected(profile_name)
signal profile_renamed(old_name, new_name)
signal profile_created(profile_name)
signal profile_deleted(profile_name)

# ******************************************************************************

func _ready():	
	connect('item_selected', self._profile_selected)
	allow_rmb_select = true
	connect('item_mouse_selected', self._item_mouse_selected)
	connect('item_edited', self._end_rename)

	set_hide_root(true)
	clear_profiles()

func clear_profiles():
	if root:
		root.free()
	items.clear()
	root = create_item()

func set_data(data):
	clear_profiles()
	for p in data.profiles:
		var item = create_profile(p, false)
	items[data.current_profile].select(0)

func create_profile(profile_name, select=true):
	var item = create_item(root)
	items[profile_name] = item
	item.set_text(0, profile_name)
	if select:
		item.select(0)
	return item

func _profile_selected():
	var item = get_selected()
	var current_profile = item.get_text(0)
	emit_signal('profile_selected', current_profile)

func _item_mouse_selected(position, mouse_button_index):
	if mouse_button_index == MOUSE_BUTTON_RIGHT:
		open_context_menu()	

# ******************************************************************************

var ctx = null

func open_context_menu() -> void:
	if ctx:
		ctx.queue_free()
		ctx = null
		
	var pos = get_global_mouse_position()

	ctx = CtxMenu.new(self, 'context_menu_item_selected')
	ctx.add_item('Rename')
	ctx.add_item('Delete')
	ctx.open(pos)
	
func context_menu_item_selected(selection: String) -> void:
	var item = get_selected()
	match selection:
		'Rename':
			_start_rename()
		'Delete':
			_delete_item()

# ------------------------------------------------------------------------------

func _start_rename():
	var item = get_selected()
	if item == null:
		return
	item.set_editable(0, true)
	item.set_meta('old_name', item.get_text(0))
	edit_selected()

func _end_rename():
	var item = get_selected()
	if item == null:
		return
	item.set_editable(0, false)

	var old_name = item.get_meta('old_name')
	var name = item.get_text(0)

	emit_signal('profile_renamed', old_name, name)

# ------------------------------------------------------------------------------

func _delete_item():
	var item = get_selected()
	if item == null:
		return
	var name = item.get_text(0)

	root.remove_child(item)
	item.free()

	root.get_next_visible().select(0)
	emit_signal('profile_deleted', name)

# ******************************************************************************

class CtxMenu:
	extends PopupMenu

	signal item_selected(item, args)

	func _init(obj=null, cb=null):
		# set_hide_on_window_lose_focus(true)

		if obj:
			obj.add_child(self)

		if obj and cb:
			connect('item_selected', Callable(obj, cb))

		connect('index_pressed', self._on_index_pressed)

	func open(pos=null):
		if pos:
			position = pos

		popup()

	func _on_index_pressed(idx, args=[]):
		var item = get_item_text(idx)
		emit_signal('item_selected', item)
