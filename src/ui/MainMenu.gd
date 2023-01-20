extends CanvasLayer

# ******************************************************************************

onready var ID = $Panel/Bar/System/NetStatus/ID
onready var Connect = $Panel/Bar/System/Connect
onready var Local = $Panel/Bar/System/Local
onready var Status = $Panel/Bar/System/NetStatus/Status
onready var Ping = $Panel/Bar/System/NetStatus/Ping
onready var Spawn = $Panel/Bar/Spawn
onready var Username = $Panel/Bar/System/NetStatus/Username

# ******************************************************************************

func _ready():
	$Panel/Bar/System/Settings.connect('pressed', Settings, 'toggle_visibility')
	$Panel/Bar/System/Quit.connect('pressed', self, 'quit_pressed')

	$Panel/Bar/System/Connect.disabled = true

	Settings.connect_to('General/Username', self, 'username_changed')

func quit_pressed():
	get_tree().quit()

func username_changed(name):
	Username.text = name
	if name != '':
		$Panel/Bar/System/Connect.disabled = false
	else:
		$Panel/Bar/System/Connect.disabled = true
